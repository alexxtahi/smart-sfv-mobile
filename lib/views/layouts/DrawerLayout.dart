import 'package:flutter/material.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/screens/others/LoginView.dart';
import 'package:smartsfv/views/components/DrawerBlurBackground.dart';
import 'package:smartsfv/views/components/MyDrawerHeader.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/layouts/DrawerTileLayout.dart';

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
                          //todo: Logout button
                          MyOutlinedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/img/icons/exit.png',
                                  color: Color.fromRGBO(1, 21, 122, 1),
                                  width: 30,
                                  height: 30,
                                ),
                                MyText(
                                  text: 'Déconnexion',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ],
                            ),
                            width: screenSize[0] / 1.25,
                            height: 50,
                            borderRadius: 15,
                            borderColor: Colors.white,
                            textColor: Colors.white,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            onPressed: () {
                              functions.openPage(
                                context,
                                LoginView(),
                                mode: 'pushReplacement',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
