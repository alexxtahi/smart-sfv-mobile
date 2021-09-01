import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/screens/pays/PaysScreen.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';

class PaysView extends StatefulWidget {
  PaysView({Key? key}) : super(key: key);
  @override
  PaysViewState createState() => PaysViewState();
}

class PaysViewState extends State<PaysView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController paysController = TextEditingController();
  bool isNewPaysEmpty = false;
  GlobalKey scaffold = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // ! Configs
    ScreenController.isChildView = true;
    if (ScreenController.actualView != "LoginView")
      ScreenController.actualView = "PaysView";
    // Change system UI properties
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    // lock screen orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Return building Scaffold
    return Scaffold(
      key: scaffold,
      body: Stack(
        children: [
          //todo: Drawer Screen
          DrawerLayout(panelController: panelController),
          //todo: Home Screen
          PaysScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            panelController: panelController,
          ),
        ],
      ),
    );
  }
}
