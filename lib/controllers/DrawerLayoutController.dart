import 'package:flutter/cupertino.dart';
import 'ScreenController.dart';

class DrawerLayoutController {
  static double xOffset = 0;
  static double yOffset = 0;
  static double scaleFactor = 1;
  static bool isDrawerOpen = false;

  //todo: Open Drawer Method
  static void open(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    xOffset = screenSize[0] / 1.25;
    yOffset = (screenSize[1] / 2) - 410;
    scaleFactor = 0.9;
    isDrawerOpen = true;
  }

  //todo: Colse Drawer Method
  static void close() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
    isDrawerOpen = false;
  }
}
