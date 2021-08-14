import 'dart:async';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/User.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/screens/home/HomeView.dart';
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
    super.initState();
  }

  Future<bool> verifyLastLogin() async {
    // ? Get the last login token from the cache
    try {
      // load SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // get token date and value
      String? token = prefs.getString('token');
      String? tokenExpDate = prefs.getString('tokenExpDate');
      print('token exp date -> $tokenExpDate');
      // check if the expiration date is arrive or passed
      if ((tokenExpDate != null &&
              DateTime.now().compareTo(DateTime.parse(tokenExpDate)) >= 0) ||
          tokenExpDate == null ||
          tokenExpDate == 'null') {
        // if the token is expired.. show the LoginView
        print('[AUTO CONNECTION] The last login token has expired !');
        return false;
      } else {
        // showing HomeView
        print('Last token -> $token');
        print('[AUTO CONNECTION] Loading home page...');
        User.token = (token != null) ? token : 'no token';
        // ? Get last user informations
        Api api = Api();
        Map<String, dynamic> userInfos = await api.getUserInfo(context);
        User.create(userInfos);
        print('Last user infos -> ${User.toMap()}'); // ! debug
        return true;
      }
    } catch (e) {
      print('Autologin Error -> $e');
      return false;
    }
  }

  @override
  void didChangeDependencies() {
    precacheImage(
        AssetImage('assets/img/backgrounds/storage-center.jpg'), context);
    precacheImage(
        AssetImage('assets/img/backgrounds/gestion-stock.jpg'), context);
    super.didChangeDependencies();
  }

  GlobalKey scaffold = GlobalKey();
  @override
  Widget build(BuildContext context) {
    if (ScreenController.actualView != "LoginView")
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
      key: scaffold,
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
              //todo: Loading bar
              Positioned(
                bottom: 50,
                child: (ScreenController.actualView != "LoginView")
                    ? FutureBuilder<bool>(
                        future: verifyLastLogin(),
                        builder: (verifyContext, snapshot) {
                          if (snapshot.hasData) {
                            // ? If the user is not disconnected
                            if (snapshot.data! == true) {
                              ScreenController.actualView = "HomeView";
                              //todo: Start timer
                              Timer(
                                Duration(seconds: 10),
                                () {
                                  print('Showing home view !');
                                  functions.openPage(
                                    context,
                                    HomeView(),
                                    mode: 'pushReplacement',
                                  );
                                },
                              );
                              return DelayedDisplay(
                                fadingDuration: Duration(milliseconds: 500),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                            Color.fromRGBO(60, 141, 188, 0.15),
                                        color: Color.fromRGBO(60, 141, 188, 1),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    MyText(
                                      text: 'Auto connexion...',
                                      color: Color.fromRGBO(204, 204, 204, 1),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ],
                                ),
                              );
                              // ? If the user is previously disconnected
                            } else {
                              //todo: Start timer
                              Timer(
                                Duration(seconds: 10),
                                () {
                                  print('Showing login view !');
                                  functions.openPage(
                                    context,
                                    LoginView(),
                                    mode: 'pushReplacement',
                                  );
                                },
                              );
                              return DelayedDisplay(
                                fadingDuration: Duration(milliseconds: 500),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                            Color.fromRGBO(60, 141, 188, 0.15),
                                        color: Color.fromRGBO(60, 141, 188, 1),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    MyText(
                                      text:
                                          'Lancement de la page de connexion...',
                                      color: Color.fromRGBO(204, 204, 204, 1),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                          return DelayedDisplay(
                            fadingDuration: Duration(milliseconds: 500),
                            child: CircularProgressIndicator(
                              backgroundColor:
                                  Color.fromRGBO(60, 141, 188, 0.15),
                              color: Color.fromRGBO(60, 141, 188, 1),
                            ),
                          );
                        })
                    : Container(),
              ),
              //todo: Signature
              Positioned(
                bottom: 10,
                child: MyText(
                  text: '© All rights reserved. Group Smarty',
                  color: Color.fromRGBO(204, 204, 204, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
