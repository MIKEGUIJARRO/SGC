import 'package:flutter/material.dart';

class Circle extends StatelessWidget {

  final double radio;
  final Color color;

  Circle({@required this.radio,@required this.color});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: radio,
      height: radio,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle
      ),
    );
  }
}