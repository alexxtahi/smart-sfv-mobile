import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyTextField.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/screens/banque/BanqueScreen.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/functions.dart' as functions;

class BanqueView extends StatefulWidget {
  BanqueView({Key? key}) : super(key: key);
  @override
  BanqueViewState createState() => BanqueViewState();
}

class BanqueViewState extends State<BanqueView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  TextEditingController textEditingController = TextEditingController();
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              scrollable: false,
              content: Center(
                child: Container(
                  decoration: BoxDecoration(
                      //color: Colors.red,
                      ),
                  child: Column(
                    children: [
                      //todo: Icon
                      Image.asset(
                        'assets/img/icons/bank-building.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                        color: Color.fromRGBO(60, 141, 188, 1),
                      ),
                      SizedBox(height: 20),
                      //todo: Libellé TextField
                      MyTextField(
                        textEditingController: this.textEditingController,
                        placeholder: 'Nom de la banque',
                        textColor: Color.fromRGBO(60, 141, 188, 1),
                        placeholderColor: Color.fromRGBO(60, 141, 188, 1),
                        fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                        borderRadius: Radius.circular(10),
                        focusBorderColor: Colors.transparent,
                        enableBorderColor: Colors.transparent,
                      ),
                      SizedBox(height: 10),
                      //todo: Save button
                      MyOutlinedButton(
                        text: 'Valider',
                        textColor: Colors.white,
                        backgroundColor: Color.fromRGBO(60, 141, 188, 1),
                        borderColor: Colors.transparent,
                        width: screenSize[0],
                        onPressed: () {
                          Navigator.pop(context);
                          functions.successSnackbar(
                            context: context,
                            message: 'Banque ajoutée avec succès !',
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      //todo: Cancel button
                      MyOutlinedButton(
                        text: 'Annuler',
                        textColor: Color.fromRGBO(221, 75, 57, 1),
                        backgroundColor: Color.fromRGBO(221, 75, 57, 0.15),
                        borderColor: Colors.transparent,
                        width: screenSize[0],
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            barrierDismissible: true,
          );
        },
        //backgroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(60, 141, 188, 1),
        child: Tooltip(
          message: 'Ajouter une banque',
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
          BanqueScreen(panelController: panelController),
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
