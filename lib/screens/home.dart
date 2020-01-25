import 'package:flutter/material.dart';

import '../constants/size_config.dart';
import '../widgets/bottom_bar_tec.dart';
import '../widgets/encuesta_info.dart';

class Home extends StatelessWidget {
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockVertical * 10,
                    vertical: SizeConfig.safeBlockVertical * 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(
                        "./assets/images/logo.png",
                        width: SizeConfig.safeBlockHorizontal * 20,
                      ),
                      const Text(
                        "Encuesta Titulo",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      EncuestaInfo(
                        num: "5",
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.all(10),
                          color: Color(0xff28629C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "Iniciar Encuesta",
                            style: TextStyle(
                              color: Colors.white,
                              
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 10,
              ),
              BottomBarTec()
            ],
          ),
        ),
      ),
    );
  }
}
