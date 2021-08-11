import 'dart:math';
import 'package:flutter/material.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:transparent_image/transparent_image.dart';

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
  int bgindex = Random().nextInt(3);
  // Backgrounds list
  List<AssetImage> bglist = [
    AssetImage('assets/img/backgrounds/entrepot-blur.jpg'),
    AssetImage('assets/img/backgrounds/storage-center-blur.jpg'),
    AssetImage('assets/img/backgrounds/gestion-stock-blur.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    if (widget.index == 1) {
      // ? First Background
      return FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: AssetImage('assets/img/backgrounds/stock1.jpg'),
        width: screenSize[0],
        height: screenSize[1],
        fit: BoxFit.cover,
        //color: Colors.black.withOpacity(0.2),
        //colorBlendMode: BlendMode.darken,
        //),
      );
    } else {
      // ? Second Background
      return Container(
          width: screenSize[0],
          height: screenSize[1],
          child: FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            //image: AssetImage('assets/img/backgrounds/storage-center-blur.jpg'),
            //image: AssetImage('assets/img/backgrounds/entrepot-blur.jpg'),
            image: this.bglist[this.bgindex],
            width: screenSize[0],
            height: screenSize[1],
            fit: BoxFit.cover,
            //color: Colors.black.withOpacity(0.2),
            //colorBlendMode: BlendMode.darken,
            //),
          ));
    }
  }
}
