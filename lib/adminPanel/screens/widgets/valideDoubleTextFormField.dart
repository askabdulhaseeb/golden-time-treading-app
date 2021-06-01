import 'package:flutter/material.dart';

// Imput Text Field to take numaric data from user
class ValideDoubleTextFormField extends StatefulWidget {
  // variable
  final Function _onChange;
  final String _hint;
  final String _initialValue;
  // constructor
  ValideDoubleTextFormField({
    @required String hint,
    @required String initialValue,
    @required Function onChange,
  })  : this._onChange = onChange,
        this._hint = hint,
        this._initialValue = initialValue;
  @override
  _ValideDoubleTextFormFieldState createState() =>
      _ValideDoubleTextFormFieldState();
}

class _ValideDoubleTextFormFieldState extends State<ValideDoubleTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8), //space
      // input field
      child: TextFormField(
        initialValue: widget._initialValue, // starting value
        keyboardType: TextInputType.number, // keyboard type
        textInputAction: TextInputAction.done, // action button of keyboard
        validator: (value) {
          return (value.isEmpty) ? 'Enter Value' : null;
        },
        onChanged: (value) {
          widget._onChange(value);
        },
        // input text field design
        decoration: InputDecoration(
          labelText: widget._hint,
          hintText: widget._hint,
          prefix: Container(width: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
