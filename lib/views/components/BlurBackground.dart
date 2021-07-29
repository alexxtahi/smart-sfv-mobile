import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';

class BlurBackground extends StatefulWidget {
  final double blurLevel;
  final int index;
  final int imageChoice;
  BlurBackground({
    Key? key,
    required this.index,
    this.blurLevel = 10,
    this.imageChoice = 1,
  }) : super(key: key);

  @override
  BlurBackgroundState createState() => BlurBackgroundState();
}

class BlurBackgroundState extends State<BlurBackground> {
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    if (widget.index == 1) {
      // ? First Background
      return Image.asset(
        'assets/img/backgrounds/stock1.jpg',
        width: screenSize[0],
        height: screenSize[1],
        fit: BoxFit.cover,
      );
    } else {
      // ? Second Background
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
            color: Colors.black.withOpacity(0.3),
          ),
        ),
      );
    }
  }
}
