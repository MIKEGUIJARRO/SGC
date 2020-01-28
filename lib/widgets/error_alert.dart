import 'package:flutter/material.dart';

import '../constants/size_config.dart';

class ErrorAlert extends StatelessWidget {

  final String mensajeError;

  ErrorAlert({this.mensajeError});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        child: Container(
          padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockVertical * 3,
                        vertical: SizeConfig.safeBlockVertical * 3,
                      ),
          width: SizeConfig.safeBlockHorizontal * 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Ooops",
                style: TextStyle(
                    color: Colors.red[300], fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text(mensajeError,  textAlign: TextAlign.center,),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                padding: EdgeInsets.all(10),
                color: Colors.red[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Regresar",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
