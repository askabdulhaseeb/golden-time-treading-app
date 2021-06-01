import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Auth/authMethods.dart';
import 'package:golden_time_treading_app/Screens/loginScreen/loginScreen.dart';
import 'package:golden_time_treading_app/adminPanel/screens/liveFeedSignalScreen/liveFeedSignalScreen.dart';
import 'package:golden_time_treading_app/adminPanel/screens/localSignalScreen/localSignalScreen.dart';

class AdminHomeScreen extends StatelessWidget {
  static final routeName = '/AdminHomeScreen';
  @override
  Widget build(BuildContext context) {
    // tab bar list
    List<String> _list = [
      'Local Signals',
      'Live Feed',
    ];
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          // sign out icon button
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // signout from current user auth
              AuthMethods().signOut();
              // move to login screen
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName, (route) => false);
            },
          ),
        ],
      ),
      // List of all the options
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                // go to local signal screen
                Navigator.of(context).pushNamed(LocalSignalScreen.routeName);
              }
              if (index == 1) {
                // show to live feed signal screen
                Navigator.of(context).pushNamed(LiveFeedSignalScreen.routeName);
              }
            },
            child: ListTile(
              title: Text(_list[index]),
              subtitle: Text('Press to move forword'),
            ),
          );
        },
      ),
    );
  }
}
