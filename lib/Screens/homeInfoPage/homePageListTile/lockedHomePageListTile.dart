import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Screens/constraints.dart';
import '../../UpgradeToVIPScreen/UpgradeToVIPScreen.dart';

class LockedHomePageListTile extends StatelessWidget {
  final String title;
  LockedHomePageListTile({@required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // show Signal's title
        Text(
          '$title', // signal name
          overflow: TextOverflow.ellipsis, // text overflow handler
          // text style
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: regular,
          ),
        ),
        GestureDetector(
          // move to VIP screen to upgrade himself
          onTap: () {
            Navigator.of(context).pushNamed(UpgradeToVIPScreen.routeName);
          },
          // design LOCK VIP SIGNAL Tile
          child: Container(
            height: 40,
            padding:
                const EdgeInsets.symmetric(horizontal: 14), //horizontal space
            margin:
                const EdgeInsets.symmetric(horizontal: 20), //horizontal space
            // besic design
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            // align widgets horizontally
            child: Row(
              children: [
                // show lock icon
                Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
                // space of width 8 pixel
                const SizedBox(width: 8),
                // text show on lock signal
                Text(
                  'Unlock VIP Signals',
                  // text style
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
