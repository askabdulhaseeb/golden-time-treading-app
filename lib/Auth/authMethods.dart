import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:golden_time_treading_app/Auth/shared_preferences_helper.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import 'package:golden_time_treading_app/adminPanel/screens/homeScreen/adminHomeScreen.dart';
import '../Screens/homeScreen/homeScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // get current user
  getCurrentUser() async {
    return auth.currentUser;
  }

  // sign in with google
  signInWithGoogle(BuildContext context) async {
    try {
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; //firebase auth
      final GoogleSignIn _googleSignIn = GoogleSignIn(); // google sign in

      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn(); // google signin account

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount
              .authentication; //google SignIn Authentication

      /// get user credential from google data
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      // signIn With google Credential
      UserCredential result =
          await _firebaseAuth.signInWithCredential(credential);

      User userDetails = result.user;
      // if user is not null
      if (result != null) {
        bool _isVIP;
        bool _isAdmin;
        //  if new user signin in firebase
        if (result.additionalUserInfo.isNewUser == true) {
          _isVIP = false;
          _isAdmin = false;
        } else {
          // if user data already exist in firebase
          DocumentSnapshot myUser = await FirebaseFirestore.instance
              .collection("users")
              .doc(userDetails.uid)
              .get();

          // check user is VIP or ADMIN
          _isVIP =
              (myUser.data()['isVIP'] == null) ? false : myUser.data()['isVIP'];
          _isAdmin = (myUser.data()['isAdmin'] == null)
              ? false
              : myUser.data()['isAdmin'];
        }
        //
        // Store user data localy
        //
        SharedPreferenceHelper().saveUserEmail(userDetails.email);
        SharedPreferenceHelper().saveUserId(userDetails.uid);
        SharedPreferenceHelper().saveIsVIP(_isVIP);
        SharedPreferenceHelper()
            .saveUserName(userDetails.email.replaceAll("@gmail.com", ""));
        SharedPreferenceHelper().saveIsAdmin(_isAdmin);
        SharedPreferenceHelper().saveDisplayName(userDetails.displayName);
        SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL);

        Map<String, dynamic> userInfoMap = {
          "email": userDetails.email,
          "username": userDetails.email.replaceAll("@gmail.com", ""),
          "name": userDetails.displayName,
          "imgUrl": userDetails.photoURL,
          "isVIP": _isVIP,
          "isAdmin": _isAdmin,
        };

        DatabaseMethods()
            .addUserInfoToDB(userDetails.uid, userInfoMap)
            .then((value) {
          (_isAdmin)
              // if user is admin open admin panel
              ? Navigator.of(context).pushNamedAndRemoveUntil(
                  AdminHomeScreen.routeName, (route) => false)
              // if user is not admin open simple home screen
              : Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreen.routeName, (route) => false);
        });
      }
      return userDetails;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 5,
      );
      return null;
    }
  }

  // fetch user info by username
  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }

  // sign in with email and password
  Future<User> signupWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      // get result from firebase
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final User user = result.user;
      assert(user != null);
      assert(await user.getIdToken() != null);
      // if user's data NOT FOUND in authorization
      if (user != null) {
        Map<String, dynamic> userInfoMap = {
          'email': email,
          'name': name,
          'username': email.replaceAll("@gmail.com", ""),
          'isVIP': false,
          'isAdmin': false,
        };

        DatabaseMethods().addUserInfoToDB(user.uid, userInfoMap);
      }
      return user;
    } catch (e) {
      // is anything goes wrong
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 5,
      );
      return null;
    }
  }

  // Login with Email and Password
  Future<User> loginWithEmailAndPassword(String email, String password) async {
    try {
      // get result from firebase
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final User user = result.user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final User currentUser = FirebaseAuth.instance.currentUser;
      assert(user.uid == currentUser.uid);
      // if User info get from Firebase authorization
      if (user != null) {
        // get user info
        DocumentSnapshot myUser = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

        // check user is VIP or ADMIN
        final bool _isVIP =
            (myUser.data()['isVIP'] == null) ? false : myUser.data()['isVIP'];
        final bool _isAdmin = (myUser.data()['isAdmin'] == null)
            ? false
            : myUser.data()['isAdmin'];
        //
        // Store user data localy
        //
        SharedPreferenceHelper().saveUserEmail(myUser.data()['email']);
        SharedPreferenceHelper().saveUserId(user.uid);
        SharedPreferenceHelper().saveIsVIP(_isVIP);
        SharedPreferenceHelper().saveIsAdmin(_isAdmin);
        SharedPreferenceHelper()
            .saveUserName(user.email.replaceAll("@gmail.com", ""));
        SharedPreferenceHelper().saveDisplayName(myUser.data()['name']);
        SharedPreferenceHelper().saveUserProfileUrl(myUser.data()['imgUrl']);
      }
      return user;
    } catch (e) {
      // show toast if anythings goes wrong
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 4);
      return null;
    }
  }

  // signout user
  Future signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // clear all the data from local database
    prefs.clear();
    SharedPreferenceHelper.userEmailKey = 'USEREMAILKEY';
    // signout the current user
    await auth.signOut();
  }
}
