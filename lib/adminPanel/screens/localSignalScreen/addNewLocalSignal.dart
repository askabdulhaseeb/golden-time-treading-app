import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_time_treading_app/Database/database.dart';

class AddNewLocalSignal extends StatefulWidget {
  static final routeName = '/addNewLocalSignal';
  @override
  _AddNewLocalSignalState createState() => _AddNewLocalSignalState();
}

class _AddNewLocalSignalState extends State<AddNewLocalSignal> {
  // variables
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // input controller
  TextEditingController _name = TextEditingController();
  TextEditingController _percent = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _high = TextEditingController();
  TextEditingController _low = TextEditingController();
  bool _isOpen = false;
  bool _isVIP = false;

  // clear resources while ending the page
  @override
  void dispose() {
    _name.clear();
    _percent.clear();
    _price.clear();
    _high.clear();
    _low.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // hide keyboard when user tap anywhere in the screen
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: Scaffold(
        //appbar
        appBar: AppBar(
          title: Text('Add Local Signal'),
        ),
        // scrolling
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10), // space
            // input form handler
            child: Form(
              key: _formKey,
              // align Widgets verically
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // handle inputs
                  TextFormField(
                    controller: _name,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Signal Name',
                    ),
                    validator: (value) =>
                        (value.isEmpty) ? 'Enter a Name' : null,
                  ),
                  TextFormField(
                    controller: _percent,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Signal Percentage',
                    ),
                    validator: (value) => (value.isEmpty)
                        ? 'Enter a Percentage'
                        : (int.parse(value) > 100)
                            ? 'Must be less then 100'
                            : null,
                  ),
                  TextFormField(
                    controller: _price,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Entry Price',
                    ),
                    validator: (value) =>
                        (value.isEmpty) ? 'Enter a Price' : null,
                  ),
                  TextFormField(
                    controller: _high,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Take Profit',
                    ),
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Enter Profit';
                      else if (double.parse(value) < (double.parse(_low.text)))
                        return 'Profit should be greater then Loss';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _low,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Stop Loss',
                    ),
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Enter a Stop Loss';
                      else if (double.parse(value) > (double.parse(_low.text)))
                        return 'Loss should be less then Profit';
                      return null;
                    },
                  ),
                  // open signal is switch
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Enable for Open Signal '),
                      Switch(
                        value: _isOpen,
                        onChanged: (value) {
                          setState(() {
                            _isOpen = value;
                          });
                        },
                      ),
                    ],
                  ),
                  // VIP signal switch
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Signal is VIP '),
                      Switch(
                        value: _isVIP,
                        onChanged: (value) {
                          setState(() {
                            _isVIP = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> localMap = {
                          "name": _name.text,
                          "percent": double.parse(
                              double.parse(_percent.text).toStringAsFixed(2)),
                          "price": double.parse(
                              double.parse(_price.text).toStringAsFixed(2)),
                          "high": double.parse(
                              double.parse(_high.text).toStringAsFixed(2)),
                          "low": double.parse(
                              double.parse(_low.text).toStringAsFixed(2)),
                          "isOpen": _isOpen,
                          'isVIP': _isVIP,
                        };
                        DatabaseMethods().addLocalSignalsToFirebase(localMap);
                        dispose();
                      }
                    },
                    child: Text('Add Signal'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
