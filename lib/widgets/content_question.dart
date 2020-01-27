import 'package:flutter/material.dart';

import '../constants/size_config.dart';
import '../constants/color_gradient.dart';

class ContentQuestion extends StatefulWidget {
  final question;
  final Key key;

  ContentQuestion({this.question, this.key});

  @override
  _ContentQuestionState createState() => _ContentQuestionState();
}

class _ContentQuestionState extends State<ContentQuestion>
    with AutomaticKeepAliveClientMixin {


  
  bool keepAlive = false;
  double value = 0.5; 
  Color colorSelected = Color(0xAAd4d4d4);

  @override
  //Permite mantener el state de la app (ScrollBar) constante al swipear
  bool get wantKeepAlive => true;

  @override
  void updateKeepAlive() {
    // TODO: implement updateKeepAlive
    super.updateKeepAlive();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.safeBlockVertical * 5,
        bottom: SizeConfig.safeBlockVertical * 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(20), child: Text(widget.question)),
                Container(
                  color: colorSelected,
                  height: 40,
                  width: double.infinity,
                )
              ],
            ),
          ),
          Slider(
            value: value,
            min: 0.0,
            max: 1.0,
            onChanged: (newRating) {
              setState(() {
                value = newRating;
                colorSelected = ColorGradient.calculateColor(val: value);
              });
            },
          ),
        ],
      ),
    );
  }
}
