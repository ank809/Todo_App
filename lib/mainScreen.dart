import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 180.0,
                  width: 180.0,
                  child: Image(image: 
                  AssetImage('Asset/Image/yellow.png'),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                Column(
                  children: [
                    Image.asset('Asset/Image/main.png'),
                    SizedBox(height: 50.0,),
                    Container(
                      margin: EdgeInsets.only(left:40.0),
                      child: Row(
                        children: [
                          ElevatedButton(onPressed: (){
                            Navigator.pushNamed(context, '/login');
                          }, 
                          child:  Text('LOGIN',
                          style: logstyle,),
                          style: mainbuttonlogin,
                          ),
                          SizedBox(width: 90.0,),
                          ElevatedButton(onPressed: (){
                            Navigator.pushNamed(context, '/sign');
                          }, 
                          child: Text('SIGNUP',
                          style: signstyle,),
                          style: mainbuttonsignup,
                          ),
                            
                        ],
                      ),
                    ),
                  ],
                )
              ],
              ),
          ),
        ),
      ),
    );
  }
}