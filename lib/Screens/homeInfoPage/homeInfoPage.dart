import 'package:flutter/material.dart';
import '../liveInfoPage/liveInfoPage.dart';
import '../homeScreen/appDrawar.dart';
import '../UpgradeToVIPScreen/UpgradeToVIPScreen.dart';
import '../homeInfoPage/open/openPageDashboard.dart';
import '../homeInfoPage/close/closePageDashboard.dart';
import '../homeInfoPage/closedTradesDashboard/closedTradesDashboard.dart';
import '../homeInfoPage/openTrades/openTradesDashboard.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../constraints.dart';

class HomeInfoPage extends StatefulWidget {
  @override
  _HomeInfoPageState createState() => _HomeInfoPageState();
}

class _HomeInfoPageState extends State<HomeInfoPage>
    with SingleTickerProviderStateMixin {
  // list of tabs for home page
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Open'),
    Tab(text: 'Close'),
    Tab(text: 'Open Trades'),
    Tab(text: 'Closed Trades'),
  ];
  // bool _isVIP = (SharedPreferenceHelper.isVIP == 'true') ? true : false;
  TabController _tabController;
  bool _isVIP = false;
  String uidd;

  // loading few things before page setup
  @override
  void initState() {
    _setupPage();
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  // get user info before loading page
  _setupPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isVIP = prefs.getBool('isVIP');
      uidd = prefs.getString('USERKEY');
    });
  }

  // run on dispose of the screen
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        // center
        title: Center(
          // align all widgets vertically
          child: Column(
            children: [
              // screen name on appbar
              Text(
                'Signals Dashboard',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: regular,
                ),
              ),
              // check the user is VIP or not
              (_isVIP == true)
                  ? Container()
                  // show the VIP button if user is not VIP
                  : GestureDetector(
                      // move to vip screen
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            UpgradeToVIPScreen.routeName, (route) => false);
                      },
                      // design the vip screen
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ), // space all sided
                        // basic designs
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        // Text for VIP button
                        child: Text(
                          'Be VIP',
                          // text style
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
          // show live support screen page
          IconButton(
            icon: Icon(Icons.message_outlined),
            onPressed: () {
              // move to the live chat screen
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LiveInfoPage.routeName, (route) => true);
            },
          ),
        ],
        // controll the Tabs of TabBarView
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      drawer: AppDrawar(),
      // Design the Tab bar for home page
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          switch (tab.text) {
            case 'Open':
              // show open page
              return OpenPageDashboard();
              break;
            case 'Close':
              // show close page
              return ClosePageDashboard();
              break;
            case 'Open Trades':
              // show Open Trades page
              return OpenTradesDashBoard();
              break;
            case 'Closed Trades':
              // show closed trades page
              return ClosedTradesDashboard();
              break;
          }
        }).toList(),
      ),
    );
  }
}
