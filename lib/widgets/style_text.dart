
import 'package:flutter/material.dart';

class StyleTextRich extends StatelessWidget {
  String? title;
  String? subtitle;

  StyleTextRich({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),

          TextSpan(
            text: subtitle,
            style: TextStyle(fontSize: 16)
          )
        ]
      )
    );
  }

}