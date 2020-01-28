import 'package:flutter/material.dart';

import 'package:sgc_mvp/constants/circle.dart';
import '../widgets/bottom_bar_tec.dart';
import '../constants/size_config.dart';
import './home_screen.dart';

class AuthenticationScreen extends StatefulWidget {

  static const routeName = "/";
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();

  String _validator(String value) {
    if (value == "1") {
      return null;
    }
    if (value.isEmpty) {
      return "Ingresa la clave";
    } else {
      return "Clave incorrecta";
    }
  }

  void _btnValidar() {
    if (_formKey.currentState.validate()) {
      print("Codigo correcto");
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Inicializamos SizeConfig para obtener medidas
    final size = SizeConfig();
    size.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Stack(
            alignment: Alignment.center,
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                  top: SizeConfig.safeBlockHorizontal * (-30),
                  right: SizeConfig.safeBlockHorizontal * (-20),
                  child: Circle(
                    radio: SizeConfig.safeBlockHorizontal * 65,
                    color: Color(0xff409FA0),
                  )),
              Positioned(
                  top: SizeConfig.safeBlockHorizontal * (-45),
                  left: SizeConfig.safeBlockHorizontal * (-5),
                  child: Circle(
                    radio: SizeConfig.safeBlockHorizontal * 70,
                    color: Color(0xff49B3A1),
                  )),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: SizeConfig.safeBlockVertical * 15,
                  ),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/logo.png",
                        width: SizeConfig.safeBlockHorizontal * 25,
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 300,
                        ),
                        child: const Text(
                          "Bienvenido al Sistema de Gestión de Calidad",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                      ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 300),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              validator: _validator,
                              textAlign: TextAlign.center,
                              maxLength: 8,
                              onChanged: (value) {},
                              keyboardType: TextInputType.number,
                            ),
                          )),
                      Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                      SizedBox(
                        width: 300,
                        child: FlatButton(
                          color: Color(0xff28629C),
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Validar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _btnValidar,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: SizedBox(),
                      ),
                      BottomBarTec()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
