import 'package:flutter/material.dart';
import '../analyticsListTile/centerOfAnalyticsPageListTile.dart';
import '../analyticsListTile/leftOfAnalyticsPageListTile.dart';
import '../analyticsListTile/rightOfAnalyticsPageListTile.dart';

class ListTileOfOthers extends StatelessWidget {
  // vaiable
  final String name;
  final double percent;
  final double price;
  final double high;
  final double low;
  final bool isOpen;

  // constructor
  const ListTileOfOthers({
    @required this.name,
    @required this.percent,
    @required this.price,
    @required this.high,
    @required this.low,
    @required this.isOpen,
  });
  @override
  Widget build(BuildContext context) {
    // design a tile of other signals
    return Card(
      elevation: 5, // shadow
      margin: const EdgeInsets.only(top: 1), // space from top
      // deisgn tile
      child: Container(
        width: double.infinity, // all avaiable width space
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 10), //horizontal space
        // align widgets horizontaily
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // space between
          children: [
            // left side of the Analytics tile
            LeftOfAnalyticsPageListTile(
              title: (name == null) ? '' : name, //name
              persentage: (percent == null) ? 0 : percent, //percentage
            ),
            // center of the Analytics tile
            CenterOfAnalyticsPageListTile(
              title: (price == null) ? 0 : price, //price
              isOpen: (isOpen == null) ? false : isOpen, // isopen or not
            ),
            // right side of the Analytics tile
            RightOfAnalyticsPageListTile(
              high: (high == null) ? 0 : high, //profit
              low: (low == null) ? 0 : low, //loss
            ),
          ],
        ),
      ),
    );
  }
}
