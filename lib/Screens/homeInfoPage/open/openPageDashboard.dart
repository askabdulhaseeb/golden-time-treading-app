import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import '../../homeInfoPage/open/openHomePageListTile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenPageDashboard extends StatefulWidget {
  @override
  _OpenPageDashboardState createState() => _OpenPageDashboardState();
}

class _OpenPageDashboardState extends State<OpenPageDashboard> {
  Stream _signalStream; // signal stream
  bool _isVIP = false;

  // page init
  @override
  void initState() {
    _startSignalStream(); //start streaming signals
    super.initState();
  }

  // setup signals stream
  void _startSignalStream() async {
    _signalStream = await DatabaseMethods().getLocalSignalFromFirebase('');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isVIP = prefs.getBool('isVIP');
    });
  }

  @override
  Widget build(BuildContext context) {
    // allign widgets vertically
    return Column(
      children: [
        ForexLineInOpenDashboard(), // show Forex Line
        // get all available space of screen
        Flexible(
          // start streaming
          child: StreamBuilder(
            stream: _signalStream, // stream init
            //show fetched data
            builder: (context, snapshot) {
              // show Circular Progress Indicator
              if (!snapshot.hasData) return CircularProgressIndicator();
              // show fetched signal
              return ListView.builder(
                // fetched signal count
                itemCount: snapshot.data.docs.length,
                // info of all signal
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];

                  return (ds['isOpen'] == true)
                      // show Open signals
                      ? OpenHomePageListTile(
                          // show only if user and signals are both VIP
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
                      // show nothing if signal is not OPEN
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

class ForexLineInOpenDashboard extends StatelessWidget {
  const ForexLineInOpenDashboard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // design a container
    return Container(
      width: double.infinity, // get all width
      height: 26,
      padding: const EdgeInsets.all(4), // space all side
      // show basic design
      decoration: BoxDecoration(
        // show border design
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      // show Text FOREX
      child: Text(
        'FOREX',
        textAlign: TextAlign.left, // text alignment
      ),
    );
  }
}
