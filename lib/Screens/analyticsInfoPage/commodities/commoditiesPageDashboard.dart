import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import 'package:golden_time_treading_app/Screens/searchAnySignal.dart';
import 'listTileOfCommodities.dart';

class CommoditiesPageDashboard extends StatefulWidget {
  @override
  _CommoditiesPageDashboardState createState() =>
      _CommoditiesPageDashboardState();
}

class _CommoditiesPageDashboardState extends State<CommoditiesPageDashboard> {
  Stream _signalStream; // stream the signal

  // this function run before this page build
  @override
  void initState() {
    _startSignalStream();
    super.initState();
  }

  // stream setup
  void _startSignalStream() async {
    _signalStream = await DatabaseMethods().getLiveFeedSignalFromFirebase('');
    setState(() {});
  }

  // fetch new data when user try to search a signal
  void onSearch(String search) async {
    _signalStream =
        await DatabaseMethods().getLiveFeedSignalFromFirebase(search);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // align widgets vertically
    return Column(
      children: [
        SearchAnySignal(onSearch: onSearch), // search signal name
        // take all remaining available screen
        Flexible(
          // show live stream of signal
          child: StreamBuilder(
            stream: _signalStream, // start streaming
            // fetching data from firebase
            builder: (context, snapshot) {
              // while fetching data show Circular Progress Indicator
              if (!snapshot.hasData) return CircularProgressIndicator();
              // when all data fetched from firebase
              return ListView.builder(
                // number of signlas found in firebase
                itemCount: snapshot.data.docs.length,
                // info on one signal
                itemBuilder: (context, index) {
                  // info call shortcut
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  // checking the signals are commodities or not
                  return (ds['type'] == 'commodities')
                      // make a tile to show signal
                      ? ListTileOfCommodities(
                          name: ds['name'],
                          percent: (ds['percent'] + 0.00),
                          price: (ds['price'] + 0.00),
                          high: (ds['high'] + 0.00),
                          low: (ds['low'] + 0.00),
                          isOpen: ds['isOpen'],
                        )
                      // show nothing if type if other then commodities
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
