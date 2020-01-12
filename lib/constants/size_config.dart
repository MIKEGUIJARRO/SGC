import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;

  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;

  static double safeBlockHorizontal;
  static double safeBlockVertical;
  
  static double screenNoPaddingWidth;
  static double screenNoPaddingHeight;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);

    //Obtenemos Ancho y Alto directo de la pantalla
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    //Tomamos un bloque, es decir 1/100 de nuestra pantalla
    blockSizeHorizontal = screenWidth/100;
    blockSizeVertical = screenHeight/100;

    //Obtenemos el padding que se tiene en pantalla (Horizontal y Vertical)
    _safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;

    _safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;

    //Obtenemos el area real de nuestro pantalla una vez que restamos su padding

    screenNoPaddingWidth = screenWidth - _safeAreaHorizontal;
    screenNoPaddingHeight = screenHeight - _safeAreaVertical;

    //Obtenemos los bloques disponibles como safeblock
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal)/100;
    safeBlockVertical = (screenHeight - _safeAreaVertical)/100;

  }
}