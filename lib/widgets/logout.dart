
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        child: Icon(Icons.logout),
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
        },
      ),
    );
  }


}