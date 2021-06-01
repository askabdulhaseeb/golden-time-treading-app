import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Screens/constraints.dart';

class CenterOfHomePageListTile extends StatelessWidget {
  // variables
  final double title;
  final bool isOpen;
  // constructor
  const CenterOfHomePageListTile({
    Key key,
    @required this.title,
    @required this.isOpen,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // design center of home signal tile
    return Container(
      width: 116,
      padding: const EdgeInsets.all(10.0), // inside space
      // align widgets vertically
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // vertically centered
        crossAxisAlignment: CrossAxisAlignment.center, // horizonatily centered
        children: [
          // show the price of the signal
          Text(
            '$title', // price of signal
            overflow: TextOverflow.ellipsis, // overflow handler
            // style of text
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: regular,
            ),
          ),
          // checking the signal is open or not for all users
          (isOpen == true)
              // is signal is OPEN
              // show open signal tag if the signal is available to all users
              ? Container(
                  height: 28,
                  width: 90,
                  padding: const EdgeInsets.all(4), // space on all side
                  // basic designing
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // show in the center
                  child: Center(
                    // text OPEN SIGNAL
                    child: Text(
                      'OPEN SIGNALS', // text
                      overflow: TextOverflow.ellipsis, // overflow handler
                      // text style
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: regular,
                      ),
                    ),
                  ),
                )
              // Show Nothing if the signal is NOT OPEN SIGNAL
              : Container(),
        ],
      ),
    );
  }
}
