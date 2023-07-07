import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title: Text('Welcome', 
        style: TextStyle(
        fontSize: 24.0,), 
        ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 SizedBox(height: 40.0,),
                Text('Create Account ', style: 
                TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 35.0,),
                Image(image:
                 AssetImage('Asset/Image/sign.jpg'),),
                SizedBox(height: 29.0,),
                SizedBox(height: 25.0,),
                Padding(
               padding: const EdgeInsets.only(left: 30.0, right: 30.0),
               child: TextFormField(
                    decoration: InputDecoration(
                   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                  hintText: 'Enter your name ',
                  prefixIcon: Icon(Icons.person),
                  ), 
               ),
             ),
             SizedBox(height: 8.0,),
                Padding(
               padding: const EdgeInsets.only(left: 30.0, right: 30.0),
               child: TextFormField(
                    decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                  hintText: 'Enter your email ',
                  prefixIcon: Icon(Icons.email),
                  ), 
               ),
             ),
             SizedBox(height: 8.0,),
              Padding(
               padding: const EdgeInsets.only(left: 30.0, right: 30.0),
               child: TextFormField(
                    decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                  hintText: 'Enter your password ',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: null,),
                    ),
                  ), 
               ),
             
             SizedBox(height: 28.0,),
             ElevatedButton(onPressed: (){
               Navigator.pushNamed(context, '/home');
             },
              child: Text('Sign-Up', 
              style: TextStyle(fontSize: 18.0),),
              style: ButtonStyle(backgroundColor: 
              MaterialStatePropertyAll(const Color.fromARGB(255, 31, 88, 135),),),
              ),
              ],
            ),
          ),
        ),
        );
  }
}