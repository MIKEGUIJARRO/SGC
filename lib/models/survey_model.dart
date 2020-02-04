import 'package:flutter/cupertino.dart';

class SurveyModel {
  String id;
  String title;
  int counter;
  List<Map<String, dynamic>> itemQuestions;
  bool isSelected;
  //En itemQuestion almacenamos los valores de las multiples
  //respuestas obtenidas de acuerdo a cada pregunta disponible

  SurveyModel({this.id, this.title, this.counter, this.isSelected, this.itemQuestions});
}
