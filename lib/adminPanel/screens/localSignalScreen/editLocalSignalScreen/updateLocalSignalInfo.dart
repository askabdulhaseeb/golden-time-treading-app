import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:golden_time_treading_app/Database/database.dart';

class UpdateLocalSignalInfo extends StatelessWidget {
  // variable
  final String sid, name, percent, price, high, low;
  final bool isOpen, isVIP;
  final GlobalKey<FormState> globalKey;
  // constructor
  const UpdateLocalSignalInfo({
    @required this.sid,
    @required this.name,
    @required this.percent,
    @required this.price,
    @required this.high,
    @required this.low,
    @required this.isOpen,
    @required this.isVIP,
    @required this.globalKey,
  });
  @override
  Widget build(BuildContext context) {
    // splash on tap
    return InkWell(
      onTap: () {
        if (globalKey.currentState.validate()) {
          // convertion to double
          double _newHigh = double.parse(high);
          double _newLow = double.parse(low);
          double _newPrice = double.parse(price);
          double _newPercent = double.parse(percent);
          // check profit would be more than loss
          if (_newHigh > _newLow) {
            // map of updated values
            Map<String, dynamic> localMap = {
              'name': name,
              'high': _newHigh,
              'low': _newLow,
              'percent': _newPercent,
              'price': _newPrice,
              'isOpen': isOpen,
              'isVIP': isVIP,
            };
            // update Local Signal Info On Firebase
            DatabaseMethods().updateLocalSignalInfoOnFirebase(sid, localMap);
            Navigator.of(context).pop();
          } else {
            // error toast
            Fluttertoast.showToast(
              msg: 'Profit should be graeter Loss',
              backgroundColor: Colors.red,
              timeInSecForIosWeb: 4,
            );
          }
        }
      },
      borderRadius: BorderRadius.circular(20),
      splashColor: Theme.of(context).primaryColor, // on tap color
      child: Container(
        //space
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        // basic design
        decoration: BoxDecoration(
          // border design
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        // button text
        child: Text('Update Signal'),
      ),
    );
  }
}
