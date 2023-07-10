import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/home.dart';
import 'package:todo_app/mainScreen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/signup.dart';
import 'login.dart';
const primaryColour=Color.fromARGB(255, 14, 48, 74);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Todo());
}

class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Check if Firebase has been initialized
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Firebase has been initialized, navigate to Home
            return const MainScreen();
          } else {
            // Show a loading indicator while Firebase is initializing
            return CircularProgressIndicator();
          }
        },
      ),
      routes: {
        '/login': (context) => Login(),
        '/sign': (context) => SignUp(),
        '/home':(context) => Home(),
      },
      theme: ThemeData(
        primaryColor: primaryColour,
        appBarTheme: AppBarTheme(color: primaryColour),
       //scaffoldBackgroundColor: Color.fromARGB(255, 165, 153, 153),
      ),
    );
  }
}