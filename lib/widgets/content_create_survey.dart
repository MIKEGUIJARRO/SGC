import 'package:flutter/material.dart';

import '../constants/size_config.dart';

class ContentCreateSurvey extends StatelessWidget {
  final int index;
  final Function delete;
  final TextEditingController controller;
  final Key key;
  final int length;

  ContentCreateSurvey({ this.index, this.delete, this.key, this.controller, this.length});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.safeBlockVertical * 5,
        bottom: SizeConfig.safeBlockVertical * 5,
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
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  width: double.infinity,
                  height: SizeConfig.safeBlockVertical * 8,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        child: Text("${index + 1}/10"),
                      ),
                      Positioned(
                          right: 0,
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
                              onPressed: (length == 1 && index ==0) ? null: ()=> delete(index),
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: TextField(
                    controller: controller,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    decoration:
                        InputDecoration(hintText: "Pregunta ${index + 1}",
                        ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
