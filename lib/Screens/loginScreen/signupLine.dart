import 'package:flutter/material.dart';
import '../signupScreen/signupScreen.dart';
import '../constraints.dart';

class SignUpline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      // To display Text in one line
      mainAxisAlignment:
          MainAxisAlignment.center, // To Display Text center of the screen
      children: [
        Text(
          'Register your account? ',
          style: TextStyle(
            fontFamily: regular,
          ),
        ),
        GestureDetector(
          // go to signup screen
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                SignUpScreen.routeName, (route) => true);
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontFamily: regular,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
