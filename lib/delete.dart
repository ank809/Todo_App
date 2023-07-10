import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

import 'home.dart';

class DeletePage extends StatefulWidget {
  late final String title;
 late final String description;
 late final String dateAndtime;

   DeletePage({
    Key?key,
    required this.title,
    required this.description,
    required this.dateAndtime,
  }):super(key: key);
  @override
  State<DeletePage> createState() => _DeleteState();
}
class _DeleteState extends State<DeletePage> {
 
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
              style:titlestyle,
            ),
            const SizedBox(height: 16),
            Text(
              'Date & Time: ${widget.dateAndtime}',
              style: dt,
            ),
            const SizedBox(height: 16),
            Row(children: [
              Text(
                'Description: ${widget.description}',
                style: descrip,
              ),
            SizedBox(width: 35.0,),
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
            ],)
            
          ],
        ),
      ),
    );
  }
}