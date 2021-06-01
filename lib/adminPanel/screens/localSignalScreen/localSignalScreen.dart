import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import 'package:golden_time_treading_app/Screens/searchAnySignal.dart';
import 'package:golden_time_treading_app/adminPanel/screens/localSignalScreen/addNewLocalSignal.dart';
import 'package:golden_time_treading_app/adminPanel/screens/localSignalScreen/editLocalSignalScreen/editLocalSignalScreen.dart';

import 'adminLocalSignalTile.dart';

class LocalSignalScreen extends StatefulWidget {
  static final routeName = '/AdminLocalSignalScreen';
  @override
  _LocalSignalScreenState createState() => _LocalSignalScreenState();
}

class _LocalSignalScreenState extends State<LocalSignalScreen> {
  Stream _signalStream; // signal stream

  // page stream setup
  _pageStart() async {
    _signalStream = await DatabaseMethods().getLocalSignalFromFirebase('');
    setState(() {});
  }

  // fetch data from firebase on any search
  void onSearch(String search) async {
    _signalStream = await DatabaseMethods().getLocalSignalFromFirebase(search);
    setState(() {});
  }

  // run before page load
  @override
  void initState() {
    _pageStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        title: Text('Local Signal'),
        actions: [
          // Add local icon button
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // move to add new signals screen
              Navigator.of(context).pushNamed(AddNewLocalSignal.routeName);
            },
          ),
        ],
      ),
      // align widgets vertically
      body: Column(
        children: [
          SearchAnySignal(onSearch: onSearch), // search any signal
          // fill all available space
          Flexible(
            // Start streaming
            child: StreamBuilder(
              stream: _signalStream, // stream init
              // get all the data from stream
              builder: (context, snapshot) {
                // show Circular Progress Indicator while fetching data
                if (!snapshot.hasData) return CircularProgressIndicator();
                // list of all the signals
                return ListView.builder(
                  itemCount: snapshot.data.docs.length, // length of signals
                  // all signals data
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return InkWell(
                      onTap: () {
                        // move to the edit signal screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditLocalSignalScreen(
                              signalID: ds['sid'],
                            ),
                          ),
                        );
                      },
                      // show all info of a signal
                      child: AdminLocalSignalTile(
                        name: ds['name'],
                        percent: (ds['percent'] + 0.00),
                        price: (ds['price'] + 0.00),
                        high: (ds['high'] + 0.00),
                        low: (ds['low'] + 0.00),
                        isOpen: (ds['isOpen'] == null) ? false : ds['isOpen'],
                        isVIP: (ds['isVIP'] == null) ? false : ds['isVIP'],
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
