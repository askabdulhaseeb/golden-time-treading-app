import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../homeInfoPage/homeInfoPage.dart';
import '../profilePage/profileScreen.dart';
import '../liveInfoPage/liveInfoPage.dart';
import '../analyticsInfoPage/analyticsInfoPage.dart';
import 'appDrawar.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/HomeScreenDemo';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    // hide Keyboard if keyboard is on while screen is loading
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomeInfoPage(), // HOme Screen => _currentIndex: 0
    AnalyticsInfoPage(), // Analytics Screen => _currentIndex: 1
    LiveInfoPage(), // Line Screen => _currentIndex: 2
    ProfileScreen(), // Profile Screen => _currentIndex: 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // White backgroud
      drawer: AppDrawar(), // Displayed Drawar at the top left side(by default)
      body: Container(
        child: _widgetOptions
            .elementAt(_currentIndex), // check which screen have to display
      ),
      // Making Bottom Navigating Bar
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true, // Shadow
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) =>
            setState(() => _currentIndex = index), // set the selected option
        // List of Bottom Nevigation Bar Items
        items: <BottomNavyBarItem>[
          // Design Home Button in Bottom Navigation Bar
          BottomNavyBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          // Design Analytics Button in Bottom Navigation Bar
          BottomNavyBarItem(
            icon: const Icon(Icons.show_chart),
            title: const Text('Analytics'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          // Design Live Support Button in Bottom Navigation Bar
          BottomNavyBarItem(
            icon: const Icon(Icons.bubble_chart_outlined),
            title: Text(
              'Live Support',
              style: TextStyle(fontSize: 12),
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          // Design Profile Button in Bottom Navigation Bar
          BottomNavyBarItem(
            icon: const Icon(Icons.account_circle_outlined),
            title: const Text('Profile'),
            activeColor: Colors.green,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
