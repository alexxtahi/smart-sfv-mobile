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
          //todo: Background
          DrawerBlurBackground(
            imageChoice: 2,
          ),
          //todo: Hide drawer button
          ConstrainedBox(
            constraints: BoxConstraints.expand(
              width: screenSize[0],
              height: screenSize[1],
            ),
            child: SafeArea(
              child: Column(),
            ),
          ),
          //todo: Hide drawer button
          Positioned(
            bottom: 0,
            right: 0,
            child: TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Fermer',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  /*Image.asset(
                    'assets/img/icons/previous.png',
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
