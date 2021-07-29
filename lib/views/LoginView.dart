import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:smart_sfv_mobile/views/components/LoginBox.dart';
import '../controllers/ScreenController.dart';
import 'components/AppName.dart';
import 'layouts/ForgottenPasswordLayout.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  LoginBox loginBox = LoginBox(
    width: 350,
    height: 365,
  );
  // textfield controller
  @override
  Widget build(BuildContext context) {
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
    // Return building scaffold
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                //todo: Background
                Container(
                  width: screenSize[0],
                  height: screenSize[1],
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/img/backgrounds/storage-center.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
                //todo: Title
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppName(
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    //todo: Login Box
                    loginBox,
                  ],
                ),

                //todo: Signature
                Positioned(
                  bottom: 10,
                  child: Text(
                    '© All rights reserved. Group Smarty',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromRGBO(0, 0, 0, 0.3),
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
