
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../widgets/bottom_bar_tec.dart';
import '../constants/size_config.dart';
import '../widgets/content_create_survey.dart';

/* 
    Se busca el hacer la misma implementacion que se realizo con el Provider 
    SurveyHolder, sin embargo, mantendremos los estados de nuestras preguntas 
    dentro del widget, buscando de esta forma solventar el mismo problema desde
    otro acercamiento.
  */

class QuestionsHolder {
  final lim;
  final List<TextEditingController> _controller = [
    TextEditingController(), //La primer pregunta siempre esta vacia
  ];

  QuestionsHolder({@required this.lim});

  void addController() {
    _controller.add(TextEditingController());
  }

  void deleteController(int index) {
    _controller.removeAt(index);
  }

  List<String> getQuestions(BuildContext ctx) { // pendiente de implementar
    List<String> questions;
    for (TextEditingController controller in _controller) {
      String question = controller.text;
      if(!question.isEmpty){
        questions.add(question);
      }
    }
    if (questions.isEmpty) {
      print("sad");
      
    }
    return questions;
  }

  TextEditingController getController(int index){
    return _controller[index];
  }

  int getLength() {
    return _controller.length;
  }

  bool isLimitReached() {
    if (_controller.length < 10) {
      return false;
    } else {
      return true;
    }
  }
}

class CreateSurveyScreen extends StatefulWidget {
  static final routeName = "/create_survey";

  @override
  _CreateSurveyScreenState createState() => _CreateSurveyScreenState();
}

class _CreateSurveyScreenState extends State<CreateSurveyScreen> {
  final _questionsHolder = QuestionsHolder(lim: 10);


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
        print("Eliminado");
      });
    }
  }

  void saveQuestions() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    /* horizontal: SizeConfig.safeBlockVertical * 10, */
                    top: SizeConfig.safeBlockVertical * 5,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        right: SizeConfig.safeBlockHorizontal * 8,
                        top: 0,

                        child: IconButton(
                          color: Theme.of(context).accentColor,
                          icon: Icon(Icons.save),
                          onPressed: saveQuestions,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset(
                            "./assets/images/logo.png",
                            width: SizeConfig.safeBlockHorizontal * 15,
                          ),
                          Expanded(
                            child: Swiper(
                              viewportFraction: 0.8,
                              scale: 0.9,
                              itemCount: _questionsHolder.getLength(),
                              scrollDirection: Axis.horizontal,
                              loop: false,
                              pagination: SwiperPagination(
                                  margin: EdgeInsets.only(
                                bottom: SizeConfig.safeBlockVertical * 3,
                              )),
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
                          )
                        ],
                      ),
                      Positioned(
                        bottom: SizeConfig.safeBlockHorizontal * 5,
                        right: SizeConfig.safeBlockHorizontal * 5,
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
                      )
                    ],
                  ),
                ),
              ),
              BottomBarTec()
            ],
          ),
        ),
      ),
    );
  }
}
