import 'package:flutter/material.dart';
import '../../homeInfoPage/homePageListTile/centerOfHomePageListTile.dart';
import '../../homeInfoPage/homePageListTile/leftSideOfHomePageListTile.dart';
import '../../homeInfoPage/homePageListTile/lockedHomePageListTile.dart';
import '../../homeInfoPage/homePageListTile/rightSideOfHomePageListTile.dart';

class OpenHomePageListTile extends StatelessWidget {
  // variable
  final bool isVIP;
  final String name;
  final double percent;
  final double price;
  final double high;
  final double low;

  // constructor
  const OpenHomePageListTile({
    @required this.name,
    @required this.percent,
    @required this.price,
    @required this.high,
    @required this.low,
    @required this.isVIP,
  });

  @override
  Widget build(BuildContext context) {
    // over all design the tile
    return Container(
      width: double.infinity, // all available space in width
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 10), //horizontal space
      // basic design
      decoration: BoxDecoration(
        // border style
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
      // checking the user is VIP or not
      child: (isVIP == true)
          // if Signal is VIP
          // align widgets horizontally
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //space between
              children: [
                // show the left side of tile(name and percentage of signal)
                LeftSideOfHomePageListTile(
                  title: (name == null) ? '' : name,
                  persentage: (percent == null) ? 0 : percent,
                ),
                // show the center of tile(price and isopen or not of signal)
                CenterOfHomePageListTile(
                  title: (price == null) ? 0 : price,
                  isOpen: false,
                ),
                // show the right side of tile(high and low prices of signal)
                RightSideOfHomePageListTile(
                  high: (high == null) ? 0 : high,
                  low: (low == null) ? 0 : low,
                ),
              ],
            )
          // if user is not VIP show the locked tile to the user
          : LockedHomePageListTile(title: (name == null) ? '' : name),
    );
  }
}
