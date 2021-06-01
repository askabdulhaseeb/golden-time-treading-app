import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Screens/homeInfoPage/homePageListTile/centerOfHomePageListTile.dart';
import 'package:golden_time_treading_app/Screens/homeInfoPage/homePageListTile/leftSideOfHomePageListTile.dart';
import 'package:golden_time_treading_app/Screens/homeInfoPage/homePageListTile/rightSideOfHomePageListTile.dart';

class AdminLocalSignalTile extends StatelessWidget {
  // variable
  final String _name;
  final double _percent;
  final double _price;
  final double _high;
  final double _low;
  final bool _isOpen;
  final bool _isVIP;

  // constructor
  const AdminLocalSignalTile({
    Key key,
    @required name,
    @required percent,
    @required price,
    @required high,
    @required low,
    @required isOpen,
    @required isVIP,
  })  : _name = name,
        _percent = percent,
        _price = price,
        _high = high,
        _low = low,
        _isOpen = isOpen,
        _isVIP = isVIP,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    // design local signal tile for admin panel
    return Container(
      width: double.infinity, // get all width
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 10), //horizontal space
      /// basic design
      decoration: BoxDecoration(
        // border design
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
      child: Container(
        // if the signal is VIP then the background color will be green
        // otherwise the color will be transparent
        color: (_isVIP) ? Colors.green[50] : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // left side of live feed signal
            LeftSideOfHomePageListTile(
              title: (_name == null) ? '' : _name, //name
              persentage: (_percent == null) ? 0 : _percent, //percentage
            ),
            // center of the live feed signal
            CenterOfHomePageListTile(
              title: (_price == null) ? 0 : _price, //price
              isOpen: _isOpen, // open signal true or false
            ),
            // right side of the live feed signal
            RightSideOfHomePageListTile(
              high: (_high == null) ? 0 : _high, // profit
              low: (_low == null) ? 0 : _low, //loss
            ),
          ],
        ),
      ),
    );
  }
}
