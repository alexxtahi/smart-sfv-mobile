import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/controllers/DrawerLayoutController.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';
import 'package:smart_sfv_mobile/views/components/DrawerBlurBackground.dart';
import 'package:smart_sfv_mobile/views/components/MyDrawerHeader.dart';
import 'package:smart_sfv_mobile/views/layouts/DrawerTileLayout.dart';

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
          //todo: Darawer Content
          ConstrainedBox(
            constraints: BoxConstraints.expand(
              width: screenSize[0] / 1.25,
              height: screenSize[1],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          //todo: Drawer Header
                          MyDrawerHeader(),
                          SizedBox(height: 30),
                          //todo: Drawer Tiles
                          DrawerTileLayout(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //todo: Hide drawer button
          Positioned(
            bottom: 0,
            right: 0,
            child: TextButton(
              onPressed: () {
                setState(() {
                  DrawerLayoutController.close();
                });
              },
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
