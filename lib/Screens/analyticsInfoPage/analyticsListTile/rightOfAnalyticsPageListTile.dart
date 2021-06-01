import 'package:flutter/material.dart';

class RightOfAnalyticsPageListTile extends StatelessWidget {
  // variables
  final double high;
  final double low;
  // constructors
  const RightOfAnalyticsPageListTile({
    Key key,
    @required this.high,
    @required this.low,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // design right side of the tile
    return Padding(
      padding: const EdgeInsets.all(10.0), // space all around
      // align widgets vertically
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // vertically equal space
        crossAxisAlignment:
            CrossAxisAlignment.start, // left side from horizontally
        children: [
          // show high price
          Text(
            'High: $high', // profile of signal
            overflow: TextOverflow.ellipsis, // handle overflow
          ),
          // show low price
          Text(
            'Low: $low', // loss of signal
            overflow: TextOverflow.ellipsis, // handle overflow
          )
        ],
      ),
    );
  }
}
