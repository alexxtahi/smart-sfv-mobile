import 'package:flutter/material.dart';

class ScreenController {
  static String actualView = "SplashScreen";
  static bool isChildView = false;
  static bool reloadDashboard = true;
  //todo: Getter for screen width & height
  static List<double> getScreenSize(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return [screenWidth, screenHeight];
  }
}
