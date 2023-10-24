import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_shield/screens/login_screen.dart';
import 'package:login_shield/screens/splash_screen.dart';

import 'image_picker/image_picker_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      debugShowCheckedModeBanner: false,
      home:  LoginScreen(),
    );
  }
}

