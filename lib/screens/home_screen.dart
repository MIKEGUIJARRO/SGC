import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/size_config.dart';
import '../widgets/bottom_bar_tec.dart';
import '../widgets/survey_info.dart';
import '../screens/question_screen.dart';
import './create_survey_screen.dart';

import '../provider/survey.dart';
import '../provider/survey_holder.dart';
import '../screens/change_survey_screen.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _startSurvey(BuildContext context) {
    //Cargamos las preguntas a nuestro SurveyHolder
    List<String> questions =
        Provider.of<Survey>(context, listen: false).getQuestions();
    Provider.of<SurveyHolder>(context, listen: false)
        .initSurveyHolder(questions);
    Navigator.of(context).pushNamed(QuestionScreen.routeName);
  }

  void _createSurvey(BuildContext context) {
    Navigator.pushNamed(context, CreateSurveyScreen.routeName);
  }

  void _changeSurvey(BuildContext context) {
    Navigator.pushNamed(context, ChangeSurveyScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final _survey = Provider.of<Survey>(context);

    return Scaffold(
      key: _drawerKey,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        isRightEnabled: true,
        isLeftEnabled: true,
        iconLeft: IconButton(
            icon: Icon(Icons.sort),
            onPressed: () => _drawerKey.currentState.openDrawer()),
        iconRight: IconButton(
            icon: Icon(Icons.toll),
            onPressed: () => Provider.of<Survey>(context, listen: false).printResponses()),
      ),
      drawer: Drawer(
          child: ListView(children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).accentColor),
          arrowColor: Theme.of(context).accentColor,
          accountName: Text(
            "Empresa 01",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          accountEmail: Text(
            "empresa01@gmail.com",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        ListTile(
          title: Text("Cambiar encuesta"),
          leading: Icon(Icons.swap_vert),
          onTap: () => _changeSurvey(context),
        ),
        ListTile(
          title: Text("Crear encuesta"),
          leading: Icon(Icons.create),
          onTap: () => _createSurvey(context),
        ),
        ListTile(
          title: Text("Cerrar sesión"),
          leading: Icon(Icons.chevron_left),
          onTap: null,
        ),
        ListTile(
          title: Text("Información"),
          leading: Icon(Icons.info),
          onTap: null,
        ),
      ])),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 20,
                  vertical: SizeConfig.safeBlockVertical * 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _survey.getTitle(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    SurveyInfo(
                      num: _survey.getCounter(),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        padding: EdgeInsets.all(10),
                        color: Color(0xff28629C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Iniciar Encuesta",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () => _startSurvey(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 5,
            ),
            BottomBarTec()
          ],
        ),
      ),
    );
  }
}
