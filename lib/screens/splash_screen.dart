import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_shield/firestore/firestore_screen.dart';
import 'package:login_shield/screens/home_screen.dart';
import 'package:login_shield/screens/signup_screen.dart';
import 'package:login_shield/utensils/app_images.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
final auth = FirebaseAuth.instance;
final user = auth.currentUser;
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(user != null){
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>FireStoreScreen()));
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
      );
    }else{
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignupScreen()));
       // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
      }
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.logoImage),

        ],
      ),
    );
  }
}
