import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/views/screens/tva/TvaScreen.dart';

class TvaView extends StatefulWidget {
  TvaView({Key? key}) : super(key: key);
  @override
  TvaViewState createState() => TvaViewState();
}

class TvaViewState extends State<TvaView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  TextEditingController textEditingController = TextEditingController();
  bool isNewBankEmpty = false;
  @override
  Widget build(BuildContext context) {
    if (ScreenController.actualView != "LoginView")
      ScreenController.actualView = "TvaView";
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
    GlobalKey scaffold = GlobalKey();
    return Scaffold(
      key: scaffold,
      body: Stack(
        children: [
          //todo: Drawer Screen
          DrawerLayout(panelController: panelController),
          //todo: Home Screen
          TvaScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            panelController: panelController,
          ),
        ],
      ),
    );
  }
}
