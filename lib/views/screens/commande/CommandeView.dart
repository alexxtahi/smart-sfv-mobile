import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/views/screens/commande/CommandeScreen.dart';

class CommandeView extends StatefulWidget {
  CommandeView({Key? key}) : super(key: key);
  @override
  CommandeViewState createState() => CommandeViewState();
}

class CommandeViewState extends State<CommandeView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  @override
  Widget build(BuildContext context) {
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
    // Return building scaffold
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        //mini: true,
        //splashColor: Colors.red,
        isExtended: true,
        elevation: 5,
        hoverElevation: 10,
        onPressed: () {},
        //backgroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(0, 27, 121, 1),
        child: Tooltip(
          message: 'Ajouter une commande',
          decoration: BoxDecoration(
            color: Color.fromRGBO(243, 156, 18, 1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
          ),
          child: Image.asset(
            'assets/img/icons/shopping-cart.png',
            color: Colors.white,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Stack(
        children: [
          //todo: Drawer Screen
          DrawerLayout(panelController: panelController),
          //todo: Home Screen
          CommandeScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            panelController: panelController,
          ),
        ],
      ),
    );
  }
}
