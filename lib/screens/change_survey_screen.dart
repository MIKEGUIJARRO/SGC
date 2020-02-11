import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/size_config.dart';
import '../widgets/bottom_bar_tec.dart';
import '../widgets/custom_app_bar.dart';
import '../provider/survey.dart';

import '../provider/surveys.dart';

class ChangeSurveyScreen extends StatelessWidget {
  static const routeName = "/change_survey";

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  Widget _listBuilder(
      {BuildContext ctx,
      int index,
      String title,
      bool isSelected,
      int responses,
      String id}) {
    return Dismissible(
      key: ValueKey("$index$title"),
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
      onDismissed: (direction) =>
          Provider.of<Surveys>(ctx, listen: false).removeSurvey(id),
      direction: DismissDirection.endToStart,
      child: InkWell(
        onTap: () {
          final surveys = Provider.of<Surveys>(ctx, listen: false);
          surveys.selectSurvey(id);
          final newSelectedSurvey = surveys.getSelectedSurvey();

          Provider.of<Survey>(ctx, listen: false).initSurvey(
              title: newSelectedSurvey.title,
              counter: newSelectedSurvey.counter,
              id: newSelectedSurvey.id,
              questions: newSelectedSurvey.itemQuestions
                  .map((map) => map["question"] as String)
                  .toList());
        },
        focusColor: Colors.black12,
        child: ListTile(
          leading: isSelected
              ? Icon(
                  Icons.check,
                  color: Theme.of(ctx).accentColor,
                )
              : Icon(
                  null,
                  color: Theme.of(ctx).accentColor,
                ),
          title: Text(title),
          subtitle: Text("#$responses respuestas"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final surveysData = Provider.of<Surveys>(context);

    return Scaffold(
      key: _scaffoldState,
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
            itemCount: surveysData.surveys.length,
            itemBuilder: (ctx, i) => _listBuilder(
              ctx: ctx,
              index: i,
              isSelected: surveysData.surveys[i].isSelected,
              responses:
                  surveysData.surveys[i].itemQuestions[0]["responses"].length,
              title: surveysData.surveys[i].title,
              id: surveysData.surveys[i].id,
            ),
          )),
          BottomBarTec()
        ],
      )),
    );
  }
}
