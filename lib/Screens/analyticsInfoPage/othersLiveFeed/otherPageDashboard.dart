import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import 'package:golden_time_treading_app/Screens/searchAnySignal.dart';
import 'listTileOfOthers.dart';

class OthersPageDashboard extends StatefulWidget {
  @override
  _OthersPageDashboardState createState() => _OthersPageDashboardState();
}

class _OthersPageDashboardState extends State<OthersPageDashboard> {
  Stream _signalStream; // signal stream

  // run before anything build of this page
  @override
  void initState() {
    _startSignalStream(); // start stream
    super.initState();
  }

  // stream the signal from database
  void _startSignalStream() async {
    _signalStream = await DatabaseMethods().getLiveFeedSignalFromFirebase('');
    setState(() {});
  }

  // STREAM WHEN USER TRY TO SEARCH ANYTHING
  void onSearch(String search) async {
    _signalStream =
        await DatabaseMethods().getLiveFeedSignalFromFirebase(search);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // align widgets vertiaclly
    return Column(
      children: [
        SearchAnySignal(onSearch: onSearch), //search signal by name
        // fill all avaiable space
        Flexible(
          // show stream of all signal
          child: StreamBuilder(
            stream: _signalStream, // stream init
            // show fetched data
            builder: (context, snapshot) {
              // show CircularProgressIndicator untill data required fetched
              if (!snapshot.hasData) return CircularProgressIndicator();
              // show fetched data in list
              return ListView.builder(
                // number of signal in database
                itemCount: snapshot.data.docs.length,
                // info of a signal
                itemBuilder: (context, index) {
                  // signal info shortcut
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  // checking the signals or others or not
                  return (ds['type'] == 'others')
                      // list of all other signals
                      ? ListTileOfOthers(
                          name: ds['name'],
                          percent: (ds['percent'] + 0.00),
                          price: (ds['price'] + 0.00),
                          high: (ds['high'] + 0.00),
                          low: (ds['low'] + 0.00),
                          isOpen: ds['isOpen'],
                        )
                      // show nothing if the signal is not other
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
