import 'package:flutter/material.dart';

import '../constants/size_config.dart';

class BottomBarTec extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      width: SizeConfig.screenNoPaddingWidth,
      height: SizeConfig.safeBlockVertical * 8,
      color: Color(0xff398B9F),
      child: Image.asset(
        "assets/images/tec.jpg",
        alignment: Alignment.center,
        fit: BoxFit.contain,
      ),
    );
  }
}
