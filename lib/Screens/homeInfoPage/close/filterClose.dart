import 'package:flutter/material.dart';

class FilterClose extends StatefulWidget {
  Function onApplyFilter;
  FilterClose({@required this.onApplyFilter});

  @override
  _FilterCloseState createState() => _FilterCloseState();
}

class _FilterCloseState extends State<FilterClose> {
  String dropdownValue = 'all';
  @override
  Widget build(BuildContext context) {
    // basic desiging
    return Container(
      height: 30,
      padding:
          const EdgeInsets.symmetric(horizontal: 10), //inside horizontal space
      margin: const EdgeInsets.symmetric(
          horizontal: 10), // outside horizontal space
      // design basics of dropbox
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey), //dropbox border
        borderRadius: BorderRadius.circular(10), //Border Radius of dropbox
      ),
      // designing dropdown
      child: DropdownButton(
        value: dropdownValue, // values of dropbox
        icon: const Icon(Icons.arrow_drop_down_rounded), // dropbox icon
        iconSize: 20, // dropbox icon size
        elevation: 16, // shadow
        style: TextStyle(color: Colors.black), // text style
        // on dropbox value change
        onChanged: (String newValue) {
          setState(() {
            widget.onApplyFilter(newValue);
          });
        },
        // show the drop down items
        items: ['all', 'open', 'close']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
