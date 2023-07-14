import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/delete.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class Task {
  String title;
  String description;
  String dateAndtime;
  String key;

  Task({
    required this.title,
    required this.description,
    required this.dateAndtime,
    required this.key,
  });
}

class _HomeState extends State<Home> {
  late DateTime selectedDateTime;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateandtimeController = TextEditingController();
  final users = FirebaseAuth.instance.currentUser;
  List<Task> tasks = [];
  late DatabaseReference dbref;
  int editIndex = -1;

  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.reference().child('todo');
    retrieveTasks();
  }

  void retrieveTasks() {
    dbref.child(users!.uid).onValue.listen((event) {
      final tasksMap = (event.snapshot.value as Map<dynamic, dynamic>?) ?? {};
      final retrievedTasks = tasksMap.entries
          .map((entry) => Task(
                title: entry.value['title'],
                description: entry.value['description'],
                dateAndtime: entry.value['dateAndtime'],
                key: entry.key,
              ))
          .toList();
      setState(() {
        tasks = retrievedTasks;
      });
    });
  }

  void clearFields() {
    _titleController.clear();
    _descriptionController.clear();
    _dateandtimeController.clear();
  }

  void navigateToDeletePage(Task task, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Title: ${task.title}'),
            const SizedBox(height: 8),
            Text('Description: ${task.description}'),
            const SizedBox(height: 8),
            Text('Date & Time: ${task.dateAndtime}'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              moveToDeletedTasks(task, index);
            },
            child: const Text('Delete'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

 void moveToDeletedTasks(Task task, int index) {
  // Store the deleted task in the "deletedTasks" node in the database
  dbref.child(users!.uid).child('deletedTasks').push().set({
    'title': task.title,
    'description': task.description,
    'dateAndtime': task.dateAndtime,
  });

  setState(() {
    tasks.removeAt(index);
    clearFields();
  });

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DeletePage(index: index, task: task),
    ),
  ).then((restoredTask) {
    if (restoredTask != null && restoredTask is Task) {
      setState(() {
        tasks.add(restoredTask);
      });
    }
  });
}


  void navigateToDeletedTodos() async {
    final restoredTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeletePage(
          index: -1,
          task: Task(
            title: '',
            description: '',
            dateAndtime: '',
            key: '',
          ),
        ),
      ),
    );

    if (restoredTask != null && restoredTask is Task) {
      setState(() {
        tasks.add(restoredTask);
      });
    }
  }

  void createOrUpdateTask() {
    if (editIndex != -1) {
      // Update an existing task
      setState(() {
        tasks[editIndex].title = _titleController.text;
        tasks[editIndex].description = _descriptionController.text;
        tasks[editIndex].dateAndtime = _dateandtimeController.text;
        String taskKey = tasks[editIndex].key;
        dbref.child(users!.uid).child(taskKey).update({
          'title': tasks[editIndex].title,
          'description': tasks[editIndex].description,
          'dateAndtime': tasks[editIndex].dateAndtime,
        });
        editIndex = -1;
      });
      // Clear the fields
      clearFields();
    } else {
      // Create a new task
      setState(() {
        Task newTask = Task(
          title: _titleController.text,
          description: _descriptionController.text,
          dateAndtime: _dateandtimeController.text,
          key: dbref.child(users!.uid).push().key ?? '', // Generate a unique key
        );
        tasks.add(newTask);
        // Store the task in the database
        dbref.child(users!.uid).child(newTask.key).set({
          'title': newTask.title,
          'description': newTask.description,
          'dateAndtime': newTask.dateAndtime,
        });

        clearFields();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create your Todo list'),
          actions: [
            IconButton(
              onPressed: navigateToDeletedTodos, // Navigate to DeletePage
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 28, 70, 104),
          child: Container(
            margin: const EdgeInsets.only(top: 90.0, left: 25.0, right: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Your Profile', style: profile),
                const SizedBox(height: 20.0),
                Text('${users?.email}', style: username),
                const SizedBox(height: 90.0),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout', style: TextStyle(fontSize: 18.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(25.0),
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  style: hometext,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    hintText: 'Title',
                    hintStyle: hometext,
                  ),
                ),
                DateTimePicker(
                  controller: _dateandtimeController,
                  type: DateTimePickerType.dateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  dateLabelText: 'Date & Time',
                  style: datetimetext,
                  onChanged: (val) {
                    setState(() {
                      selectedDateTime = DateTime.parse(val);
                    });
                  },
                ),
                const SizedBox(height: 30.0),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 43, 36, 36),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 120.0,
                      child: TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Description',
                          hintStyle: desctext,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: createOrUpdateTask,
                  child: Text(editIndex != -1 ? 'Save Changes' : 'Create Task'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 28, 70, 104),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Tasks:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    Task task = tasks[index];
                    return ListTile(
                      title: Text('${task.title} - ${task.dateAndtime}'),
                      subtitle: Text(task.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            color: const Color.fromARGB(255, 30, 94, 206),
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                editIndex = index;
                                _titleController.text = task.title;
                                _descriptionController.text = task.description;
                                _dateandtimeController.text =
                                    task.dateAndtime;
                              });
                            },
                          ),
                          IconButton(
                            color: const Color.fromARGB(255, 214, 31, 18),
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              navigateToDeletePage(task, index);
                              clearFields();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
