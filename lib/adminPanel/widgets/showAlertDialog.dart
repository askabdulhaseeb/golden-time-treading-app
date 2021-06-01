import 'package:flutter/material.dart';

// show alert message to delete data
Future ShowAlterDialog(
    BuildContext context, String signalName, Function onYes) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(20), // space
          // align widgets vertically
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //space between
            children: [
              // align widgets vertically
              Column(
                mainAxisAlignment: MainAxisAlignment.start, // from start
                crossAxisAlignment: CrossAxisAlignment.start, // from start
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0), //space
                    // center
                    child: Center(
                      // text for alert
                      child: Text(
                        signalName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Text('Are you sure to delete this Signal'),
                  Text('Once you delete it, you can not recove it later'),
                ],
              ),
              // Align widgets horizontally
              // Show YES and NO button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, //space evenly
                children: [
                  // Icon Button
                  IconButton(
                    icon: Text(
                      'Yes',
                      style: TextStyle(color: Colors.blue),
                    ),
                    // when want to delete the signal
                    onPressed: () {
                      onYes();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                  // Icon Button
                  IconButton(
                    icon: Text(
                      'No',
                      style: TextStyle(color: Colors.blue),
                    ),
                    // When user not want to delete the signal
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
