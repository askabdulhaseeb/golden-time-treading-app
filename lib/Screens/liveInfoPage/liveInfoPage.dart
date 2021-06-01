import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_time_treading_app/Auth/shared_preferences_helper.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import 'package:golden_time_treading_app/Screens/constraints.dart';
import 'package:intl/intl.dart';
import 'messageListTile.dart';

class LiveInfoPage extends StatefulWidget {
  static final routeName = '/LiveInfoPage';
  @override
  _LiveInfoPageState createState() => _LiveInfoPageState();
}

class _LiveInfoPageState extends State<LiveInfoPage> {
  Stream messageStream; // Live stream of messages
  String myEmail; // sender/current user email
  TextEditingController messageController =
      TextEditingController(); // user message

  // send message to database
  sendMessage() {
    if (messageController.text != "") {
      // check message is not empty
      String message = messageController.text;
      messageController.text = ""; // empty message
      var lastMessageTs = DateTime.now(); // time now
      String displayTime =
          DateFormat('hh:mm a').format(lastMessageTs); // a: for AM or PM
      // Data send to the database
      Map<String, dynamic> messageMap = {
        "message": message,
        "sendBy": myEmail,
        "ts": lastMessageTs,
        "displayTime": displayTime,
      };
      // add message to database and clear the message line to type new message
      DatabaseMethods().addMessageToFirebaseLiveSupport(messageMap).then((_) {
        messageController.text = "";
      });
    }
  }

  // Show Chat on the screen
  Widget chatMessages() {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 70), // Distance of 70 pixal of last message from bottom
      child: StreamBuilder(
        stream: messageStream, // Live Stream of Message
        builder: (context, snapshot) {
          return (snapshot.hasData) // check the data found
              ? ListView.builder(
                  // list of messages
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return MessageTileView(
                      // show the message
                      message: ds["message"], // message
                      sendBy: ds["sendBy"], // sender name
                      isMe: ds['sendBy'] ==
                          myEmail, // send by current user or not
                      displayTime: ds['displayTime'], // send message time
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                ); // circular indicator till messages found
        },
      ),
    );
  }

  // Get all the messages from database
  getAndSetMessages() async {
    messageStream = await DatabaseMethods().getMessageToFirebaseLiveSupport();
    await SharedPreferenceHelper().getUserEmail().then((value) {
      setState(() {
        myEmail = value;
      });
    });
  }

  // at the start of screen
  @override
  void initState() {
    getAndSetMessages(); // fatching old messages
    SystemChannels.textInput.invokeMethod('TextInput.hide'); // hide keyborad
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // appBar
        title: Text(
          'Live Chat',
          style: TextStyle(
            fontSize: 16,
            fontFamily: regular,
          ),
        ),
      ),
      body: Container(
        child: GestureDetector(
          // Hide keyborad if click on the screen other the messages
          onTap: () => SystemChannels.textInput.invokeMethod('TextInput.hide'),
          child: Stack(
            // stack of message
            alignment: AlignmentDirectional.bottomEnd, // start from end
            children: [
              chatMessages(), // all the chat
              // to Type new Message
              Container(
                // space of 10 pixal from all sides
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.bottomCenter,
                child: Container(
                  // basic designing
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2.0, color: Colors.grey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Row(
                    children: [
                      Expanded(
                        // Expand if needed
                        child: Container(
                          height: 50,
                          child: TextField(
                            // to type new message
                            controller: messageController,
                            style: TextStyle(color: Colors.black),
                            keyboardType:
                                TextInputType.multiline, // more than one line
                            minLines: 1,
                            maxLines: 2, // unlimited lines
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    'Write your message here', // ByDefault text
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.3))),
                          ),
                        ),
                      ),
                      // sender Icon
                      IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Theme.of(context).primaryColor,
                        ),
                        // on send button pressed
                        onPressed: () => sendMessage(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
