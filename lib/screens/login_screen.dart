import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_shield/forget_password/forget_password.dart';
import 'package:login_shield/reusable_widgets/reusable_button.dart';
import 'package:login_shield/screens/signup_screen.dart';
import 'package:login_shield/styles/text_styles.dart';
import 'package:login_shield/utensils/app_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_shield/utensils/utils.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
FirebaseAuth _auth = FirebaseAuth.instance;
bool loading = false;
class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void login(){
    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      setState(() {
        loading= false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading= false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 200,
                      width: 200,
                      child: Image.asset(AppImages.logoImage)),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            cursorColor: Colors.deepPurple,
                            controller: emailController,
                            decoration: EmailFieldInputDecoration,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: PasswordFieldInputDecoration,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      )),
                  ReusableButton(
                    title: 'Login',
                    loading: loading,
                    ontap: () {
                      setState(() {
                        loading= true;
                      });
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordScreen()));
                    }, child: Text('Forget password?')),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not have account?',
                        style: AlreadyHaveAccountTextStyle,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                          },
                          child: Text(
                            'SignUp',
                            style: LoginTextStyle,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
