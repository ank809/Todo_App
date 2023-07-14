import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/home.dart';
import 'package:todo_app/constants.dart';

class DeletePage extends StatefulWidget {
  final int index;
  final Task task;

  const DeletePage({required this.index, required this.task});

  @override
  _DeletePageState createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  final dbRef = FirebaseDatabase.instance.reference();
  final users = FirebaseAuth.instance.currentUser;
  List<Task> deletedTasks = [];

  @override
  void initState() {
    super.initState();
    retrieveDeletedTasks();
  }

  void retrieveDeletedTasks() {
    dbRef.child('todo').child(users!.uid).child('deletedTasks').onValue.listen((event) {
      final tasksMap = (event.snapshot.value as Map<dynamic, dynamic>?) ?? {};
      final retrievedDeletedTasks = tasksMap.entries
          .map((entry) => Task(
                title: entry.value['title'],
                description: entry.value['description'],
                dateAndtime: entry.value['dateAndtime'],
                key: entry.key,
              ))
          .toList();
      setState(() {
        deletedTasks = retrievedDeletedTasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deleted Tasks'),
      ),
      body: Container(
        margin: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Deleted Tasks:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: deletedTasks.length,
                itemBuilder: (context, index) {
                  Task task = deletedTasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.dateAndtime),
                    onTap: () {
                      // Restore the task
                      setState(() {
                        deletedTasks.remove(task);
                      });
                      dbRef.child('todo').child(users!.uid).child('deletedTasks').child(task.key).remove();
                      dbRef.child('todo').child(users!.uid).child(task.key).set({
                        'title': task.title,
                        'description': task.description,
                        'dateAndtime': task.dateAndtime,
                      });
                      Navigator.pop(context, task); // Return the restored task to the previous screen
                    },
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
