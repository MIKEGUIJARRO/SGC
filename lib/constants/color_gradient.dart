import 'dart:ui';

import 'package:hex/hex.dart';
import 'package:flutter/material.dart';

class ColorGradient {
  /* static String _colorHexA = "F6511D"; //Rojo
  static String _colorHexB = "293241"; //Este es el color central
  static String _colorHexC = "7FB800"; //Verde

  static List<int> _colorIntA = HEX.decode(_colorHexA);
  static List<int> _colorIntB = HEX.decode(_colorHexB);
  static List<int> _colorIntC = HEX.decode(_colorHexC); */

  static Color calculateColor({double val}) {
    String _colorHexA = "ff3d00"; //Rojo
    String _colorHexB = "d4d4d4"; //Este es el color central
    String _colorHexC = "b0ff00"; //Verde
    List<int> _colorIntA = HEX.decode(_colorHexA);
    List<int> _colorIntB = HEX.decode(_colorHexB);
    List<int> _colorIntC = HEX.decode(_colorHexC);

    int newValueR = _calculateValueGeneral(
        intA: _colorIntA[0],
        intB: _colorIntB[0],
        intC: _colorIntC[0],
        value: val);
    int newValueG = _calculateValueGeneral(
        intA: _colorIntA[1],
        intB: _colorIntB[1],
        intC: _colorIntC[1],
        value: val);
    int newValueB = _calculateValueGeneral(
        intA: _colorIntA[2],
        intB: _colorIntB[2],
        intC: _colorIntC[2],
        value: val);

    return Color.fromRGBO(newValueR, newValueG, newValueB, 1);
  }

/*   static int _calculateValue({int intA, int intB, double value}) {
    double result = (intB - intA) * value / 100 + intA;
    print(value);
    return result.round();
  } */

  static int _calculateValueGeneral(
      {int intA, int intB, int intC, double value}) {
    double result;
    if (value < 0.5) {
      result = (intB * value * 2) + intA * (0.5 - value) * 2;
    } else {
      result = intC * (value - 0.5) * 2 + intB * (1 - value) * 2;
    }
    return result.round();
  }
}
