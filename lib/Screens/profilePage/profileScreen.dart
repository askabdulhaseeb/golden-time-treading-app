import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Auth/authMethods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../homeScreen/circularPrifleImage.dart';
import '../liveInfoPage/liveInfoPage.dart';
import '../profilePage/userPersonalInfo.dart';
import '../constraints.dart';

class ProfileScreen extends StatefulWidget {
  static final routeName = '/ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _imageUrl, _displayName;
  _getemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _displayName = prefs.getString('USERDISPLAYNAMEKEY');
      _imageUrl = prefs.getString('USERPROFILEPICKEY'); // get usser image
    });
  }

  @override
  void initState() {
    // get user info before build screen
    _getemail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        title: Text(
          'Profile',
          // text style
          style: TextStyle(
            fontSize: 16,
            fontFamily: regular,
          ),
        ),
        actions: [
          // chat icon button
          IconButton(
            icon: Icon(Icons.message_outlined),
            onPressed: () {
              // go to Live page
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LiveInfoPage.routeName, (route) => true);
            },
          ),
        ],
      ),
      body: FutureBuilder<dynamic>(
          future: AuthMethods().getCurrentUser(), // get current user info
          builder: (context, snapshot) {
            // circular progress indicator while data fetching or not found
            if (!snapshot.hasData) return CircularProgressIndicator();
            // displing data after fatching
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // checking user info found are not
                      (!snapshot.hasData)
                          ? CircularProgressIndicator()
                          // Image found
                          : CircularProfileImage(
                              imageUrl: _imageUrl,
                            ),
                      const SizedBox(width: 10),
                      (!snapshot.hasData)
                          ? CircularProgressIndicator()
                          // user name
                          : Text(
                              _displayName,
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: regular,
                              ),
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  // display user info
                  child: UserPersonalInfo(),
                ),
              ],
            );
          }),
    );
  }
}
