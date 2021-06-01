import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_time_treading_app/adminPanel/screens/homeScreen/adminHomeScreen.dart';
import '../loginScreen/loginScreen.dart';
import '../homeScreen/homeScreen.dart';
import 'package:golden_time_treading_app/Auth/shared_preferences_helper.dart';

import '../constraints.dart';

class SplashScreen extends StatefulWidget {
  static final routeName = '/SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false; // To check wather the user is already login or not

  // TO display the screen after splash page
  _getNewPage() async {
    bool _isAdmin; // to check the user is admin or not
    SharedPreferenceHelper().getIsAdmin().then((value) {
      _isAdmin = value;
    });
    // Checking either user already login or not
    SharedPreferenceHelper().getUserEmail().then((value) async {
      if (value == "USEREMAILKEY" || value == null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      } else {
        String uid = await SharedPreferenceHelper().getUserId();
        bool _isVIP;
        // fetching user updating info
        DocumentSnapshot myUser =
            await FirebaseFirestore.instance.collection("users").doc(uid).get();
        // checking the user is VIP is or not
        _isVIP =
            (myUser.data()['isVIP'] == null) ? false : myUser.data()['isVIP'];
        SharedPreferenceHelper().saveIsVIP(_isVIP);
        // open the admin panel for admin
        if (_isAdmin) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AdminHomeScreen.routeName, (route) => false);
        } else {
          // opening the user panel for simple panel
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // to hide the keyborad if its open
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    Timer(Duration(seconds: 3), () {
      // 3 second of timer for splash screen
      _getNewPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false, // allow keyboard
      // show widgets in center
      body: Center(
        child: Container(
          width: 250,
          //align widgtes in vertically
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.22),
              // Show App Logo
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset(appLogo),
              ),
              // Show app name
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset(appName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
