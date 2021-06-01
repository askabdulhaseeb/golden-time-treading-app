import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import 'package:golden_time_treading_app/Screens/searchAnySignal.dart';
import 'ListTileofForex.dart';

class ForexPageDashboard extends StatefulWidget {
  @override
  _ForexPageDashboardState createState() => _ForexPageDashboardState();
}

class _ForexPageDashboardState extends State<ForexPageDashboard> {
  Stream _signalStream; // stream of signal

  // run before page build
  @override
  void initState() {
    _startSignalStream(); // streaming data from firebase
    super.initState();
  }

  // setup signal streaming
  void _startSignalStream() async {
    _signalStream = await DatabaseMethods().getLiveFeedSignalFromFirebase('');
    setState(() {});
  }

  // fetch new data when user search any signal
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
        SearchAnySignal(onSearch: onSearch), // search signal by name
        // get all avaiable space of screen
        Flexible(
          // show stream data
          child: StreamBuilder(
            stream: _signalStream, // stream init
            builder: (context, snapshot) {
              // show circular progressing indecator whill fetching signlas data
              if (!snapshot.hasData) return CircularProgressIndicator();
              // show signal fetched list
              return ListView.builder(
                // number of signals found on database
                itemCount: snapshot.data.docs.length,
                // one signal detail
                itemBuilder: (context, index) {
                  // one signal info shortcut
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  // cehcking the signals is forex signal or not
                  return (ds['type'] == 'forex')
                      // display Tile of signal
                      ? ListTileOfForex(
                          name: ds['name'],
                          percent: (ds['percent'] + 0.00),
                          price: (ds['price'] + 0.00),
                          high: (ds['high'] + 0.00),
                          low: (ds['low'] + 0.00),
                          isOpen: ds['isOpen'],
                        )
                      //Show nothing if signal is not forex
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
