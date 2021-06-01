import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Auth/shared_preferences_helper.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import '../homeScreen/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpgradeToVIPScreen extends StatefulWidget {
  static final routeName = '/UpgradeToVIP';
  @override
  _UpgradeToVIPScreenState createState() => _UpgradeToVIPScreenState();
}

class _UpgradeToVIPScreenState extends State<UpgradeToVIPScreen> {
  bool _isVIP = false;
  String uidd;

  @override
  void initState() {
    _setupPage(); // setup few things before page load

    super.initState();
  }

  _setupPage() async {
    // get user info from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isVIP = prefs.getBool('isVIP');
      uidd = prefs.getString('USERKEY');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar of the page
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Upgrade To VIP',
            style: TextStyle(
              fontSize: 24,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      // distance from all the sides form the page
      body: Padding(
        padding: const EdgeInsets.all(20),
        // align all widgets in verical direction
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // horizantil/y center
          mainAxisAlignment: MainAxisAlignment.center, // vertically centered
          children: [
            const Text(
              // 'If you upgarde yourself to VIP user you can enjoy add free app and all the signals whould be avilable there for you and you can buy or sale them any time you want.'),
              'Under Maintanene',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const Text('Be our VIP user and enjoy our best services.'),
            SizedBox(height: 30),
            // Show Widgets horizantilly
            Row(
              // equal space between and around the widgets
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  // On Home page button press
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName, (route) => false);
                  },
                  // Home Page Button
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Home Page',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                // show this button if the user if not VIP
                (_isVIP)
                    ? Container() // how nothing
                    // Show Upgrade to VIP button
                    : GestureDetector(
                        // On Upgrade to VIP button Tap
                        onTap: () {
                          SharedPreferenceHelper().saveIsVIP(true);
                          DatabaseMethods().updateUserToVIP(uidd);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              HomeScreen.routeName, (route) => false);
                        },
                        // design Upgrade to VIP button
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green,
                          ),
                          child: Text(
                            'Upgrade to VIP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
