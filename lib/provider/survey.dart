import 'package:flutter/foundation.dart';

class ResponseItem {
  final double response;
  final DateTime dateTime;
  ResponseItem ({this.response, this.dateTime});
}

class SurveyItems {
  //Modelo de encuesta individual que guarda toda la informacion core
  final String question;
  //Responses va a guardar la fecha de la respuesta y el valor de esta
  final List<ResponseItem> responses;
  SurveyItems({this.question, this.responses});
}

class Survey with ChangeNotifier{

  


}