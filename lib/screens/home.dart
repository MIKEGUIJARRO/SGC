import 'package:flutter/material.dart';

import '../constants/size_config.dart';
import '../widgets/bottom_bar_tec.dart';
import '../widgets/encuesta_info.dart';
import '../screens/question.dart';

class Home extends StatelessWidget {

  static const routeName = "/home";

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _iniciarEncuesta(BuildContext context) {
    Navigator.of(context).pushNamed(Question.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor
              ),
              arrowColor: Theme.of(context).accentColor,
              accountName: Text("Empresa 01", style: TextStyle(color: Colors.white,),),
              accountEmail: Text("empresa01@gmail.com", style:TextStyle(color: Colors.white,),),
              
            ),
            ListTile(
              title: Text("Cambiar encuesta"),
              leading: Icon(Icons.swap_vert),
              onTap: (){},
            ),
            ListTile(
              title: Text("Cerrar sesión"),
              leading: Icon(Icons.chevron_left),
              onTap: (){},
            ),
            
            ListTile(
              title: Text("Información"),
              leading: Icon(Icons.info),
              onTap: (){},
            ),
          ],
        )
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                child: IconButton(
                  icon: Icon(Icons.sort),
                  onPressed: (){
                    _drawerKey.currentState.openDrawer();
                  },
                ),
              ),
              Column(
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
                            width: SizeConfig.safeBlockHorizontal * 15,
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
                              onPressed: () => _iniciarEncuesta(context),
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
            ],
          ),
        ),
      ),
    );
  }
}
