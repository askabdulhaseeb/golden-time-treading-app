import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:golden_time_treading_app/Database/database.dart';

class UpdateLiveFeedSignalInfo extends StatelessWidget {
  // variable
  final String sid, name, percent, price, high, low;
  final bool isOpen;
  final GlobalKey<FormState> globalKey;
  // constructor
  const UpdateLiveFeedSignalInfo({
    @required this.sid,
    @required this.name,
    @required this.percent,
    @required this.price,
    @required this.high,
    @required this.low,
    @required this.isOpen,
    @required this.globalKey,
  });
  @override
  Widget build(BuildContext context) {
    // show splash when tap on it
    return InkWell(
      onTap: () {
        if (globalKey.currentState.validate()) {
          // convert to double
          double _newHigh = double.parse(high);
          double _newLow = double.parse(low);
          double _newPrice = double.parse(price);
          double _newPercent = double.parse(percent);
          // profite world be more then loss
          if (_newHigh > _newLow) {
            // make map to update info
            Map<String, dynamic> localMap = {
              'name': name,
              'high': _newHigh,
              'isOpen': isOpen,
              'low': _newLow,
              'percent': _newPercent,
              'price': _newPrice,
            };
            // update livefeed signals data from firebase
            DatabaseMethods().updateLiveFeedSignalInfoOnFirebase(sid, localMap);
            Navigator.of(context).pop();
          } else {
            // show toast for error
            Fluttertoast.showToast(
              msg: 'High Price should be graeter then lower',
              backgroundColor: Colors.red,
              timeInSecForIosWeb: 4,
            );
          }
        }
      },
      borderRadius: BorderRadius.circular(20),
      splashColor: Theme.of(context).primaryColor, // on tap color
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20), //space
        //basic designing
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text('Update Signal'),
      ),
    );
  }
}
