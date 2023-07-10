import 'package:flutter/material.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Welcome',
            style: TextStyle(fontSize: 25.0),
          ),
        ),
        drawer: Drawer(backgroundColor: Color.fromARGB(255, 13, 64, 126)),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image(image: AssetImage('Asset/Image/login.png'),
                width: 400.0,
                height: 300.0, ), 
                SizedBox(height: 20.0,),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 2.0),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      color: Color.fromARGB(255, 13, 64, 126),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.only(right: 10.0, left: 10.0),
                  child: const TextField(
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
                  padding: EdgeInsets.only(right: 10.0, left: 10.0),
                  child: const TextField(
                    keyboardType:TextInputType.visiblePassword ,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.fingerprint),
                      suffixIcon: IconButton(onPressed: null, icon:  Icon(Icons.remove_red_eye,),),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0, ),
                Container(
                margin: EdgeInsets.only(right: 80.0, left: 80.0),
                child: Row(
                  children: [
                    Expanded(child: Divider(thickness: 2.0,color: Color.fromARGB(255, 49, 43, 43),)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child: Text('OR', 
                      style: TextStyle(fontSize: 20.0, ),),
                    ),
                    Expanded(child: Divider(thickness:2.0,color: const Color.fromARGB(255, 31, 30, 30),)),
                  ],
                ),
              ),
                const SizedBox(height: 20.0, ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(300.0, 50.0),
                  ),
                  onPressed: (){},
                  icon: Image(image: AssetImage('Asset/Image/google.png'),width: 35.0,),
                  label: Text('Continue with Google',
                  style: TextStyle(fontSize: 20.0),
                  ),
                  ),
                const SizedBox(height: 20.0, ),
               ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 40),
                  backgroundColor: const Color.fromARGB(255, 15, 52, 82),
                ),
                onPressed: (){
                  Navigator.pushNamed(context, '/home');
                }, 
               child:Text('Login'.toUpperCase(),
               style: TextStyle(fontSize: 20.0),),
                ),
                SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.only(left: 50.0),
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
}