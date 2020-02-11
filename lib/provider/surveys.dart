import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/survey_model.dart';

class Surveys with ChangeNotifier {
  List<SurveyModel> _surveysModel = [];

  List<SurveyModel> get surveys {
    return [..._surveysModel];
  }

  void addSurvey(
      {@required String title,
      int counter = 0,
      @required List<String> questions}) async {
    //Implementacion Firebase
    try {
      final url =
          "https://sgc-itesm-servicio-social.firebaseio.com/surveys.json";

      final response = await http.post(url,
          body: json.encode({
            "title": title,
            "counter": counter,
            "isSelected": true,
            "itemQuestions": questions
                .map((question) => {
                      "question": question,
                      "responses": [null]
                    })
                .toList(),
          }));

      final id = json.decode(response.body)["name"];
      var idHolder = "";

      //Deselecciona las encuestas seleccionadas
      _surveysModel.forEach((survey) {
        //Descartamos el id que acabamos de crear
        if (survey.id != id) {
          idHolder = survey.id;
          final patchUrl =
              "https://sgc-itesm-servicio-social.firebaseio.com/surveys/$idHolder.json";
          http.patch(patchUrl, body: json.encode({"isSelected": false}));
        }
      });

      //Implementacion local
      _surveysModel.forEach((survey) => survey.isSelected = false);

      _surveysModel.add(SurveyModel(
          id: id,
          title: title,
          counter: counter,
          isSelected: true,
          itemQuestions: questions
              .map((question) => {"question": question, "responses": []})
              .toList()));

      notifyListeners();
    } catch (error) {
      print("Sucedio un error al momento de agregar una encuesta");
    }
  }

  void removeSurvey(String id) async {
    //Pendiente de implementar opthimistic ui
    int index = _surveysModel.indexWhere((survey) => survey.id == id);
    _surveysModel.removeAt(index);
    notifyListeners();

    try {
      final url =
          "https://sgc-itesm-servicio-social.firebaseio.com/surveys/$id.json";
      await http.delete(url);
    } catch (error) {
      print("Sucedio un error al momento de eliminar una encuesta");
    }
  }

  SurveyModel getSelectedSurvey() {
    int indexSelected =
        _surveysModel.indexWhere((survey) => survey.isSelected == true);
    return _surveysModel[indexSelected];
  }

  //Select survey pendiente
  void selectSurvey(String id) async {
    var idHolder = "";
    try {
      //Cambio de manera local y en firebase
      _surveysModel.forEach((survey) {
        idHolder = survey.id;
        final patchUrl =
            "https://sgc-itesm-servicio-social.firebaseio.com/surveys/$idHolder.json";

        if (survey.id != id) {
          //Si no es el seleccionado lo deseleccionamos
          survey.isSelected = false;

          http.patch(patchUrl, body: json.encode({"isSelected": false}));
        } else {
          survey.isSelected = true;
          http.patch(patchUrl, body: json.encode({"isSelected": true}));
        }
      });
    } catch (error) {}

    notifyListeners();
  }

  void fetchAndSetSurveys() async {
    try {
      final url =
          "https://sgc-itesm-servicio-social.firebaseio.com/surveys.json";
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        print("Error status code: ${response.statusCode}");
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      print(extractedData);

    } catch (error) {
      print("Error al momento de descargar la info: ");
      print(error);
    }
  }

  int getLength() {
    return _surveysModel.length;
  }

  String getSelectedId() {
    String id;
    _surveysModel.forEach((item) {
      if (item.isSelected) {
        id = item.id;
      }
    });
    return id;
  }

  void increaseCounter(String id) async {
    //Solo aplica funcionalidad para firebase...
    //Pendiente, refactor de Providers...
    print("id: $id");
    print("Longitud surveys:${_surveysModel.length}");
    int index = _surveysModel.indexWhere((survey) => survey.id == id);

    //Incrementamos el valor de nuestro valor
    _surveysModel[index].counter++;
    var currentCounter = _surveysModel[index].counter;
    print(currentCounter);
    print("currentCounter: $currentCounter");

    try {
      var url =
          "https://sgc-itesm-servicio-social.firebaseio.com/surveys/$id.json";
      final response =
          await http.patch(url, body: json.encode({"counter": currentCounter}));
    } catch (error) {
      print("Sucedio un error al momento de agregar el counter");
    }
  }

  void addResponsesItem(List<double> responses, String id) async {
    //Se agregan las respuestas de manera local y en la nube
    //Cada indice de pregunta pasa su indice de respuesta

    print(id);
    try {
      final index = _surveysModel.indexWhere((survey) => survey.id == id);

      for (int i = 0; i < responses.length; i++) {
        if (responses[i] == null) {
          responses[i] = 0.5;
        }
        _surveysModel[index].itemQuestions[i]["responses"].add(responses[i]);

        final url =
            "https://sgc-itesm-servicio-social.firebaseio.com/surveys/$id/itemQuestions/$i/responses.json";
        final response =
            await http.post(url, body: jsonEncode({"responses": responses[i]}));

        if (response.statusCode >= 400) {
          print("Se obtuvo un error en la asignacion de RESPONSES en Firebase");
        }
      }
    } catch (error) {
      print("Sucedio un error al momento de agregar las respuestas");
    }

    notifyListeners();
  }
}
