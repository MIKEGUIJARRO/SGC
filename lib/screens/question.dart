import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../widgets/bottom_bar_tec.dart';
import '../constants/size_config.dart';
import '../constants/questions.dart';
import '../widgets/content_question.dart';

class Question extends StatefulWidget {
  static const routeName = "/question";

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
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
                          itemCount: Questions.questions.length,
                          scrollDirection: Axis.horizontal,
                          loop: false,
                          pagination: SwiperPagination(
                            margin: EdgeInsets.only(
                              bottom: SizeConfig.safeBlockVertical * 2,
                            )
                          ),
                          itemBuilder: (context, index) {
                            return ContentQuestion(
                              key: ValueKey(index),  
                              question: Questions.questions[index],
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
