import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    super.dispose();
  }

  Future<void> _signUpWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Check if user registration is successful
      if (userCredential.user != null) {
        // Send verification email to the registered email address
        await userCredential.user!.sendEmailVerification();

        // Show an alert dialog to inform the user that a verification email has been sent
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Verification Email Sent'),
            content: Text(
              'A verification email has been sent to your registered email address. Please verify your email to continue.',
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );

        // Navigate to the Home screen after successful registration
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      }
    } catch (e) {
      print('Error in signing up: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only(left: 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40.0),
                      Text(
                        'Create Account ',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 35.0),
                      Image(
                        image: AssetImage('Asset/Image/sign.jpg'),
                      ),
                      SizedBox(height: 29.0),
                      SizedBox(height: 25.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            hintText: 'Enter your name ',
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            hintText: 'Enter your email ',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an email';
                            } else if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            hintText: 'Enter your password ',
                            prefixIcon: IconButton(
                              icon: Icon(isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a password';
                            } else if (value.length < 8) {
                              return 'Password should be at least 8 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 28.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _signUpWithEmailAndPassword();
                          }
                        },
                        child: Text(
                          'SignUp',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 31, 88, 135),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
