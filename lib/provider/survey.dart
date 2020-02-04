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

  Map<String, dynamic> _surveyItems = {
    "title": "titulo default",
    "counter": 0,
    "content": [
      //Lista de surveyItems
      SurveyItem(question: "Pregunta 1?", responses: []),
    SurveyItem(question: "Pregunta 2?", responses: []),
    SurveyItem(question: "Pregunta 3?", responses: []),
    SurveyItem(question: "Pregunta 4?", responses: []),
    ],
  };

  void initSurvey(
      {String title,
      int counter,
      List<String> questions,
      List<ResponseItem> responses}) {

    _surveyItems["title"] = title;
    _surveyItems["counter"] = counter;
    _surveyItems["content"] = questions.map((question) {
      return SurveyItem(question: question, responses: responses);
    }).toList();

    notifyListeners();
  }

  addResponses(List<double> responses) {
    //Se agregan las respuestas de manera local y en la nube
    //Cada indice de pregunta pasa su indice de respuesta
    if (responses.length != _surveyItems["content"].length) {
      print(
          "Existe una diferencia entre la cantidad de respuestas obtenidas y la las preguntas");
      //Throw Error
      return;
    }

    for (int i = 0; i < _surveyItems["content"].length; i++) {
      _surveyItems["content"][i].responses.add(ResponseItem(
          id: DateTime.now().toString(),
          response: responses[i],
          dateTime: DateTime.now()));
      print("Response $i: ${responses[i]}");
    }

    notifyListeners();
  }

  List<String> getQuestions() {
    var surveyHolder = _surveyItems["content"] as List<SurveyItem>;
    return surveyHolder.map((item) => item.question).toList();
  }

  void setNewQuestions(List<String> questions, String title) {
    _surveyItems["title"] = title;
    print(_surveyItems["title"]);
    List<SurveyItem> newQuestions = questions
        .map((qxtn) => SurveyItem(question: qxtn, responses: []))
        .toList();
    _surveyItems["content"] = newQuestions;
    notifyListeners();
  }

  void increaseCounter() {
    _surveyItems["counter"] ++;
    notifyListeners();
  }

  int getCounter() {
    return _surveyItems["counter"];
  }

  String getTitle() {
    return _surveyItems["title"];
  }


}
