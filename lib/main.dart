import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc_mvp/provider/survey.dart';

import './screens/authentication_screen.dart';
import './screens/home.dart';
import './screens/question.dart';

import './provider/survey_holder.dart';
import './provider/survey_holder.dart';

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
        )
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
          Home.routeName: (context) => Home(),
          Question.routeName: (context) => Question(),
        },
      ),
    );
  }
}
