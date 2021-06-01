import 'package:flutter/material.dart';

import '../constraints.dart';

class UserPersonalInfo extends StatelessWidget {
  // TODO: Fetch and Put Real Time Info Here
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoTile(
                  title: 'Member Since',
                  subtitle: '2/2/20',
                ),
                SizedBox(height: 10),
                UserInfoTile(
                  title: 'Last Online      ',
                  subtitle: '2/2/20',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class UserInfoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const UserInfoTile({
    @required this.title,
    @required this.subtitle,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: regular,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 30),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            fontFamily: regular,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}
