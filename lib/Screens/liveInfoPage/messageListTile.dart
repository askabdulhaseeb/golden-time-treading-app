import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Screens/constraints.dart';

class MessageTileView extends StatelessWidget {
  final String message; // User Message
  final bool isMe; // Message is sended by current user or not
  final String sendBy; // Sended email address
  final String displayTime; // Message Time
  const MessageTileView({
    @required this.message,
    @required this.sendBy,
    this.isMe,
    @required this.displayTime,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      // Is sender is current user than show on right side other wise on left
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Wrap(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                // Message Container Design
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft: isMe ? Radius.circular(24) : Radius.circular(0),
                ),
                // if the message if from current user then show with blue background
                // and if from someone else then show with grey background color
                color:
                    isMe ? Theme.of(context).primaryColor : Color(0xfff1f0f0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Column(
                // To diplay the time at the end
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // User name
                        (sendBy == null) ? '' : sendBy,
                        style: TextStyle(
                          fontFamily: regular,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          // current user name shows in white and other's in black
                          color: (isMe) ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message, //message
                        style: TextStyle(
                          // current user name shows in white and other's in black
                          color: (isMe) ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                  Row(
                    // to Display the Time at bottome left side
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        displayTime, // time of message
                        style: TextStyle(
                          // current user name shows in white and other's in black
                          color: (isMe) ? Colors.white70 : Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
