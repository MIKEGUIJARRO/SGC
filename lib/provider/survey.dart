import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/survey_model.dart';

class Survey with ChangeNotifier {
  SurveyModel _surveyModel = SurveyModel(
      id: "id010101",
      title: "👈 Crea tu primer encuesta",
      counter: 0,
      itemQuestions: [
        {"question": "Pregunta 1", "responses": []},
        {"question": "Pregunta 2", "responses": []},
        {"question": "Pregunta 3", "responses": []}
      ]);

  void initSurvey(
      {String id, String title, int counter, List<String> questions}) {
    _surveyModel = SurveyModel(
        id: id,
        title: title,
        counter: counter,
        itemQuestions: questions
            .map((question) => {"question": question, "responses": []})
            .toList());
    notifyListeners();
  }

  void printResponses() {
    print("\tIndice\tNo. Respuesta");
    for (int i = 0; i < _surveyModel.itemQuestions.length; i++) {
      print("\tIndice principal $i\n");
      for (int j = 0;
          j < _surveyModel.itemQuestions[i]["responses"].length;
          j++) {
        print("\t$i\t${_surveyModel.itemQuestions[i]["responses"][j]}");
      }
    }

    print("\nFinalizo recorrido");
  }

  void addResponsesItem(List<double> responses) {
    //Se agregan las respuestas de manera local y en la nube
    //Cada indice de pregunta pasa su indice de respuesta
    for (int i = 0; i < responses.length; i++) {
      _surveyModel.itemQuestions[i]["responses"].add(responses[i]);
    }
    notifyListeners();
  }

  List<String> getQuestions() {
    List<String> currentCuestions = [];
    for (int i = 0; i < _surveyModel.itemQuestions.length; i++) {
      currentCuestions.add(_surveyModel.itemQuestions[i]["question"] as String);
    }
    return currentCuestions;
  }

  void increaseCounter() {
    _surveyModel.counter++;
    notifyListeners();
  }

  int getCounter() {
    return _surveyModel.counter;
  }

  String getTitle() {
    return _surveyModel.title;
  }
}
