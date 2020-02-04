import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc_mvp/provider/survey.dart';

import './screens/authentication_screen.dart';
import './screens/home_screen.dart';
import './screens/question_screen.dart';
import './screens/create_survey_screen.dart';
import './provider/survey_holder.dart';
import './provider/surveys.dart';
import './screens/change_survey_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SurveyHolder(),
        ),
        ChangeNotifierProvider.value(
          value: Survey(),
        ),
        ChangeNotifierProvider.value(value: Surveys())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Color(0xff398B9F),
          scaffoldBackgroundColor: Colors.grey[200],
        ),
        initialRoute: AuthenticationScreen.routeName,
        routes: {
          AuthenticationScreen.routeName: (context) => AuthenticationScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          QuestionScreen.routeName: (context) => QuestionScreen(),
          CreateSurveyScreen.routeName: (context) => CreateSurveyScreen(),
          ChangeSurveyScreen.routeName: (context) => ChangeSurveyScreen(),
        },
      ),
    );
  }
}
