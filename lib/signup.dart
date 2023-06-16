import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:AppBar(title: Text('Welcome', 
        style: TextStyle(
        fontSize: 24.0,), 
        ),
        backgroundColor: Color.fromARGB(255, 14, 48, 74),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 0.0),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 SizedBox(height: 40.0,),
                Text('Create Account ', style: 
                TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 35.0,),
                Image(image:
                 AssetImage('Asset/Image/sign.jpg'),),
                SizedBox(height: 29.0,),
                ElevatedButton(onPressed: (){}, child: Text('Continue with Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 33, 62, 95)),),
                SizedBox(height: 29.0,),
                Padding(
               padding: const EdgeInsets.only(left: 30.0, right: 30.0),
               child: TextFormField(
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  hintText: 'Enter your name ',
                  ), 
               ),
             ),
             SizedBox(height: 8.0,),
                Padding(
               padding: const EdgeInsets.only(left: 30.0, right: 30.0),
               child: TextFormField(
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  hintText: 'Enter your email ',
                  ), 
               ),
             ),
             SizedBox(height: 8.0,),
                Padding(
               padding: const EdgeInsets.only(left: 30.0, right: 30.0),
               child: TextFormField(
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  hintText: 'Enter your password ',
                  ), 
               ),
             ),
             SizedBox(height: 20.0,),
              Text('I agree to terms and conditions', style: TextStyle(fontSize: 18.0),),
          
            SizedBox(height: 35.0,),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, '/login');
            }, child: Text(' BACK'), 
            style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 33, 62, 95)),
             ),
              ],
            ),
          ),
        ),
        ),
    );
  }
}