import 'package:flutter/material.dart';

class BlogPostScreen extends StatelessWidget {
  static final routeName = '/blogPostScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold( // White backgroound screen
      appBar: AppBar(
        title: Text('Blogs/News'),
      ),
      body: Center(
        child: Text('Blogs/News'),
      ),
    );
  }
}
