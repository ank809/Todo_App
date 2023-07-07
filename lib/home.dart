import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:date_time_picker/date_time_picker.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DateTime selectedDateTime;
  final TextEditingController _taskController = TextEditingController();
  List<String> tasks = [];

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTask() {
    String newTask = _taskController.text.trim();
    if (newTask.isNotEmpty) {
      setState(() {
        tasks.add(newTask);
      });
      _taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create your Todo list'),
      ),
      body: Container(
        margin: EdgeInsets.all(25.0),
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Column(
          children: [
            TextField(
              style: hometext,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(),
                hintText: 'Title',
                hintStyle: hometext,
              ),
            ),
            DateTimePicker(
              type: DateTimePickerType.dateTime,
              initialValue: '',
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              icon: Icon(Icons.event),
              dateLabelText: 'Date & Time',
              onChanged: (val) {
                setState(() {
                  selectedDateTime = DateTime.parse(val);
                });
              },
            ),
            Form(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _taskController,
                      decoration: InputDecoration(
                        labelText: 'Enter your tasks',
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                      onPressed: _addTask,
                      child: Text('Add Task'),
                    ),
                      SizedBox(height: 20),
            Expanded( 
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tasks[index]),
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}