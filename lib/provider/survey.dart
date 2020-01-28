import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ResponseItem {
  //Id es el contador de preguntas
  final String id;
  final double response;
  final DateTime dateTime;
  ResponseItem(
      {@required this.id, @required this.response, @required this.dateTime});
}

class SurveyItem {
  //Item hace referencia a cada card con su pregunta.
  //Una encuesta se compone de multiples preguntas.
  //Modelo de encuesta individual que guarda toda la informacion core
  // 1 sola pregunta y las n respuestas que se han tenido
  final String question;
  //Responses va a guardar la fecha de la respuesta y el valor de esta
  final List<ResponseItem> responses;
  SurveyItem({this.question, this.responses});
}

class Survey with ChangeNotifier {
  //Esta es la encuesta que se estara trabajando en macro en la app.
  //La que se respondera "n" veces.
  List<SurveyItem> _surveyItems = [
    /* SurveyItem(question: "Pregunta 1?", responses: []),
    SurveyItem(question: "Pregunta 2?", responses: []),
    SurveyItem(question: "Pregunta 3?", responses: []),
    SurveyItem(question: "Pregunta 4?", responses: []), */
  ];

 Future<void> initSurvey({List<String> questions, List<ResponseItem> responses}) async {
    //Puede mejorar por que fetchea todas las preguntas y todas las respuestas
    //A largo plazo no es rentable...
    //Codigo donde descarga la base de datos
    _surveyItems = questions.map((question) {
      return SurveyItem(question: question, responses: responses);
    }).toList();
  }

  addResponses(List<double> responses) {
    //Se agregan las respuestas de manera local y en la nube
    //Cada indice de pregunta pasa su indice de respuesta
    if (responses.length != _surveyItems.length) {
      print(
          "Existe una diferencia entre la cantidad de respuestas obtenidas y la las preguntas");
      //Throw Error
      return;
    }

    for (int i = 0; i < _surveyItems.length; i++) {
      _surveyItems[i].responses.add(ResponseItem(
          id: DateTime.now().toString(),
          response: responses[i],
          dateTime: DateTime.now()));
      print("Response $i: ${responses[i]}");
    }

    notifyListeners();
  }

  List<String> getQuestions() {
    return _surveyItems.map((item) => item.question).toList();
  }
}
