import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/home.dart';
import 'package:todo_app/signup.dart';
import 'login.dart';
const primaryColour=Color.fromARGB(255, 14, 48, 74);

 void main(){
   WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp();
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
        '/home':(context) => Home(),
      },
      theme: ThemeData(
        primaryColor: primaryColour,
        appBarTheme:AppBarTheme(color:primaryColour,),
      ),
    );
  }

}