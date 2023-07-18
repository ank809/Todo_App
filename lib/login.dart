import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential;
  }

  Future<void> sendEmailVerification() async {
    final User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Email Verification'),
          content: Text(
            'A verification email has been sent to ${user.email}. Please verify your email before logging in.',
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
              title: const Text(
                'Welcome',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('Asset/Image/login.png'),
                      width: 400.0,
                      height: 300.0,
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 2.0),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Color.fromARGB(255, 13, 64, 126),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Enter your email or username',
                          labelText: 'Email or username',
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          labelText: 'Password',
                          prefixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      margin: const EdgeInsets.only(right: 80.0, left: 80.0),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2.0,
                              color: Color.fromARGB(255, 49, 43, 43),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'OR',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2.0,
                              color: Color.fromARGB(255, 31, 30, 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(300.0, 50.0),
                      ),
                      onPressed: () {
                        signInWithGoogle();
                      },
                      icon: const Image(
                        image: AssetImage('Asset/Image/google.png'),
                        width: 35.0,
                      ),
                      label: const Text(
                        'Continue with Google',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        backgroundColor: const Color.fromARGB(255, 15, 52, 82),
                      ),
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.length > 8) {
                            await sendEmailVerification();
                            Navigator.pushNamed(context, '/home');
                          }
                          dispose();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'wrong-password') {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Login Error'),
                                content: Text(
                                  'The password entered is incorrect. Please try again.',
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
                          } else {
                            print('Error logging in: $e');
                          }
                        }
                        passwordController.clear();
                      },
                      child: Text(
                        'Login'.toUpperCase(),
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      margin: const EdgeInsets.only(left: 50.0),
                      child: Row(
                        children: [
                          const Text(
                            "Don't have an account ?",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/sign');
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
