import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyTextField.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/views/screens/regime/RegimeScreen.dart';
import 'package:smartsfv/functions.dart' as functions;

class RegimeView extends StatefulWidget {
  RegimeView({Key? key}) : super(key: key);
  @override
  RegimeViewState createState() => RegimeViewState();
}

class RegimeViewState extends State<RegimeView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  TextEditingController textEditingController = TextEditingController();
  bool isNewBankEmpty = false;
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
                        'assets/img/icons/regim.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                        color: Color.fromRGBO(60, 141, 188, 1),
                      ),
                      SizedBox(height: 20),
                      //todo: Libellé TextField
                      MyTextField(
                        textEditingController: this.textEditingController,
                        placeholder: 'Libellé du régime',
                        textColor: Color.fromRGBO(60, 141, 188, 1),
                        placeholderColor: Color.fromRGBO(60, 141, 188, 1),
                        fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                        borderRadius: Radius.circular(10),
                        focusBorderColor: Colors.transparent,
                        enableBorderColor: Colors.transparent,
                        errorText: (this.isNewBankEmpty)
                            ? 'Saisissez un régime avant de valider.'
                            : null,
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
                          if (this.textEditingController.text.isNotEmpty) {
                            setState(() {
                              this.isNewBankEmpty = false;
                            });
                            Navigator.pop(context); // dismiss alertdialog
                            this
                                .textEditingController
                                .clear(); // erase textfield content
                            functions.successSnackbar(
                              context: context,
                              message: 'Nouveau régime ajouté !',
                            );
                          } else {
                            print('Champ nouvelle banque vide !');
                            functions.errorSnackbar(
                              context: context,
                              message: 'Saisissez un régime avant de valider.',
                            );
                            setState(() {
                              this.isNewBankEmpty = true;
                            });
                            //todo: Start timer
                            Timer(
                              Duration(seconds: 5),
                              () {
                                setState(() {
                                  this.isNewBankEmpty = false;
                                });
                              },
                            );
                          }
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
          RegimeScreen(panelController: panelController),
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
