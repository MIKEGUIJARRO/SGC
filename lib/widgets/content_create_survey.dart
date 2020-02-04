import 'package:flutter/material.dart';

import '../constants/size_config.dart';

class ContentCreateSurvey extends StatelessWidget {
  final int index;
  final Function delete;
  final TextEditingController controller;
  final Key key;
  final int length;

  ContentCreateSurvey(
      {this.index, this.delete, this.key, this.controller, this.length});



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          elevation: 8,
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              right: 20,
              left: 20
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: SizeConfig.safeBlockVertical *10,
                  child: Stack(
                    overflow: Overflow.visible,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        child: Text("${index + 1}/10"),
                      ),
                      Positioned(
                          right: -10,
                          child: ButtonTheme(
                            padding: EdgeInsets.all(5),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            minWidth: 0, //wraps child's width
                            height: 0, //wraps child's height
                            child: FlatButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              child: Icon(Icons.remove),
                              shape: CircleBorder(),
                              onPressed: (length == 1 && index == 0)
                                  ? null
                                  : () => delete(index),
                            ),
                          ))
                    ],
                  ),
                ),
                TextField(
                  textInputAction: TextInputAction.done,
                  controller: controller,
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: "Pregunta ${index + 1}",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
