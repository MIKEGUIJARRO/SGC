import 'package:flutter/material.dart';


class EncuestaInfo extends StatelessWidget {

  final String num;

  EncuestaInfo({this.num});

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