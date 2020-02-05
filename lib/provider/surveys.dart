import 'package:flutter/material.dart';

import '../models/survey_model.dart';

class Surveys with ChangeNotifier {
  List<SurveyModel> _surveysModel = [];

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
    final surveyRemoved = _surveysModel.firstWhere((survey) => survey.id == id);
    _surveysModel.remove(surveyRemoved);
    notifyListeners();
  }

  SurveyModel selectSurvey(String id) {
    for (int i = 0; i < _surveysModel.length; i++) {
      _surveysModel[i].isSelected = false;
    }
    for (int i = 0; i < _surveysModel.length; i++) {
      if (_surveysModel[i].id == id) {
        _surveysModel[i].isSelected = true;
        notifyListeners();
        return _surveysModel[i];
      }
    }
  }

  void fetchAndGetSurveys() {}

  int getLength() {
    return _surveysModel.length;
  }
}
