import 'package:flutter/material.dart';

import './screens/authentication_screen.dart';
import './screens/home.dart';
import './screens/question.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
  
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: AuthenticationScreen(),
      
      routes: {
        Home.routeName: (context)=> Home(),
        Question.routeName: (context)=> Question(),
      },
    );
  }
}
