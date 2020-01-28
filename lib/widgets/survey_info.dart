import 'package:flutter/material.dart';


class SurveyInfo extends StatelessWidget {

  final String num;

  SurveyInfo({this.num});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("#$num", style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          letterSpacing: 5,
          color: Colors.teal[300],
        ),),
        Text("personas han respondido esta encuesta",)
      ],
      
    );
  }
}