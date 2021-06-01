import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_time_treading_app/Database/database.dart';

class AddNewLiveFeedSignal extends StatefulWidget {
  static final routeName = '/addNewLiveFeedSignal';
  @override
  _AddNewLiveFeedSignalState createState() => _AddNewLiveFeedSignalState();
}

//
// if you need any help
// Whatsapp: +92 345 1021122
//
class _AddNewLiveFeedSignalState extends State<AddNewLiveFeedSignal> {
  // flobal form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Text Editing controller to handle inputs
  TextEditingController _name = TextEditingController();
  TextEditingController _percent = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _high = TextEditingController();
  TextEditingController _low = TextEditingController();
  bool _isOpen = false;
  String dropdownValue = 'forex';

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
      // hide keyborad on tab background
      onTap: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: Scaffold(
        // app bar
        appBar: AppBar(
          title: Text('Add Live Feed Signal'),
        ),
        // make list scroll able
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10), // space for all the side
            // Handle the input Form
            child: Form(
              key: _formKey,
              // align widgets vertically
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // imput name
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
                  // input percentage
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
                    validator: (value) =>
                        (value.isEmpty) ? 'Enter a Percentage' : null,
                  ),
                  // input price
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
                  // input profit
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
                        return 'Enter a Profit';
                      else if (double.parse(value) < (double.parse(_low.text)))
                        return 'Profit should be greater then Loss';
                      return null;
                    },
                  ),
                  // input loss
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
                        return 'Stop Loss should be less then Profit';
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Type of Signal'),

                      // design drop down
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.blueAccent),
                        underline: Container(
                          height: 2,
                          color: Colors.blue,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        // show signal dropdown
                        items: <String>['forex', 'commodities', 'others']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  // Enable signal is open or not
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
                  const SizedBox(height: 10),
                  // add new signal button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // signal info
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
                          "type": dropdownValue,
                        };
                        // add new signal
                        DatabaseMethods()
                            .addLiveFeedSignalsToFirebase(localMap);
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
