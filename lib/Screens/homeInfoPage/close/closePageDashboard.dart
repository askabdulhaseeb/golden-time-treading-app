import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import '../../homeInfoPage/close/filterClose.dart';
import '../../searchAnySignal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'closeHomePageListTile.dart';
import 'showTotalNumberWonForClosePage.dart';

class ClosePageDashboard extends StatefulWidget {
  @override
  _ClosePageDashboardState createState() => _ClosePageDashboardState();
}

class _ClosePageDashboardState extends State<ClosePageDashboard> {
  Stream _signalStream; // signal stream
  bool _isVIP; // user is VIP?

  // run before page load
  @override
  void initState() {
    _startSignalStream(); // start streaming
    super.initState();
  }

  // stream setup
  void _startSignalStream() async {
    _signalStream = await DatabaseMethods().getLocalSignalFromFirebase('');
    // check user VIP info
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isVIP = prefs.getBool('isVIP');
    });
  }

  // stream signal if user try to search anything
  void onSearch(String search) async {
    _signalStream = await DatabaseMethods().getLocalSignalFromFirebase(search);
    setState(() {});
  }

  // filter signals
  void onDropdownValueChnage(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    // align widgets vertically
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // start from top
      children: [
        ShowTotalNumberForClosePage(total: 243545), // show Totla signals
        SearchAnySignal(onSearch: onSearch), // search signal by name
        // align widgets horizontally
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Signal Filter '), // dropbox title
            FilterClose(onApplyFilter: onDropdownValueChnage), //show dropbox
          ],
        ),
        const SizedBox(height: 8), // space of 8 pixels
        // fill all available space
        Flexible(
          child: StreamBuilder(
            // stream the signal to show real time values
            stream: _signalStream,
            // show streamed data
            builder: (context, snapshot) {
              // show Circular Progress Indicator is data not fetch yet
              if (!snapshot.hasData) return CircularProgressIndicator();
              // show the run time signals list
              return ListView.builder(
                // number of total signals
                itemCount: snapshot.data.docs.length,
                // show one signal data
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  // checking the signal is open signal or not
                  return (ds['isOpen'] == false)
                      ? CloseHomePageListTile(
                          // check the user is vip or not to show not open signals
                          isVIP: (ds['isVIP'] == false)
                              ? true
                              : (ds['isVIP'] == true && _isVIP == false)
                                  ? false
                                  : true,
                          name: ds['name'],
                          percent: (ds['percent'] + 0.00),
                          price: (ds['price'] + 0.00),
                          high: (ds['high'] + 0.00),
                          low: (ds['low'] + 0.00),
                        )
                      // show nothing of signal is not OPEN SIGNAL
                      : Container();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
