import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartsfv/views/components/BlurBackground.dart';
import 'package:smartsfv/views/screens/login/LoginBox.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/AppName.dart';
import 'package:smartsfv/views/layouts/ForgottenPasswordLayout.dart';

// ignore: must_be_immutable
class LoginView extends StatefulWidget {
  LoginView({
    Key? key,
  }) : super(key: key);
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  LoginBox loginBox = LoginBox();
  @override
  void initState() {
    super.initState();
  }

  // textfield controller
  @override
  Widget build(BuildContext context) {
    ScreenController.actualView = "LoginView";
    List<double> screenSize = ScreenController.getScreenSize(context);
    // Change system UI properties
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    // lock screen orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Return building scaffold
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(60, 141, 188, 1),
                //Color.fromRGBO(100, 27, 121, 1),
                Colors.white,
              ],
            ),
          ),
          child: Scaffold(
            //backgroundColor: Color.fromRGBO(155, 155, 155, 1),
            backgroundColor: Colors.transparent,
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                //todo: Background
                BlurBackground(
                  index: 2,
                  imageChoice: 2,
                ),
                //todo: Title
                Container(
                  width: screenSize[0],
                  height: screenSize[1],
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //todo: Title
                      AppName(
                        color: Colors.white,
                      ),
                      SizedBox(height: 20),
                      //todo: Login Box
                      loginBox,
                    ],
                  ),
                ),
                //todo: Copyrights
                Positioned(
                  bottom: 10,
                  child: Text(
                    '© All rights reserved. Group Smarty',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      //color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ForgottenPasswordLayout(
          title: 'Réinitialiser votre mot de passe',
          panelController: loginBox.panelController,
        ),
      ],
    );
  }
}
