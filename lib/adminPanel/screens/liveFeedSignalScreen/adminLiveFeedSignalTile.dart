import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Screens/homeInfoPage/homePageListTile/centerOfHomePageListTile.dart';
import 'package:golden_time_treading_app/Screens/homeInfoPage/homePageListTile/leftSideOfHomePageListTile.dart';
import 'package:golden_time_treading_app/Screens/homeInfoPage/homePageListTile/rightSideOfHomePageListTile.dart';

class AdminLiveFeedSignalTile extends StatelessWidget {
  // variable
  final String _name;
  final double _percent;
  final double _price;
  final double _high;
  final double _low;
  final bool _isOpen;
  final String _type;

  // constructor
  const AdminLiveFeedSignalTile({
    Key key,
    @required name,
    @required percent,
    @required price,
    @required high,
    @required low,
    @required isOpen,
    @required type,
  })  : _name = name,
        _percent = percent,
        _price = price,
        _high = high,
        _low = low,
        _isOpen = isOpen,
        _type = type,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    //design LiveFeed signal Tiles
    return Container(
      width: double.infinity, // get all available space width
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // basic design
      decoration: BoxDecoration(
        // border design
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left side of the home page list
          LeftSideOfHomePageListTile(
            title: (_name == null) ? '' : _name,
            persentage: (_percent == null) ? 0 : _percent,
          ),
          // center of the home page list
          CenterOfHomePageListTile(
            title: (_price == null) ? 0 : _price,
            isOpen: _isOpen,
          ),
          // right side of the home page list
          RightSideOfHomePageListTile(
            high: (_high == null) ? 0 : _high,
            low: (_low == null) ? 0 : _low,
          ),
        ],
      ),
    );
  }
}
