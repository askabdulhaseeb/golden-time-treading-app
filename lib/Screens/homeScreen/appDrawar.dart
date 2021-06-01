import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_time_treading_app/Auth/authMethods.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import '../UpgradeToVIPScreen/UpgradeToVIPScreen.dart';
import '../blogPostScreen/blogPostScreen.dart';
import '../loginScreen/loginScreen.dart';
import '../profilePage/profileScreen.dart';
import '../liveInfoPage/liveInfoPage.dart';
import '../technicalAnalyticsScreen.dart/technicalAnalyticsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constraints.dart';

class AppDrawar extends StatefulWidget {
  @override
  _AppDrawarState createState() => _AppDrawarState();
}

class _AppDrawarState extends State<AppDrawar> {
  String _imageUrl, _displayName;
  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _displayName = prefs.getString('USERDISPLAYNAMEKEY');
      _imageUrl = prefs.getString('USERPROFILEPICKEY'); // get usser image
    });
  }

  @override
  void initState() {
    // To get data before screen build
    _getUserInfo();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Show equal space between all Widget
          children: [
            FutureBuilder<dynamic>(
              future:
                  DatabaseMethods().getUserByEmail(), // getting data real time
              builder: (context, snapshot) {
                // show circular progracing Indicator till data found
                if (!snapshot.hasData) return CircularProgressIndicator();
                // Display data after it was found
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50), // horizantal space of 50 pixcal
                    GestureDetector(
                      // go to profile screem if user click on image
                      onTap: () => Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                              ProfileScreen.routeName, (route) => true),
                      // Design user profile image
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.transparent,
                        backgroundImage: (_imageUrl == null)
                            ? AssetImage(defaultUser)
                            : NetworkImage(_imageUrl),
                      ),
                    ),
                    const SizedBox(height: 10), // horizantal space of 10 pixcal
                    Text(
                      _displayName, // user name
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: regular,
                      ),
                    ),
                    const SizedBox(height: 10), // horizantal space of 10 pixcal
                    Divider(
                      color: Colors.grey,
                    ), // Grey line at the bottom of name
                    // Upgrade to VIP Tile design and functions on press
                    ListTile(
                      leading: Icon(Icons.verified_user), // Starting icon
                      title: Text('Upgrade To VIP'), // title of tile
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            UpgradeToVIPScreen.routeName, (route) => false);
                      },
                    ),
                    // Fundamental & Technical analysis Tile design and functions on press
                    ListTile(
                      leading: Icon(Icons.graphic_eq_rounded),
                      title: Text('Fundamental & Technical analysis'),
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            TechnicalAnalyticsScreen.routeName,
                            (route) => true);
                      },
                    ),
                    // ListTile(
                    //   leading: Icon(Icons.grade_outlined),
                    //   title: Text('Golden Algorithem'),
                    //   onTap: () {
                    //     Navigator.of(context).pushNamedAndRemoveUntil(
                    //         GoldenAlgorithemScreen.routeName, (route) => false);
                    //   },
                    // ),

                    // Live Support Tile design and functions on press
                    ListTile(
                      leading: Icon(Icons.bubble_chart_outlined),
                      title: Text('Live Support'),
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            LiveInfoPage.routeName, (route) => true);
                      },
                    ),
                    // Blogs/News Tile design and functions on press
                    ListTile(
                      leading: Icon(Icons.bento_rounded),
                      title: Text('Blogs/News'),
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            BlogPostScreen.routeName, (route) => true);
                      },
                    ),
                  ],
                );
              },
            ),
            // Signout Tile design and functions on press
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
              onTap: () {
                AuthMethods().signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
