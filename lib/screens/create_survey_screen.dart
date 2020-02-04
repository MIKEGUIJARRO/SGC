import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_bar_tec.dart';
import '../constants/size_config.dart';
import '../widgets/content_create_survey.dart';
import '../widgets/alert_dialog_save.dart';
import '../provider/survey.dart';
import '../widgets/custom_app_bar.dart';

/* 
    Se busca el hacer la misma implementacion que se realizo con el Provider 
    SurveyHolder, sin embargo, mantendremos los estados de nuestras preguntas 
    dentro del widget, buscando de esta forma solventar el mismo problema desde
    otro acercamiento.
  */

class QuestionsHolder {
  final lim;
  final List<TextEditingController> _controllers = [
    TextEditingController(), //La primer pregunta siempre esta vacia
  ];

  QuestionsHolder({@required this.lim});

  void addController() {
    _controllers.add(TextEditingController());
  }

  void deleteController(int index) {
    _controllers.removeAt(index);
  }

  void updateProvider(BuildContext context, String title) {
    List<String> questions = [];
    try {
      for (var controller in _controllers) {
        if (controller.text.isNotEmpty) {
          questions.add(controller.text);
          print(controller.text.toString());
        } else {
          questions.add("empty");
          print("controller vacio");
        }
      }
      print("--------------------\n");
      Provider.of<Survey>(context, listen: false).initSurvey(
          counter: 0, questions: questions, title: title, responses: []);
    } catch (error) {
      print("Sucedio un error: $error");
    }
  }

  bool areEmptyQuestions() {
    for (TextEditingController controller in _controllers) {
      String question = controller.text;
      if (question.isEmpty) {
        return true;
      }
    }
    return false;
  }

  TextEditingController getController(int index) {
    return _controllers[index];
  }

  int getLength() {
    return _controllers.length;
  }

  bool isLimitReached() {
    if (_controllers.length < 10) {
      return false;
    } else {
      return true;
    }
  }

  void disposeControllers() {
    for (TextEditingController controller in _controllers) {
      controller.dispose();
    }
  }
}

class CreateSurveyScreen extends StatefulWidget {
  static final routeName = "/create_survey";

  /*
      Bug pendiente de revision:
      Lunes 3 de Febrero, 2020.

      Al momento de seleccionar el TextField los cards aledaños se elevan unas milesimas,
      considero que esto se debe a la transformacion de:

      scale: 0.9,

      dentro del swiper.
  */

  @override
  _CreateSurveyScreenState createState() => _CreateSurveyScreenState();
}

class _CreateSurveyScreenState extends State<CreateSurveyScreen> {
  final _questionsHolder = QuestionsHolder(lim: 10);

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _questionsHolder.disposeControllers();
    super.dispose();
  }

  void _showSnackBar(String text, Color color) {
    //Muestra si existe un textfield vacio.
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: color,
    );
    _scaffoldState.currentState.showSnackBar(snackBar);
  }

  void addQuestion() {
    if (_questionsHolder.getLength() < 10) {
      setState(() {
        _questionsHolder.addController();
      });
    }
  }

  void removeQuestion(int index) {
    if (_questionsHolder.getLength() > 1) {
      setState(() {
        _questionsHolder.deleteController(index);
      });
    }
  }

  void saveQuestions() {
    if (_questionsHolder.areEmptyQuestions() &&
        _questionsHolder.getLength() > 1) {
      _showSnackBar(
          "Elimina las tarjetas vacias para continuar.", Colors.red[300]);
    } else if (_questionsHolder.areEmptyQuestions() &&
        _questionsHolder.getLength() == 1) {
      _showSnackBar("Agrega más preguntas a las tarjetas.", Colors.grey[800]);
    } else {
      //Mostramos dialogo de cierre
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialogSave(
              disposeHolder: (String tituloDialog) {
                _questionsHolder.updateProvider(context, tituloDialog);
                Navigator.of(context).pop();
              },
            );
          });
    }
  }

  Widget _isKeyboardVisible() {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      return BottomBarTec();
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        isRightEnabled: true,
        isLeftEnabled: true,
        iconLeft: IconButton(
            alignment: Alignment.centerLeft,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop()),
        iconRight: IconButton(
          color: Theme.of(context).accentColor,
          icon: Icon(Icons.save),
          onPressed: saveQuestions,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Swiper(
                      viewportFraction: 0.8,
                      scale: 0.9,
                      itemCount: _questionsHolder.getLength(),
                      scrollDirection: Axis.horizontal,
                      loop: false,
                      pagination: SwiperPagination(
                          margin: EdgeInsets.only(
                        bottom: SizeConfig.safeBlockVertical * 3,
                      )),
                      containerWidth: 200,
                      containerHeight: 200,
                      itemHeight: 150,
                      itemWidth: 150,
                      layout: SwiperLayout.DEFAULT,
                      itemBuilder: (context, i) {
                        return ContentCreateSurvey(
                          index: i,
                          delete: removeQuestion,
                          key: ValueKey(i),
                          controller: _questionsHolder.getController(i),
                          length: _questionsHolder.getLength(),
                        );
                      },
                    ),
                    Positioned(
                      bottom: SizeConfig.safeBlockVertical * 5,
                      right: SizeConfig.safeBlockHorizontal * 8,
                      child: FloatingActionButton(
                        elevation: _questionsHolder.isLimitReached() ? 0 : 5,
                        backgroundColor: _questionsHolder.isLimitReached()
                            ? Colors.grey[400]
                            : Theme.of(context).accentColor,
                        child: Icon(Icons.add),
                        onPressed: _questionsHolder.isLimitReached()
                            ? null
                            : addQuestion,
                      ),
                    ),
                  ],
                ),
              ),
              _isKeyboardVisible(),
            ],
          ),
        ),
      ),
    );
  }
}
