import 'package:flutter/material.dart';

import '../models/survey_model.dart';

class Surveys with ChangeNotifier {
  List<SurveyModel> _surveysModel = [
    SurveyModel(
      id: "0102",
      title: "Encuesta de amor",
      counter: 50,
      isSelected: true,
      itemQuestions: [
        {"question": "Pregunta 1", "responses": []},
        {"question": "Pregunta 2", "responses": []},
        {"question": "Pregunta 3", "responses": []}
      ]),
      SurveyModel(
      id: "0103",
      title: "Encuesta de edad",
      counter: 20,
      isSelected: false,
      itemQuestions: [
        {"question": "Pregunta 1", "responses": []},
        {"question": "Pregunta 2", "responses": []},
        {"question": "Pregunta 3", "responses": []}
      ]),
      SurveyModel(
      id: "0104",
      title: "Encuesta de enfermedad",
      counter: 0,
      isSelected: false,
      itemQuestions: [
        {"question": "Pregunta 1", "responses": []},
        {"question": "Pregunta 2", "responses": []},
        {"question": "Pregunta 3", "responses": []}
      ]),
      SurveyModel(
      id: "0107",
      title: "Encuesta de odio",
      counter: 1,
      isSelected: false,
      itemQuestions: [
        {"question": "Pregunta 1", "responses": []},
        {"question": "Pregunta 2", "responses": []},
        {"question": "Pregunta 3", "responses": []}
      ])
  ];

  List<SurveyModel> get surveys {
    return [..._surveysModel];
  }

  void addSurvey(
      {@required String id,
      @required String title,
      int counter = 0,
      @required List<String> questions}) {

    _surveysModel.forEach((survey) => survey.isSelected = false);

    _surveysModel.add(SurveyModel(
        id: id,
        title: title,
        counter: counter,
        isSelected: true,
        itemQuestions: questions
            .map((question) => {"question": question, "responses": []})
            .toList()));

            print("SurveysModelLength: ${_surveysModel.length}");
    notifyListeners();
  }

  void removeSurvey(String id) {
    final surveyRemoved = _surveysModel.firstWhere((survey)=>survey.id == id);
    _surveysModel.remove(surveyRemoved);
    notifyListeners();
  }

  void selectSurvey(String id) {
    for (int i = 0;i < _surveysModel.length;i++) {
      _surveysModel[i].isSelected = false;
    }
    for (int i = 0; i < _surveysModel.length; i++) {
      if (_surveysModel[i].id == id) {
        _surveysModel[i].isSelected = true;
        notifyListeners();
        return;
      } 
    }
  }


  void fetchAndGetSurveys() {

  }
}
