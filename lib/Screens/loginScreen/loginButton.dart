import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import 'package:golden_time_treading_app/Screens/showLoadingDialog.dart';
import 'package:golden_time_treading_app/adminPanel/screens/homeScreen/adminHomeScreen.dart';
import '../homeScreen/homeScreen.dart';
import 'package:golden_time_treading_app/Auth/authMethods.dart';

import '../constraints.dart';

class LoginButton extends StatefulWidget {
  final String email;
  final String password;
  final Function startLoading;
  final Function endLoading;

  const LoginButton({
    @required this.email,
    @required this.password,
    @required this.startLoading,
    @required this.endLoading,
  });

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // To detect the user action on login button
      onTap: () async {
        // on singl tab
        showLoadingDislog(context); // show loading
        User _user = await AuthMethods().loginWithEmailAndPassword(
            widget.email, widget.password); // Funcation of Database

        Navigator.of(context).pop(); // end loading
        if (_user != null) {
          // if user found
          // fetch user data
          DocumentSnapshot myUser =
              await DatabaseMethods().getUserInfo(_user.uid);
          // check user is admin or not
          bool _isAdmin = (myUser.data()['isAdmin'] == null)
              ? false
              : myUser.data()['isAdmin'];
          (_isAdmin)
              // if user is admin move ot admin panel
              ? Navigator.of(context).pushNamedAndRemoveUntil(
                  AdminHomeScreen.routeName, (route) => false)
              // if user is simple user move to Home screen
              : Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreen.routeName, (route) => false);
        }
      },
      child: Center(
        // To display the LOGIN Button in center
        child: Container(
          // basic designing
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20), // make Border circular
          ),
          height: 40,
          width: 180,
          child: Center(
            // To display the LOGIN in center of button
            child: Text(
              'Login',
              // text style
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: regular,
                fontWeight: FontWeight.w300, // Thin the LOGIN word
              ),
            ),
          ),
        ),
      ),
    );
  }
}
