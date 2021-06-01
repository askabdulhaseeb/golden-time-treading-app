import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Screens/constraints.dart';

class LeftOfAnalyticsPageListTile extends StatelessWidget {
  // variables
  final String title;
  final double persentage;
  // constructor
  const LeftOfAnalyticsPageListTile({
    Key key,
    @required this.title,
    @required this.persentage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // design left side of tile
    return Container(
      // 1/3 of total screen width
      width: (MediaQuery.of(context).size.width / 3) - 30,
      padding: const EdgeInsets.all(10.0), // space all around
      // allign all widgets verticaly
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // equal space verically
        crossAxisAlignment:
            CrossAxisAlignment.start, // show at most left side of screen
        children: [
          // show signal name
          Text(
            '$title', // signal name
            overflow: TextOverflow.ellipsis, // overflow handler
            // text style
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: regular,
            ),
          ),
          // show signal precentage
          Text(
            '$persentage %', // persentage of signal
            overflow: TextOverflow.ellipsis, // overflow of text
            // text style
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: (persentage >= 0) ? Colors.green : Colors.red,
              fontSize: 14,
              fontFamily: regular,
            ),
          ),
        ],
      ),
    );
  }
}
