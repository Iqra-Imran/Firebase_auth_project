import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_shield/reusable_widgets/reusable_button.dart';
import 'package:login_shield/utensils/utils.dart';
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}
FirebaseAuth auth = FirebaseAuth.instance;
final forgetEmailController = TextEditingController();
class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: forgetEmailController,
              decoration: InputDecoration(
                hintText: 'Enter the email you want a recovery email',
              ),
            ),
            SizedBox(height: 10,),
            ReusableButton(title: 'Get password', ontap: (){
            auth.sendPasswordResetEmail(email: forgetEmailController.text.toString()).
            then((value) {
              Utils().toastMessage('recovery email is sent! Please check your email');
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
            });
            }),
          ],
        ) ,
      ),
    );
  }
}
