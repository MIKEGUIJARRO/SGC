import 'package:flutter/material.dart';

import '../constants/size_config.dart';
import '../constants/color_gradient.dart';
import '../screens/home.dart';

class ContentQuestion extends StatefulWidget {
  final question;
  final Key key;
  final isLast;

  ContentQuestion({this.question, this.key, this.isLast});

  @override
  _ContentQuestionState createState() => _ContentQuestionState();
}

class _ContentQuestionState extends State<ContentQuestion>
    with AutomaticKeepAliveClientMixin {
  bool btnEnabled = false;
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

  void _onSave(){
    Navigator.of(context).pushReplacementNamed(Home.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.safeBlockVertical * 5,
        bottom: SizeConfig.safeBlockVertical * 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
          widget.isLast && btnEnabled
              ? FlatButton.icon(
                  textColor: Colors.white,
                  label: Text(
                    "Guardar",
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Theme.of(context).accentColor,
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  onPressed: _onSave,
                )
              : SizedBox(),
          Slider(
            value: value,
            min: 0.0,
            max: 1.0,
            onChanged: (newRating) {
              setState(() {
                value = newRating;
                colorSelected = ColorGradient.calculateColor(val: value);
                if (widget.isLast) {
                  btnEnabled = true;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
