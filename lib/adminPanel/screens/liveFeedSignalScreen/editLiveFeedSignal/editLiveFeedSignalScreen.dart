import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_time_treading_app/Database/database.dart';
import 'package:golden_time_treading_app/adminPanel/screens/liveFeedSignalScreen/editLiveFeedSignal/updateLiveFeedSignalButton.dart';
import 'package:golden_time_treading_app/adminPanel/screens/widgets/valideStringTextFormField.dart';
import 'package:golden_time_treading_app/adminPanel/widgets/showAlertDialog.dart';
import '../../widgets/valideDoubleTextFormField.dart';

class EditLiveFeedSignalScreen extends StatefulWidget {
  static final routeName = '/EditLiveFeedSignalScreen';
  final String sid;
  EditLiveFeedSignalScreen({
    @required this.sid,
  });
  @override
  _EditLiveFeedSignalScreenState createState() =>
      _EditLiveFeedSignalScreenState();
}

class _EditLiveFeedSignalScreenState extends State<EditLiveFeedSignalScreen> {
  Future<DocumentSnapshot> _stream; // signal stream
  String _name;
  String _percent;
  String _price;
  String _high;
  String _low;
  bool isOpen = true, _isOpen;
  String _newName, _newPercent, _newPrice, _newhigh, _newLow;
  bool isRunOnce = true;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>(); // key

  // start signal stream
  _pageStart() async {
    _stream = DatabaseMethods()
        .getDataOfOneLiveFeedSignalBySIDFromFirebase(widget.sid);
    setState(() {});
  }

  // on Any input change
  // when user write any thing in the input field
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

  _onSwitchChange(bool value) {
    setState(() {
      isOpen = value;
    });
  }

  // run before any thing run in this page
  @override
  void initState() {
    _pageStart();
    super.initState();
  }

  // initlizae the data
  assignValues(AsyncSnapshot<DocumentSnapshot> snap) {
    _name = snap.data['name'];
    _percent = snap.data['percent'].toString();
    _price = snap.data['price'].toString();
    _high = snap.data['high'].toString();
    _low = snap.data['low'].toString();
    _isOpen = snap.data['isOpen'];
    _assignValueOnce();
  }

  // assign values that will be assign only once
  _assignValueOnce() {
    if (isRunOnce) {
      _newName = _name;
      _newPercent = _percent;
      _newPrice = _price;
      _newhigh = _high;
      _newLow = _low;
      isOpen = _isOpen;
    }
    isRunOnce = false;
  }

  // on delete the signal
  _onYes() async {
    await DatabaseMethods().deleteLiveFeedSignalFromFirebase(widget.sid);
    // move to the Edit live feed signal
    Navigator.of(context).popAndPushNamed(EditLiveFeedSignalScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // enable keyboard
      // app bar
      appBar: AppBar(
        title: Text('Edit Live Feed Signal'),
        actions: [
          // delete Icon Button
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            // on delete icon press
            onPressed: () async {
              // show confirmation alert
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
          // hide the keyborad when user enter on anything on the screen
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        // Scrolling
        child: SingleChildScrollView(
          // form to handle text form fields
          child: Form(
            key: _globalKey,
            child: Padding(
              padding: const EdgeInsets.all(8), // space around
              child: FutureBuilder<DocumentSnapshot>(
                future: _stream, // future stream
                builder: (context, snapshot) {
                  // if data found from firebase
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
                          hint: 'Entry Price',
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
                        // open signal switch
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Open Signal'),
                            Switch(
                              value: isOpen,
                              onChanged: (value) {
                                _onSwitchChange(value);
                              },
                            ),
                          ],
                        ),
                        // update info
                        UpdateLiveFeedSignalInfo(
                          sid: widget.sid,
                          name: _newName,
                          percent: _newPercent,
                          price: _newPrice,
                          high: _newhigh,
                          low: _newLow,
                          isOpen: isOpen,
                          globalKey: _globalKey,
                        ),
                      ],
                    );
                  } else {
                    // if data not found Circular Progress Indicator will show
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
