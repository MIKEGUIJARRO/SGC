import 'package:flutter/material.dart';

import '../constants/size_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool isRightEnabled;
  final bool isLeftEnabled;
  final IconButton iconLeft;
  final IconButton iconRight;

  CustomAppBar(
      { this.height = 120,
      @required this.isRightEnabled,
      @required this.isLeftEnabled,
      this.iconLeft,
      this.iconRight});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        
        
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                left: SizeConfig.safeBlockHorizontal * 7,
                child: isLeftEnabled ? iconLeft : SizedBox()),
            Positioned(
                child: Image.asset(
              "./assets/images/logo.png",
              width: SizeConfig.safeBlockHorizontal * 15,
            )),
             Positioned(
                right: SizeConfig.safeBlockHorizontal * 7,
                child: isRightEnabled ? iconRight : SizedBox(),)
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}
