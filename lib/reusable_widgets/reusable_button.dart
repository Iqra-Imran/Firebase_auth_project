import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class ReusableButton extends StatelessWidget {
  String title;
  final VoidCallback ontap;
  final bool loading;

  ReusableButton(
      {super.key,
      required this.title,
      required this.ontap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        child: Center(
            child: loading
                ? CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  )
                : Text(
                    title,
                    style: buttonTextStyle,
                  )),
        height: 50,
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.deepPurple),
      ),
    );
  }
}
