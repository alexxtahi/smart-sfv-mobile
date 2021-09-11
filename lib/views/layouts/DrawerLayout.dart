import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Auth.dart';
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
    return GestureDetector(
      // ? Open or close drawer function of the gesture
      onHorizontalDragUpdate: (DragUpdateDetails drag) {
        int sensitivity = 8;
        setState(() {
          if (drag.delta.dx > sensitivity)
            DrawerLayoutController.open(context);
          else if (drag.delta.dx < sensitivity) DrawerLayoutController.close();
        });
      },
      child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                if (Auth.user!.isConnected) {
                                  // ? Show confirmation dialog
                                  functions.logout(
                                    context,
                                    onValidate: () {
                                      // Pop previous Dialog
                                      Navigator.pop(context);
                                      // ? Show loading AlertDialog
                                      functions.showFormDialog(
                                        context,
                                        GlobalKey<FormState>(),
                                        barrierDismissible: false,
                                        headerIconColor: Colors.red,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        hasHeaderIcon: false,
                                        hasSnackbar: false,
                                        hasHeaderTitle: false,
                                        hasCancelButton: false,
                                        hasValidationButton: false,
                                        formElements: [
                                          Center(
                                            child: Column(
                                              children: [
                                                //todo: Progress bar
                                                CircularProgressIndicator(
                                                  color: Color.fromRGBO(
                                                      60, 141, 188, 1),
                                                  backgroundColor: Colors.white
                                                      .withOpacity(0.1),
                                                  strokeWidth: 5,
                                                ),
                                                SizedBox(height: 15),
                                                //todo: Logout text
                                                MyText(
                                                  text:
                                                      'Déconnexion en cours...',
                                                  fontSize: 16,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                      // ? Logout
                                      Api api = Api(); // Load API instance
                                      // Call logout method
                                      api.logout(context).then((value) {
                                        Auth.user!.isConnected = false;
                                      });
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
      ),
    );
  }
}
