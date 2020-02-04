import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/size_config.dart';
import '../constants/color_gradient.dart';
import '../screens/home_screen.dart';

import '../provider/survey_holder.dart';
import '../provider/survey.dart';

class ContentQuestion extends StatefulWidget {
  final int index;

  ContentQuestion({
    this.index,
  });

  @override
  _ContentQuestionState createState() => _ContentQuestionState();
}

class _ContentQuestionState extends State<ContentQuestion> {
  bool _isBtnEnabled;

  double _value;
  String _question;
  bool _isLast;
  Color _colorSelected;

  bool _isInit = false;

  //Al momento de que se crea nuestra vista rellenamos la UI
  @override
  void didChangeDependencies() {
    if (_isInit == false) {
      final surveyHolder = Provider.of<SurveyHolder>(context, listen: false);
      _question = surveyHolder.getQuestion(widget.index);
      _isLast = surveyHolder.isLast(widget.index);
      _value = surveyHolder.getResponse(widget.index);
      _colorSelected = ColorGradient.calculateColor(val: _value);
      if (_value == 0.5) {
        //Si el valor se encuentra en medio entonces aun no se modifica
        _isBtnEnabled = false;
      } else {
        _isBtnEnabled = true;
      }

      _isInit = true;
    }
    super.didChangeDependencies();
  }

  void _onSave() {
    final surveyHolder = Provider.of<SurveyHolder>(context, listen: false);
    surveyHolder.cleanResponses();
    Provider.of<Survey>(context, listen: false)
        .addResponses(surveyHolder.getResponses());
    Provider.of<Survey>(context, listen: false).increaseCounter();
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        
        bottom: SizeConfig.safeBlockVertical * 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Card(
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(20), child: Text(_question)),
                Container(
                  color: _colorSelected,
                  height: 40,
                  width: double.infinity,
                )
              ],
            ),
          ),
          _isLast
              ? FloatingActionButton(
                  elevation: _isBtnEnabled ? 5 : 0,
                  backgroundColor: _isBtnEnabled
                      ? Theme.of(context).accentColor
                      : Colors.grey[400],
                  child: Icon(Icons.save),
                  onPressed: _isBtnEnabled ? _onSave : null,
                )
              : SizedBox(),
          Slider(
            value: _value,
            min: 0.0,
            max: 1.0,
            onChangeEnd: (lastRating) {
              Provider.of<SurveyHolder>(context, listen: false)
                  .setResponse(widget.index, lastRating);
            },
            onChanged: (newRating) {
              setState(() {
                _value = newRating;
                _colorSelected = ColorGradient.calculateColor(val: _value);
                if (_isLast) {
                  _isBtnEnabled = true;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
