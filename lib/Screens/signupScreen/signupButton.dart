import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Auth/authMethods.dart';
import 'package:golden_time_treading_app/Screens/showLoadingDialog.dart';
import '../loginScreen/loginScreen.dart';
import '../constraints.dart';

class SignupButton extends StatelessWidget {
  final String name, email, password;
  final Function clearAll;
  const SignupButton({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.clearAll,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // on Tap Signup button
      onTap: () async {
        showLoadingDislog(context); // show Locading circual
        // store user data on Firebase
        User _user = await AuthMethods()
            .signupWithEmailAndPassword(name, email, password);
        Navigator.of(context).pop(); // end loading circual
        // if user found
        if (_user != null) {
          clearAll(); // clean all input text field
          // Move to login page
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        }
      },
      // design Signup button
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 40,
          width: 180,
          child: Center(
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: regular,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
