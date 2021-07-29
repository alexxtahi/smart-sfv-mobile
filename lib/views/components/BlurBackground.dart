import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';

class BlurBackground extends StatefulWidget {
  final double blurLevel;
  BlurBackground({
    Key? key,
    this.blurLevel = 10,
  }) : super(key: key);

  @override
  BlurBackgroundState createState() => BlurBackgroundState();
}

class BlurBackgroundState extends State<BlurBackground> {
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    return Container(
      width: screenSize[0],
      height: screenSize[1],
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              //AssetImage('assets/img/backgrounds/gestion-stock.jpg'),
              AssetImage('assets/img/backgrounds/storage-center.jpg'),
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
