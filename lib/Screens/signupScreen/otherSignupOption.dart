import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Auth/authMethods.dart';
import '../constraints.dart';

class OtherSignupOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          // on tap to Google Signup button
          onTap: () => AuthMethods().signInWithGoogle(context),
          // design the Google Sign up Button
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(width: 0.5, color: Colors.grey),
            ),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(googleIcon),
                ),
                SizedBox(width: 10),
                Text('Sign up with Google')
              ],
            ),
          ),
        ),
      ],
    );
  }
}
