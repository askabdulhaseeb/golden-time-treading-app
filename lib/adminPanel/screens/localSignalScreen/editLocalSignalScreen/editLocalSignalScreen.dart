import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import '../../widgets/valideStringTextFormField.dart';
import '../../../widgets/showAlertDialog.dart';
import '../../widgets/valideDoubleTextFormField.dart';
import 'updateLocalSignalInfo.dart';

class EditLocalSignalScreen extends StatefulWidget {
  static final routeName = '/EditLocalSignalScreen';
  final String signalID;
  EditLocalSignalScreen({@required this.signalID});
  @override
  _EditLocalSignalScreenState createState() => _EditLocalSignalScreenState();
}

class _EditLocalSignalScreenState extends State<EditLocalSignalScreen> {
  Future<DocumentSnapshot> _stream; // stream signal
  // variable
  String _name;
  String _percent;
  String _price;
  String _high;
  String _low;
  bool isOpen = true, isVIP = false;
  bool _newIsOpen = true, _newIsVIP = false;
  String _newName, _newPercent, _newPrice, _newhigh, _newLow;
  bool isRunOnce = true;
  // globle key
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  // start streaming
  _pageStart() async {
    _stream = DatabaseMethods()
        .getDataOfOneLocalSignalBySIDFromFirebase(widget.signalID);
    setState(() {});
  }

  // on any input field data chnages
  _onNameChange(String name) {
    setState(() {
      _newName = name;
    });
  }

  _onPriceChange(String name) {
    setState(() {
      _newPrice = name;
    });
  }

  _onHighChange(String name) {
    setState(() {
      _newhigh = name;
    });
  }

  _onLowChange(String name) {
    setState(() {
      _newLow = name;
    });
  }

  @override
  void initState() {
    _pageStart();
    super.initState();
  }

  // fetch inital data from firebase
  assignValues(AsyncSnapshot<DocumentSnapshot> snap) {
    _name = snap.data['name'];
    _percent = snap.data['percent'].toString();
    _price = snap.data['price'].toString();
    _high = snap.data['high'].toString();
    _low = snap.data['low'].toString();
    isOpen = snap.data['isOpen'];
    isVIP = snap.data['isVIP'];
    _assignValueOnce();
  }

  // run only once while starting page
  _assignValueOnce() {
    if (isRunOnce) {
      _newName = _name;
      _newPercent = _percent;
      _newPrice = _price;
      _newhigh = _high;
      _newLow = _low;
      _newIsOpen = isOpen;
      _newIsVIP = isVIP;
    }
    isRunOnce = false;
  }

  // on press yes
  _onYes() async {
    // delete signal from firebase
    await DatabaseMethods().deleteLocalSignalFromFirebase(widget.signalID);
    // move to Edit local signal screen
    Navigator.of(context).popAndPushNamed(EditLocalSignalScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // enable keyboard
      //appbar
      appBar: AppBar(
        title: Text('Edit Local Signal'),
        actions: [
          // Delete icon button
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            // on press to delete icon
            onPressed: () async {
              // show alret screen to confirm delete signal
              ShowAlterDialog(
                context,
                _name,
                _onYes,
              );
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          // hide keyboard
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        // scroll
        child: SingleChildScrollView(
          // form input handler
          child: Form(
            key: _globalKey,
            child: Padding(
                padding: const EdgeInsets.all(8), // space on all side
                child: FutureBuilder<DocumentSnapshot>(
                  future: _stream, // stream
                  // fetch data
                  builder: (context, snapshot) {
                    // on fetching data on one signal
                    if (snapshot.hasData) {
                      assignValues(snapshot);
                      // align widgets vertically
                      return Column(
                        children: [
                          ValideStringTextFormField(
                            hint: 'Signal Name',
                            initialValue: _name,
                            onChange: _onNameChange,
                          ),
                          ValideDoubleTextFormField(
                            hint: 'Enrty Price',
                            initialValue: _price.toString(),
                            onChange: _onPriceChange,
                          ),
                          ValideDoubleTextFormField(
                            hint: 'Take Profit',
                            initialValue: _high.toString(),
                            onChange: _onHighChange,
                          ),
                          ValideDoubleTextFormField(
                            hint: 'Stop Loss',
                            initialValue: _low.toString(),
                            onChange: _onLowChange,
                          ),
                          // Open Signal Switch
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Open Signal'),
                              Switch(
                                value: _newIsOpen,
                                onChanged: (value) {
                                  setState(() {
                                    _newIsOpen = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          // VIP signal switch
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('VIP Signal'),
                              Switch(
                                value: _newIsVIP,
                                onChanged: (value) {
                                  setState(() {
                                    _newIsVIP = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          // update local signal button
                          UpdateLocalSignalInfo(
                            sid: widget.signalID,
                            name: _newName,
                            percent: _newPercent,
                            price: _newPrice,
                            high: _newhigh,
                            low: _newLow,
                            isOpen: _newIsOpen,
                            isVIP: _newIsVIP,
                            globalKey: _globalKey,
                          ),
                        ],
                      );
                    } else {
                      // show Circular Progress Indicator while fetching data
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )),
          ),
        ),
      ),
    );
  }
}
