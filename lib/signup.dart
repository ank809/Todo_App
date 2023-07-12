import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/home.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController= TextEditingController();
  final passwordController= TextEditingController();
   final nameController= TextEditingController();
     @override
  void dispose(){
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Home();
        }
        else{
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
                    controller: nameController,
                    keyboardType: TextInputType.name,
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
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
                   FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text, 
                    password: passwordController.text);
                    dispose();
                 },
                 
                  child: Text('SignUp', 
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
    );
  }
}