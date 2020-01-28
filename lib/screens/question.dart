import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_bar_tec.dart';
import '../constants/size_config.dart';

import '../widgets/content_question.dart';
import '../provider/survey_holder.dart';

class Question extends StatelessWidget {
  static const routeName = "/question";

  @override
  Widget build(BuildContext context) {
    //Continua escuchando la longitud de la lista para futuros cambios
    final listLength = Provider.of<SurveyHolder>(context).getLength();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    /* horizontal: SizeConfig.safeBlockVertical * 10, */
                    top: SizeConfig.safeBlockVertical * 5,
                  ),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "./assets/images/logo.png",
                        width: SizeConfig.safeBlockHorizontal * 15,
                      ),
                      Expanded(
                        child: Swiper(
                          viewportFraction: 0.8,
                          scale: 0.9,
                          itemCount: listLength,
                          scrollDirection: Axis.horizontal,
                          loop: false,
                          pagination: SwiperPagination(
                              margin: EdgeInsets.only(
                            bottom: SizeConfig.safeBlockVertical * 3,
                          )),
                          itemBuilder: (context, i) {
                            return ContentQuestion(
                              index: i,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BottomBarTec()
            ],
          ),
        ),
      ),
    );
  }
}
