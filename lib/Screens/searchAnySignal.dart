import 'package:flutter/material.dart';

class SearchAnySignal extends StatefulWidget {
  final Function onSearch; // call back function
  const SearchAnySignal({@required this.onSearch});
  @override
  SearchAnySignalState createState() => SearchAnySignalState();
}

class SearchAnySignalState extends State<SearchAnySignal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // back ground color
      height: 40,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(right: 8, left: 12),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      // take input from the user
      child: TextField(
        onChanged: (value) {
          setState(() {
            widget.onSearch(value);
          });
        },
        // designing search text
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 17),
          hintText: 'Search signals',
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
