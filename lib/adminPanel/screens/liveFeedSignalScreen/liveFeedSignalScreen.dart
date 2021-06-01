import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import 'package:golden_time_treading_app/Screens/searchAnySignal.dart';
import 'package:golden_time_treading_app/adminPanel/screens/liveFeedSignalScreen/editLiveFeedSignal/editLiveFeedSignalScreen.dart';
import 'addNewLiveFeedSignal.dart';
import 'adminLiveFeedSignalTile.dart';

class LiveFeedSignalScreen extends StatefulWidget {
  static final routeName = '/LiveFeedSignalScreen';
  @override
  _LiveFeedSignalScreenState createState() => _LiveFeedSignalScreenState();
}

class _LiveFeedSignalScreenState extends State<LiveFeedSignalScreen> {
  Stream _signalStream; // signal stream

  // setup stream
  _pageStart() async {
    _signalStream = await DatabaseMethods().getLiveFeedSignalFromFirebase('');
    setState(() {});
  }

  // new stream after user try any thing
  void onSearch(String search) async {
    _signalStream =
        await DatabaseMethods().getLiveFeedSignalFromFirebase(search);
    setState(() {});
  }

  // start before page setup
  @override
  void initState() {
    _pageStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        title: Text('Live Feed Signal'),
        actions: [
          // Add new Signal Icon Button
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // move to add new signal screen
              Navigator.of(context).pushNamed(AddNewLiveFeedSignal.routeName);
            },
          ),
        ],
      ),
      // align widgets vertically
      body: Column(
        children: [
          SearchAnySignal(onSearch: onSearch), // search signals by user's
          // get all available screen space
          Flexible(
            // strat stream
            child: StreamBuilder(
              stream: _signalStream, //stream init
              // fetch all the signals from firebase
              builder: (context, snapshot) {
                // show Circular Progress Indicator while data fetching
                if (!snapshot.hasData) return CircularProgressIndicator();

                /// list of signals fetch from firebase
                return ListView.builder(
                  itemCount: snapshot.data.docs.length, // length
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return InkWell(
                      onTap: () {
                        // move to edit signal screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // edit live feed signal
                            builder: (context) => EditLiveFeedSignalScreen(
                              sid: ds['sid'],
                            ),
                          ),
                        );
                      },
                      // show the signal
                      child: AdminLiveFeedSignalTile(
                        name: ds['name'],
                        percent: (ds['percent'] + 0.00),
                        price: (ds['price'] + 0.00),
                        high: (ds['high'] + 0.00),
                        low: (ds['low'] + 0.00),
                        type: ds['type'],
                        isOpen: (ds['isOpen'] == null) ? false : ds['isOpen'],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
