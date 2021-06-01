import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Screens/constraints.dart';

class CenterOfAnalyticsPageListTile extends StatelessWidget {
  // variables
  final double title;
  final bool isOpen;
  // Constuctor
  const CenterOfAnalyticsPageListTile({
    Key key,
    @required this.title,
    @required this.isOpen,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // center okay Analytics of the page
    return Container(
      width: 116,
      padding: const EdgeInsets.all(10.0),
      // write widgets in vertical formate
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // vertically center
        crossAxisAlignment: CrossAxisAlignment.center, // horizantaly center
        children: [
          // show price of the signal
          Text(
            '$title', // signal price
            overflow: TextOverflow
                .ellipsis, // if the sized of screen is small then this will cover it price and handle exceptions
            // Text style
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: regular,
            ),
          ),
          // check the signal is open or not
          (isOpen == true)
              // show open signal button if signal is open
              ? Container(
                  height: 28,
                  width: 90,
                  padding: const EdgeInsets.all(4), // space all around
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // make widget in center
                  child: Center(
                    child: Text(
                      'OPEN SIGNALS',
                      overflow: TextOverflow.ellipsis, // handle overflow text
                      // given style to text
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: regular,
                      ),
                    ),
                  ),
                )
              // empty container
              : Container(),
        ],
      ),
    );
  }
}
