import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Auth/authMethods.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import 'package:golden_time_treading_app/Screens/showLoadingDialog.dart';

import '../constraints.dart';

class OtherLoginOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(40),
          splashColor: Theme.of(context).primaryColor,
          // Detect the user action
          onTap: () async {
            showLoadingDislog(context);
            User _user = await AuthMethods().signInWithGoogle(context);
            Navigator.of(context).pop();
            if (_user != null) {
              // fetching user data
              DocumentSnapshot myUser =
                  await DatabaseMethods().getUserInfo(_user.uid);
              // check user is admin or simple user
              bool _isAdmin = (myUser.data()['isAdmin'] == null)
                  ? false
                  : myUser.data()['isAdmin'];
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40), // make edges circular
              border: Border.all(
                width: 0.5,
                color: Colors.blueGrey,
              ), // set border color
            ),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(googleIcon), // Google image
                ),
                const SizedBox(width: 10),
                Text('Sign In with Google')
              ],
            ),
          ),
        ),
      ],
    );
  }
}
