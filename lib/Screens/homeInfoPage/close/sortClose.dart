import 'package:flutter/material.dart';

class SortClose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // design sort
    return Container(
      height: 30,
      margin: const EdgeInsets.only(right: 10), // right outside space
      // design basices
      decoration: BoxDecoration(
        // border style
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      //show text in center
      child: Center(child: Text('Sort')),
    );
  }
}
