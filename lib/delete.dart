import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/home.dart';

class DeletePage extends StatelessWidget {
  final Task task;
  final int index;

   const DeletePage({required this.index, required this.task,});

  void deleteTask(BuildContext context) {
    DatabaseReference reference = FirebaseDatabase.instance.ref().child('todo');
    reference.child(task.title).remove().then((_) {
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
              'Title: ${task.title}',
              style: titlestyle,
            ),
            const SizedBox(height: 16),
            Text(
              'Date & Time: ${task.dateAndtime}',
              style: dt,
            ),
            const SizedBox(height: 16),
            Text(
              'Description: ${task.description}',
              style: descrip,
            ),
            const SizedBox(height: 35.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Restore the task
                    Navigator.pop(context, task);
                  },
                  child: const Icon(Icons.restart_alt),
                ),
                ElevatedButton(
                  onPressed: () => deleteTask(context), // Call the deleteTask function
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
