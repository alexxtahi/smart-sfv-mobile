import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/views/screens/fournisseur/ProviderScreen.dart';

class ProviderView extends StatefulWidget {
  ProviderView({Key? key}) : super(key: key);
  @override
  ProviderViewState createState() => ProviderViewState();
}

class ProviderViewState extends State<ProviderView> {
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
        backgroundColor: Color.fromRGBO(221, 75, 57, 1),
        child: Tooltip(
          message: 'Ajouter un fournisseur',
          decoration: BoxDecoration(
            color: Color.fromRGBO(60, 141, 188, 1),
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
            'assets/img/icons/add-user.png',
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
          DrawerLayout(),
          //todo: Home Screen
          ProviderScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            username: 'Alexandre TAHI',
            panelController: panelController,
          ),
        ],
      ),
    );
  }
}
