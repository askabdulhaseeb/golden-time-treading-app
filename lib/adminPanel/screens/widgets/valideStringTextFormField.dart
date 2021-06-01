import 'package:flutter/material.dart';

// Imput Text Field to take any type of data from user
class ValideStringTextFormField extends StatefulWidget {
  // variable
  final Function _onChange;
  final String _initialValue;
  final String _hint;
  // constructor
  ValideStringTextFormField({
    Key key,
    @required String hint,
    @required String initialValue,
    @required Function onChange,
  })  : this._initialValue = initialValue,
        this._onChange = onChange,
        this._hint = hint,
        super(key: key);
  @override
  _ValideStringTextFormFieldState createState() =>
      _ValideStringTextFormFieldState();
}

class _ValideStringTextFormFieldState extends State<ValideStringTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8), // space
      child: TextFormField(
        initialValue: widget._initialValue, // starting value
        keyboardType: TextInputType.name, // keyboard type
        textInputAction: TextInputAction.done, // keyboard action button
        onChanged: (value) {
          widget._onChange(value);
        },
        validator: (value) {
          if (value.length < 3) return 'Enter Correct Name';
          return null;
        },
        // basic input design
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
