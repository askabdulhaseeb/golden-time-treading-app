import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Screens/constraints.dart';
import '../UpgradeToVIPScreen/UpgradeToVIPScreen.dart';
import '../analyticsInfoPage/commodities/commoditiesPageDashboard.dart';
import '../analyticsInfoPage/othersLiveFeed/otherPageDashboard.dart';
import '../homeScreen/appDrawar.dart';
import '../liveInfoPage/liveInfoPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forex/forexPageDashboard.dart';

class AnalyticsInfoPage extends StatefulWidget {
  @override
  _AnalyticsInfoPageState createState() => _AnalyticsInfoPageState();
}

class _AnalyticsInfoPageState extends State<AnalyticsInfoPage>
    with SingleTickerProviderStateMixin {
  // list of tabs to show on analytics page
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Forex'),
    Tab(text: 'Commodities'),
    Tab(text: 'Others'),
  ];

  TabController _tabController; // tab controller
  bool _isVIP = false;
  String uidd;
  // run before page start
  @override
  void initState() {
    _setupPage(); // setup required data
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  // get user basic info from local database
  _setupPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isVIP = prefs.getBool('isVIP');
      uidd = prefs.getString('USERKEY');
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // allow keyborad on screen
      // app bar
      appBar: AppBar(
        // show title in center
        title: Center(
          // align widgets horizontaly
          child: Column(
            children: [
              // page name
              Text(
                'Live Feed',
                // style of page name
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: regular,
                ),
              ),
              // checking the user is VIP or not
              (_isVIP)
                  ? Container()
                  // Show the VIP Button if user is not VIP user
                  : GestureDetector(
                      onTap: () {
                        // move to VIP screen
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            UpgradeToVIPScreen.routeName, (route) => true);
                      },
                      // basic design of button
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6), // spaces
                        // design basic things
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        // show VIP text
                        child: Text(
                          'Be VIP',
                          // style VIP text
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: regular,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        actions: [
          // show iconic button
          IconButton(
            // message screen
            icon: Icon(Icons.message_outlined),
            onPressed: () {
              // move to the live support screen
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LiveInfoPage.routeName, (route) => true);
            },
          ),
        ],
        // contoll the tabs of page
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      drawer: AppDrawar(),
      body: TabBarView(
        controller: _tabController, // contoll the signals
        children: myTabs.map((Tab tab) {
          // final String label = tab.text.toLowerCase();
          switch (tab.text) {
            case 'Forex':
              return ForexPageDashboard(); // Forex Page
              break;
            case 'Commodities':
              return CommoditiesPageDashboard(); //Commodities Page
              break;
            case 'Others':
              return OthersPageDashboard(); // Others signals Page
              break;
          }
        }).toList(),
      ),
    );
  }
}
