import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/home.dart';

class DeletePage extends StatefulWidget {
  final String title;
  final String description;
  final String dateAndtime;

  DeletePage({
    Key? key,
    required this.title,
    required this.description,
    required this.dateAndtime,
  }) : super(key: key);

  @override
  State<DeletePage> createState() => _DeleteState();
}

class _DeleteState extends State<DeletePage> {
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('todo');

  void deleteTask() {
    reference.child(widget.title).remove().then((_) {
      // Deletion successful
      Navigator.pop(context, true); // Pass 'true' to indicate successful deletion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Task'),
      ),
      body: Container(
        margin: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${widget.title}',
              style: titlestyle,
            ),
            const SizedBox(height: 16),
            Text(
              'Date & Time: ${widget.dateAndtime}',
              style: dt,
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              child: Row(
                children: [
                  Text(
                    'Description: ${widget.description}',
                    style: descrip,
                  ),
                  const SizedBox(width: 35.0),
                  ElevatedButton(
                    onPressed: () {
                      // Restore the task
                      Navigator.pop(context, Task(
                        title: widget.title,
                        description: widget.description,
                        dateAndtime: widget.dateAndtime,
                      ));
                    },
                    child: Icon(Icons.restart_alt),
                  ),
                  const SizedBox(width: 35.0),
                  ElevatedButton(
                    onPressed: deleteTask, // Call the deleteTask function
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
