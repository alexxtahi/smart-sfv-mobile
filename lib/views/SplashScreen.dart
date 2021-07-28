import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';
import 'package:smart_sfv_mobile/views/HomeView.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  String backgroundUri = 'assets/img/Backgrounds/Dark.png';
  String iconUri = 'assets/img/Logos/NumeriZerLightIcon.png';

  @override
  void initState() {
    //todo: Start timer
    /*Timer(
      Duration(seconds: 5),
      () {
        print('Showing home view !');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeView()));
      },
    );*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  Image.asset(
                    'assets/img/warehouse.png',
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Theme.of(context).primaryColor,
                        fontSize: 34,
                      ),
                      children: [
                        TextSpan(
                          text: 'SMART-',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        TextSpan(
                          text: 'SFV',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
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
