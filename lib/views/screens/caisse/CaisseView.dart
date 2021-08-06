import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyTextField.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/views/screens/caisse/CaisseScreen.dart';
import 'package:smartsfv/functions.dart' as functions;

class CaisseView extends StatefulWidget {
  CaisseView({Key? key}) : super(key: key);
  @override
  CaisseViewState createState() => CaisseViewState();
}

class CaisseViewState extends State<CaisseView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  TextEditingController textEditingController = TextEditingController();
  bool isNewBankEmpty = false;
  String dropDownValue = 'Sélectionner un dépôt';
  List<String> depotlist = ['Sélectionner un dépôt', 'Two', 'Free', 'Four'];
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
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
        isExtended: true,
        elevation: 5,
        hoverElevation: 10,
        onPressed: () async {
          await functions.showInformationDialog(context);
        },
        backgroundColor: Color.fromRGBO(60, 141, 188, 1),
        child: Tooltip(
          message: 'Ajouter un régime',
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
          child: Icon(
            Icons.add_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          //todo: Drawer Screen
          DrawerLayout(),
          //todo: Home Screen
          CaisseScreen(panelController: panelController),
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
