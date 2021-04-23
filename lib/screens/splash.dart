import 'dart:async';

import 'package:buyerapp/screens/homepage.dart';
import 'package:buyerapp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance; 

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2500), () {
      if(_auth.currentUser == null){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LogIn()));
     }else{
       Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
     } });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: MediaQuery.of(context).size.height * 0.3,
                image: AssetImage('images/splash.png'),
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
