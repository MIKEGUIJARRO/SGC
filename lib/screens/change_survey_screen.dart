import 'package:flutter/material.dart';

import '../constants/size_config.dart';
import '../widgets/custom_app_bar.dart';

class ChangeSurveyScreen extends StatefulWidget {
  static const routeName = "/change_survey";

  @override
  _ChangeSurveyScreenState createState() => _ChangeSurveyScreenState();
}

class _ChangeSurveyScreenState extends State<ChangeSurveyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeftEnabled: true,
        isRightEnabled: false,
        iconLeft: IconButton(
          alignment: Alignment.centerLeft,
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: ()=> Navigator.of(context).pop()),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(
              SizeConfig.safeBlockVertical * 5,
            ),
            child: Row(
              children: <Widget>[],
            ),
          )
        ],
      )),
    );
  }
}
