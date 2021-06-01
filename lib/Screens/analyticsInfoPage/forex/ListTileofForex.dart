import 'package:flutter/material.dart';
import '../analyticsListTile/centerOfAnalyticsPageListTile.dart';
import '../analyticsListTile/leftOfAnalyticsPageListTile.dart';
import '../analyticsListTile/rightOfAnalyticsPageListTile.dart';

class ListTileOfForex extends StatelessWidget {
  // variables
  final String name;
  final double percent;
  final double price;
  final double high;
  final double low;
  final bool isOpen;

  // constructor
  const ListTileOfForex({
    @required this.name,
    @required this.percent,
    @required this.price,
    @required this.high,
    @required this.low,
    @required this.isOpen,
  });
  // start page
  @override
  Widget build(BuildContext context) {
    // design forex signal tile
    return Card(
      elevation: 5, // shadow
      margin: const EdgeInsets.only(top: 1), // space from top
      // design tile
      child: Container(
        width: double.infinity, // all width avaiable
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 10), // horizantal space
        // align all widgets horzontality
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // space between
          children: [
            // left side of analytic tile
            LeftOfAnalyticsPageListTile(
              title: (name == null) ? '' : name, // name
              persentage: (percent == null) ? 0 : percent, // percentage
            ),
            // center of analyics screen
            CenterOfAnalyticsPageListTile(
              title: (price == null) ? 0 : price, // price
              isOpen: (isOpen == null) ? false : isOpen,
            ),
            // right side of analytic tile
            RightOfAnalyticsPageListTile(
              high: (high == null) ? 0 : high, // profit
              low: (low == null) ? 0 : low, //loss
            ),
          ],
        ),
      ),
    );
  }
}
