import 'package:flutter/material.dart';
import '../../analyticsInfoPage/analyticsListTile/centerOfAnalyticsPageListTile.dart';
import '../../analyticsInfoPage/analyticsListTile/leftOfAnalyticsPageListTile.dart';
import '../../analyticsInfoPage/analyticsListTile/rightOfAnalyticsPageListTile.dart';

class ListTileOfCommodities extends StatelessWidget {
  // variables
  final String name;
  final double percent;
  final double price;
  final double high;
  final double low;
  final bool isOpen;

  // consturctor
  const ListTileOfCommodities({
    @required this.name,
    @required this.percent,
    @required this.price,
    @required this.high,
    @required this.low,
    @required this.isOpen,
  });
  @override
  Widget build(BuildContext context) {
    // design a tile where signal info displayed
    return Card(
      elevation: 5, // shadow
      margin: const EdgeInsets.only(top: 1), // space from top
      // design tile
      child: Container(
        width: double.infinity, // full width
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 10), // horizontal space
        // align widgets horizontal
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // space between all
          children: [
            // left side of anaytics tile
            LeftOfAnalyticsPageListTile(
              title: (name == null) ? '' : name, // signal name
              persentage: (percent == null) ? 0 : percent, // signal percentage
            ),
            // center of analytic tile
            CenterOfAnalyticsPageListTile(
              title: (price == null) ? 0 : price, // signal price
              isOpen: (isOpen == null) ? false : isOpen, //signal is open or not
            ),
            // right side of analyics tile
            RightOfAnalyticsPageListTile(
              high: (high == null) ? 0 : high, // signal profile
              low: (low == null) ? 0 : low, // loss
            ),
          ],
        ),
      ),
    );
  }
}
