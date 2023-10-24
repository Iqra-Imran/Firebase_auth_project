import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const buttonTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Color(0xffffffff),
);

InputDecoration FirstNameFieldInputDecoration = InputDecoration(
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.deepPurple),
  ),
  errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.circular(20),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.circular(20),
  ),
  hintText: "Enter your First Name",
  prefixIcon: Icon(
    Icons.person_outlined,
    color: Colors.deepPurple,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.circular(20),
  ),
);
InputDecoration LastNameFieldInputDecoration = InputDecoration(
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.deepPurple),
  ),
  errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.circular(20),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.circular(20),
  ),
  hintText: "Enter your First Name",
  prefixIcon: Icon(
    Icons.person_outlined,
    color: Colors.deepPurple,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.circular(20),
  ),
);
InputDecoration EmailFieldInputDecoration = InputDecoration(
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.deepPurple),
  ),
  errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.circular(20),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.circular(20),
  ),
  hintText: "Enter your Email",
  prefixIcon: Icon(
    Icons.email_outlined,
    color: Colors.deepPurple,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.circular(20),
  ),
);
InputDecoration PasswordFieldInputDecoration = InputDecoration(
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.deepPurple),
  ),
  errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.circular(20),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.circular(20),
  ),
  hintText: "Enter your Email",
  prefixIcon: Icon(
    Icons.lock_outline_rounded,
    color: Colors.deepPurple,
  ),
  suffixIcon: Icon(
    Icons.visibility_off,
    color: Colors.deepPurple,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.circular(20),
  ),
);
const AlreadyHaveAccountTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
);
const LoginTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.deepPurple,
);
