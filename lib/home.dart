import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'delete.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class Task {
  String title;
  String description;
  String dateAndtime;

  Task({required this.title, required this.description, required this.dateAndtime});
}

class _HomeState extends State<Home> {
  late DateTime selectedDateTime;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateandtimeController = TextEditingController();
  List<Task> tasks = [];
  late DatabaseReference dbref;
  int editIndex = -1;

  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('todo');
  }

  void clearFields() {
    _titleController.clear();
    _descriptionController.clear();
    _dateandtimeController.clear();
  }
  void navigateToDeletePage(Task task) {
    Navigator.push(
     context,
      MaterialPageRoute(
        builder: (context) => DeletePage(
          title: task.title,
          description: task.description,
          dateAndtime: task.dateAndtime,
        ),
      ),
    ).then((restoredTask) {
    if (restoredTask != null) {
      setState(() {
        tasks.add(restoredTask);
      });
    }
  });
    clearFields();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your Todo list'),
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
                onPressed: () {
                  if (editIndex != -1) {
                    // Update an existing task
                    setState(() {
                      tasks[editIndex].title = _titleController.text;
                      tasks[editIndex].description = _descriptionController.text;
                      tasks[editIndex].dateAndtime = _dateandtimeController.text;
                      editIndex = -1;
                    });
                    clearFields();
                    // Update the task in the database
                    Map<String, dynamic> todos = {
                      'title': tasks[editIndex].title,
                      'description': tasks[editIndex].description,
                      'dateAndtime': tasks[editIndex].dateAndtime,
                    };
                    dbref.child(editIndex.toString()).update(todos);
                    
                    // Clear the fields
                    clearFields();
                  } else {
                    // Create a new task
                    setState(() {
                      tasks.add(Task(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        dateAndtime: _dateandtimeController.text,
                      ));
                      clearFields();
                    });
                  }
                },
                child: Text(editIndex != -1 ? 'Save Changes' : 'Create Task'),
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
                physics: NeverScrollableScrollPhysics(),
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
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              editIndex = index;
                              _titleController.text = task.title;
                              _descriptionController.text = task.description;
                              _dateandtimeController.text = task.dateAndtime;
                            });
                          },
                        ),
                        IconButton(
                          color: Color.fromARGB(255, 214, 31, 18),
                          icon: Icon(Icons.delete),
                          onPressed: () {
                           navigateToDeletePage(task);
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
    );
  }
}
