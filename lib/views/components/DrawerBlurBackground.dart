import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';

class DrawerBlurBackground extends StatefulWidget {
  final double blurLevel;
  final int imageChoice;
  DrawerBlurBackground({
    Key? key,
    this.blurLevel = 10,
    this.imageChoice = 1,
  }) : super(key: key);

  @override
  DrawerBlurBackgroundState createState() => DrawerBlurBackgroundState();
}

class DrawerBlurBackgroundState extends State<DrawerBlurBackground> {
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    return Container(
      width: screenSize[0],
      height: screenSize[1],
      decoration: BoxDecoration(
        image: DecorationImage(
          image: (widget.imageChoice == 1)
              ? AssetImage('assets/img/backgrounds/gestion-stock.jpg')
              : AssetImage('assets/img/backgrounds/storage-center.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: widget.blurLevel, sigmaY: widget.blurLevel),
        child: Container(
          color: Color.fromRGBO(60, 141, 188, 1).withOpacity(0.7),
        ),
      ),
    );
  }
}
