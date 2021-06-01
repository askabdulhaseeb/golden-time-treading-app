import 'package:flutter/material.dart';

class RightSideOfHomePageListTile extends StatelessWidget {
  // variable
  final double high;
  final double low;
  // constroctor
  const RightSideOfHomePageListTile({
    Key key,
    @required this.high,
    @required this.low,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0), // space all around
      // align widgets verically
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // space evenly
        crossAxisAlignment: CrossAxisAlignment.start, // space from start
        children: [
          // display the high price
          Text(
            'High: $high', // profit
            overflow: TextOverflow.ellipsis, // text overflow handler
          ),
          // displaing the low price
          Text(
            'Low: $low', //loss
            overflow: TextOverflow.ellipsis, // text overflow handler
          )
        ],
      ),
    );
  }
}
