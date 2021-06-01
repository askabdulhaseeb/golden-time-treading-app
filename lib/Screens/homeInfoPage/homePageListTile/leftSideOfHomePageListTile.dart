import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Screens/constraints.dart';

class LeftSideOfHomePageListTile extends StatelessWidget {
  // variables
  final String title;
  final double persentage;
  //constructor
  const LeftSideOfHomePageListTile({
    Key key,
    @required this.title,
    @required this.persentage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //design left side of the tile
    return Container(
      // 1/3 of screen width
      width: (MediaQuery.of(context).size.width / 3) - 30,
      padding: const EdgeInsets.all(10.0), // space all around
      // align widgets vertically
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // space evenly
        crossAxisAlignment: CrossAxisAlignment.start, // from start
        children: [
          // show the signal name
          Text(
            '$title', // signal name
            overflow: TextOverflow.ellipsis, // overflow handler
            // text style
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: regular,
            ),
          ),
          // show the signal persentage
          Text(
            '$persentage %', // signal percentage
            overflow: TextOverflow.ellipsis, // text overflow handler
            //text style
            style: TextStyle(
              fontWeight: FontWeight.w600,
              // show green color text is  percentage is +ve other wise red
              color: (persentage >= 0) ? Colors.green : Colors.red,
              fontSize: 16,
              fontFamily: regular,
            ),
          ),
        ],
      ),
    );
  }
}
