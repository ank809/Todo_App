import 'package:flutter/material.dart';
import 'package:todo_app/signup.dart';
import 'login.dart';

 void main(){
  runApp(Todo()); 
 }

 class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    routes: {
        '/': (context) => Login(),  // By default 
        '/login': (context) => Login(),
        '/sign': (context) => SignUp(),
      },
    );
  }

}