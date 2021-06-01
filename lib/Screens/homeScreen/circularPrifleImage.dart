import 'package:flutter/material.dart';
import 'package:golden_time_treading_app/Screens/constraints.dart';

class CircularProfileImage extends StatelessWidget {
  final String imageUrl;
  // must recieve a imageUrl
  const CircularProfileImage({@required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    // design circular User Image
    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.transparent,
      backgroundImage: (imageUrl == null) // Check Images URL exist or not
          ? AssetImage(defaultUser) // if no URL found show Default User Image
          : NetworkImage(imageUrl.replaceFirst('s96', 's400')), // Orignal Image
    );
  }
}
