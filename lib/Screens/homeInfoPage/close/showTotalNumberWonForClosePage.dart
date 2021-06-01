import 'package:flutter/material.dart';

class ShowTotalNumberForClosePage extends StatelessWidget {
  final double total; // total signals
  ShowTotalNumberForClosePage({@required this.total}); // constructor
  @override
  Widget build(BuildContext context) {
    // align widgets vertically
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // horizontally center
      mainAxisAlignment: MainAxisAlignment.start, // vertically start
      children: [
        const SizedBox(height: 10), // space of 10 pixel from top
        // text to show
        const Text(
          'Total Pips Won',
          // style of text
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        // inner space
        Padding(
          padding: const EdgeInsets.all(12), // space
          // show number of signals
          child: Text(
            '$total',
            // style of text
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }
}
