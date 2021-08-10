import 'dart:async';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/screens/login/LoginView.dart';
import 'package:smartsfv/views/components/AppName.dart';
import 'package:smartsfv/functions.dart' as functions;

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //todo: Start timer
    Timer(
      Duration(seconds: 5),
      () {
        print('Showing home view !');
        functions.openPage(context, LoginView(), mode: 'pushReplacement');
      },
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(
        AssetImage('assets/img/backgrounds/storage-center.jpg'), context);
    precacheImage(
        AssetImage('assets/img/backgrounds/gestion-stock.jpg'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ScreenController.actualView = "SplashScreen";
    List<double> screenSize = ScreenController.getScreenSize(context);
    //todo: Load icon and background function of the recent app theme
    // Change system UI properties
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    // lock screen orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Return building scaffold
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: screenSize[0],
          height: screenSize[1],
          child: Stack(
            alignment: Alignment.center,
            children: [
              //todo: Splash screen icon
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DelayedDisplay(
                    delay: Duration(seconds: 1),
                    child: Image.asset(
                      'assets/img/motion-design/warehouse.png',
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
                  ),
                  AppName(),
                ],
              ),
              //todo: Signature
              Positioned(
                bottom: 10,
                child: Text(
                  '© All rights reserved. Group Smarty',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(204, 204, 204, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
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
