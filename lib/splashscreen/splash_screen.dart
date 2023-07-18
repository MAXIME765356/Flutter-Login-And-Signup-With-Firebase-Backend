import 'dart:async';

import 'package:flutter/material.dart';
import 'package:users/Asisstance/assistant_method.dart';
import 'package:users/global/global.dart';
import 'package:users/screens/login_screen.dart';

import '../screens/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  startTimer() {

    Timer(Duration(seconds: 3), () async{



     if (await firebaseAuth.currentUser != null) {

       firebaseAuth.currentUser != null ? AssistantMethod.readCurrentOnLineuserInfo(): null;
       Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));


     }

     else {

       Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));

     }

     });

  }


  void initState (){


    super.initState();

    startTimer();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:   Center(

        child: Text(

          "Taxi Booking Cab",

          style: TextStyle(

            fontSize: 40,
            fontWeight: FontWeight.bold,

          ),
        ),

      ),

    );
  }
}
