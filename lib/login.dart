import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: 
        Text('Welcome', style: TextStyle(fontSize: 25.0),), 
        backgroundColor: Color.fromARGB(255, 14, 48, 74),),
        drawer: Drawer(backgroundColor: Color.fromARGB(255, 13, 64, 126)),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
               Image(image: AssetImage('Asset/Image/login2.png'),),
               Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 2.0),
                child: Text('Sign In',
                 style: TextStyle(color: Color.fromARGB(255, 13, 64, 126), 
                 fontSize: 30.0,
                  fontWeight: FontWeight.bold, ),
                 ),
                 ),
        
            SizedBox(height: 20.0), // Adds space between the text and text field
                Container(
                  padding: EdgeInsets.only(right:10.0, left: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your email or username ',
                      labelText: 'Email or username ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
            SizedBox(height: 30.0), // Adds space between the text and text field
                Container(
                  padding: EdgeInsets.only(right:10.0, left: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your password ',
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height:20.0),
                Center(
                  child: Text('-- Or login with --'),
                ),
              SizedBox(height: 20.0,),
              Container(
                margin: EdgeInsets.only(left: 50.0),
                child: Row(
                  children: [
                    Text(''' Don't have an account ''', style: TextStyle(fontSize: 16.0),),
                   TextButton(onPressed: (){
                    Navigator.pushNamed(context, '/sign');
                   }, child: Text('Sign In',
                    style: TextStyle(fontSize: 18.0),
                    ),
                    ),
                   
                  ],
                ),
              ),
              SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.mail),
                      label: Text('Email'),
                    ),
                    SizedBox(width: 10.0),
                    
                    // SizedBox(width: 10.0),
                    // ElevatedButton.icon(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.instagram),
                    //   label: Text('Instagram'),
                    //  ),
              
              ],
              
              ),
              ],
          ),
        ),
      ),
    ),
    );
  }
}