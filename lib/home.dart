import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:date_time_picker/date_time_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

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

  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('todo');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your Todo list'),
      ),
      body: Container(
        margin: const EdgeInsets.all(25.0),
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: SingleChildScrollView(
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
                dateLabelText: 'Date & Time',style: datetimetext,
                onChanged: (val) {
                  setState(() {
                    selectedDateTime = DateTime.parse(val);
                  });
                },
              ),
              const SizedBox(height: 30.0,),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 43, 36, 36),
                  width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120.0,
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Description',
                        hintStyle: desctext,
                      ),
                    ),
                  ),
                ),),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> todos = {
                    'title': _titleController.text,
                    'description': _descriptionController.text,
                    'dateAndtime': _dateandtimeController.text,
                  };
                  dbref.push().set(todos);
                  setState(() {
                    tasks.add(Task(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      dateAndtime: _dateandtimeController.text,
                    ));
                    _titleController.clear();
                    _descriptionController.clear();
                    _dateandtimeController.clear();
                  });
                },
                child: Icon(Icons.check),
              ),
             const SizedBox(height: 16),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Tasks:',
                  style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold,),
                ),
              ),
              const SizedBox(height: 8),
            Container(
  height: MediaQuery.of(context).size.height * 0.3, // Adjust the height as needed
  width: MediaQuery.of(context).size.width, // Adjust the width as needed
  child: ListView.builder(
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
                // Handle edit button pressed
              },
            ),
            IconButton(
              color: Color.fromARGB(255, 214, 31, 18),
              icon: Icon(Icons.delete),
              onPressed: () {
                // Handle delete button pressed
              },
            ),
            IconButton(
              color: const Color.fromARGB(255, 70, 197, 75),
              icon: Icon(Icons.check),
              onPressed: () {
                // Handle complete button pressed
              },
            ),
          ],
        ),
      );
    },
  ),
),
            ],
          ),
        ),
      ),
    );
  }
} 
