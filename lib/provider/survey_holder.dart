import 'package:flutter/foundation.dart';

class SurveyHolderItem {
  final String question;
  double response;

  SurveyHolderItem({@required this.question, @required this.response});
}

class SurveyHolder with ChangeNotifier {
  List<SurveyHolderItem> _surveyHolderItems = [
    SurveyHolderItem(
        question: "1. Lorem ipsum dolor sit amet?", response: null),
    SurveyHolderItem(
        question: "2. Lorem ipsum dolor sit amet?", response: null),
    SurveyHolderItem(
        question: "3. Lorem ipsum dolor sit amet?", response: null),
  ];

  int getLength() {
    return _surveyHolderItems.length;
  }

  //Devolver pregunta, no hace falta notifyListeners()
  String getQuestion(int index) {
    return _surveyHolderItems[index].question;
  }

  bool isLast(int index) {
    if (index == _surveyHolderItems.length - 1) {
      return true;
    }
    return false;
  }

  void setResponse(int index, double value) {
    _surveyHolderItems[index].response = value;
  }

  double getResponse(int index) {
    if (_surveyHolderItems[index].response == null) {
      return 0.5;
    }
    return _surveyHolderItems[index].response;
  }

  Future<void> cleanResponses() async {
    //Esperamos 500 milisegundos para realizar el cambio de pantalla y eliminar los datos
    Future.delayed(Duration(milliseconds: 5), () {
      _surveyHolderItems.forEach((element) {
        element.response = null;
      });
      print("Eliminados");
      notifyListeners();
    });
  }
}
