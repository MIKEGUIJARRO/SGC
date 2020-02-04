import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_bar_tec.dart';
import '../constants/size_config.dart';
import '../widgets/error_alert.dart';
import '../widgets/content_question.dart';
import '../widgets/custom_app_bar.dart';

import '../provider/survey_holder.dart';

class QuestionScreen extends StatelessWidget {
  static const routeName = "/question";

  @override
  Widget build(BuildContext context) {
    //Continua escuchando la longitud de la lista para futuros cambios
    final surveyHolder = Provider.of<SurveyHolder>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        isRightEnabled: false,
        isLeftEnabled: true,
        iconLeft: IconButton(
            alignment: Alignment.centerLeft,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: surveyHolder.isEmpty()
                          ? ErrorAlert(
                              mensajeError:
                                  "Selecciona una encuesta o creá una nueva desde la barra de navegación",
                            )
                          : Swiper(
                              viewportFraction: 0.8,
                              scale: 0.9,
                              itemCount: surveyHolder.getLength(),
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
              BottomBarTec()
            ],
          ),
        ),
      ),
    );
  }
}
