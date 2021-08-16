import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/User.dart';
import 'package:smartsfv/views/components/DrawerBlurBackground.dart';
import 'package:smartsfv/views/components/MyDrawerHeader.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/layouts/DrawerTileLayout.dart';

class DrawerLayout extends StatefulWidget {
  final SlidingUpPanelController panelController;
  DrawerLayout({Key? key, required this.panelController}) : super(key: key);
  @override
  DrawerLayoutState createState() => DrawerLayoutState();
}

class DrawerLayoutState extends State<DrawerLayout> {
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
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
                          MyDrawerHeader(
                              panelController: widget.panelController),
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
                              if (User.isConnected) {
                                // ? Show confirmation dialog
                                functions.logout(
                                  context,
                                  onValidate: () {
                                    // ? Show proceess indicator
                                    functions.showMessageToSnackbar(
                                      context: context,
                                      message: "Déconnexion en cours...",
                                      icon: CircularProgressIndicator(
                                        color: Colors.red,
                                        backgroundColor:
                                            Colors.red.withOpacity(0.5),
                                      ),
                                    );
                                    // ? Logout
                                    Api api = Api(); // Load API instance
                                    api.logout(context);
                                    User.isConnected = false;
                                  },
                                );
                              }
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
