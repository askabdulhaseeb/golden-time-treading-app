import 'package:flutter/material.dart';

class ORLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width / 3,
            color: Colors.grey,
            child: Text('-'),
          ),
          Text('  OR  '),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width / 3,
            color: Colors.grey,
            child: Text('-'),
          ),
        ],
      ),
    );
  }
}
