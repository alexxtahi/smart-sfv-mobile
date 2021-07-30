import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';
import 'package:smart_sfv_mobile/views/components/BlurBackground.dart';
import 'package:smart_sfv_mobile/views/components/DrawerBlurBackground.dart';

class DrawerLayout extends StatefulWidget {
  DrawerLayout({
    Key? key,
  }) : super(key: key);
  @override
  DrawerLayoutState createState() => DrawerLayoutState();
}

class DrawerLayoutState extends State<DrawerLayout> {
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    // Return building scaffold
    return Container(
      width: screenSize[0],
      height: screenSize[1],
      child: Stack(
        children: [
          DrawerBlurBackground(
            imageChoice: 2,
          ),
        ],
      ),
    );
  }
}
