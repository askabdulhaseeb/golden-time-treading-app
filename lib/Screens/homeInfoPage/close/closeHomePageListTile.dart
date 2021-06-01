import 'package:flutter/material.dart';
import '../../homeInfoPage/homePageListTile/centerOfHomePageListTile.dart';
import '../../homeInfoPage/homePageListTile/leftSideOfHomePageListTile.dart';
import '../../homeInfoPage/homePageListTile/lockedHomePageListTile.dart';
import '../../homeInfoPage/homePageListTile/rightSideOfHomePageListTile.dart';

class CloseHomePageListTile extends StatelessWidget {
  // variables
  final bool isVIP;
  final String name;
  final double percent;
  final double price;
  final double high;
  final double low;

  // constructor
  const CloseHomePageListTile({
    @required this.isVIP,
    @required this.name,
    @required this.percent,
    @required this.price,
    @required this.high,
    @required this.low,
  });

  @override
  Widget build(BuildContext context) {
    // design home signal list
    return Container(
      width: double.infinity, // all abaiable width
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 10), //horizontal space
      // design signal border
      decoration: BoxDecoration(
          border: Border.all(
        width: 0.5,
        color: Colors.grey,
      )),
      // checking signal is VIP or not
      child: (isVIP == true)
          // if user is VIP
          // show the info in horizontal widgets
          ? Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // space between
              children: [
                // show left side of the tile of close signals
                LeftSideOfHomePageListTile(
                  title: (name == null) ? '' : name, //name
                  persentage: (percent == null) ? 0 : percent, //percentage
                ),
                // show center of the tile of close signals
                CenterOfHomePageListTile(
                  title: (price == null) ? 0 : price, //price
                  isOpen: false, //don't show open signal lable
                ),
                // show right side of the tile of close signals
                RightSideOfHomePageListTile(
                  high: (high == null) ? 0 : high, // profit
                  low: (low == null) ? 0 : low, // loss
                ),
              ],
            )
          // if user is NOT VIP
          // show VIP signal locked if user is not VIP
          : LockedHomePageListTile(title: (name == null) ? '' : name),
    );
  }
}
