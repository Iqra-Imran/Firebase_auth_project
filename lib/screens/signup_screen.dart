import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_shield/screens/home_screen.dart';
import 'package:login_shield/screens/login_screen.dart';
import 'package:login_shield/utensils/utils.dart';
import '../reusable_widgets/reusable_button.dart';
import '../styles/text_styles.dart';
import '../utensils/app_images.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool loading = false;

FirebaseAuth _auth = FirebaseAuth.instance;

class _SignupScreenState extends State<SignupScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 150,
                    width: 150,
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
                          controller: firstNameController,
                          decoration: FirstNameFieldInputDecoration,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter First Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: Colors.deepPurple,
                          controller: lastNameController,
                          decoration: LastNameFieldInputDecoration,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Last Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                  loading: loading,
                  title: 'SignUp',
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      _auth
                          .createUserWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString(),
                      )
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                        setState(() {
                          loading = false;
                        });
                      }).onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account!',
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
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'Login',
                          style: LoginTextStyle,
                        ))
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
