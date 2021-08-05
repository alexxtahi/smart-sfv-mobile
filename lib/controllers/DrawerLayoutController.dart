import 'package:flutter/material.dart';
import 'package:smartsfv/controllers/ScreenController.dart';

class DrawerLayoutController {
  static double xOffset = 0;
  static double yOffset = 0;
  static double scaleFactor = 1;
  static BorderRadius borderRadius = BorderRadius.circular(0);
  static bool isDrawerOpen = false;

  //todo: Open Drawer Method
  static void open(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    DrawerLayoutController.xOffset = screenSize[0] / 1.25;
    //DrawerLayoutController.yOffset = (screenSize[1] / 2) - 410;
    DrawerLayoutController.yOffset = 40;
    DrawerLayoutController.scaleFactor = 0.9;
    DrawerLayoutController.isDrawerOpen = true;
    DrawerLayoutController.borderRadius = BorderRadius.circular(20);
  }

  //todo: Close Drawer Method
  static void close() {
    DrawerLayoutController.xOffset = 0;
    DrawerLayoutController.yOffset = 0;
    DrawerLayoutController.scaleFactor = 1;
    DrawerLayoutController.isDrawerOpen = false;
    DrawerLayoutController.borderRadius = BorderRadius.circular(0);
  }
}
