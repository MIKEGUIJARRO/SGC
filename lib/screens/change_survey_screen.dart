import 'package:flutter/material.dart';

import '../constants/size_config.dart';
import '../widgets/bottom_bar_tec.dart';
import '../widgets/custom_app_bar.dart';

class ChangeSurveyScreen extends StatefulWidget {
  static const routeName = "/change_survey";

  @override
  _ChangeSurveyScreenState createState() => _ChangeSurveyScreenState();
}

class _ChangeSurveyScreenState extends State<ChangeSurveyScreen> {
  Widget _listBuilder(
    BuildContext ctx,
    int index,
  ) {
    return Dismissible(
      key: ValueKey(index),
      background: Container(
        padding: EdgeInsets.only(
          right: SizeConfig.safeBlockHorizontal * 8,
        ),
        color: Colors.red[300],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),
      onDismissed: (direction) => print(direction),
      direction: DismissDirection.endToStart,
      child: InkWell(
        onTap: () => print("ontap"),
        focusColor: Colors.black12,
        child: ListTile(
          leading: Icon(
            Icons.check,
            color: Theme.of(context).accentColor,
          ),
          title: Text("Titulo encuesta"),
          subtitle: Text("#$index respuestas"),
        ),
      ),
    );
  }

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
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx, i) => _listBuilder(ctx, i),
          )),
          BottomBarTec()
        ],
      )),
    );
  }
}
