import 'package:flutter/material.dart';
import '../loginScreen/loginScreen.dart';
import '../constraints.dart';

class LoginLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already has a account? ',
          style: TextStyle(
            fontFamily: regular,
          ),
        ),
        GestureDetector(
          // on tap move to signuo screen
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routeName, (route) => false);
          },
          child: Text(
            'Login',
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
