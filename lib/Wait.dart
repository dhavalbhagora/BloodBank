import 'dart:async';

import 'package:bloodbank/Home.dart';
import 'package:bloodbank/LoginScreen/login1.dart';
import 'package:bloodbank/Screens/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = 'login';
  static const String KEYLOGIN2 = 'login2';
  @override
  @override
  void initState() {
    // TODO: implement initState
    WhereGoTO();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Center(
          child: Lottie.asset(
            'assets/Animation1.json', // Your Lottie animation path
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void WhereGoTO() async {
    var sharedpref = await SharedPreferences.getInstance();
    var isloggedin = sharedpref.getBool(KEYLOGIN);
    var isloggedin2 = sharedpref.getBool(KEYLOGIN2);
    Timer(Duration(seconds: 3), () {
      if (isloggedin == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminHomePage()));
      } else if (isloggedin2 == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login_option()));
      }
    });
  }
}
