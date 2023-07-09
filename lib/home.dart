// import 'package:firebase_core/firebase_core.dart';
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
                dateLabelText: 'Date & Time',
                onChanged: (val) {
                  setState(() {
                    selectedDateTime = DateTime.parse(val);
                  });
                },
              ),
              const SizedBox(height: 30.0,),
              Container(
                height: 120.0,
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    labelText: 'Description',
                  ),
                ),
              ),
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  Task task = tasks[index];
                  return ListTile(
                    title: Text('${task.title} - ${task.dateAndtime}'),
                    subtitle: Text(task.description),
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