import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextField.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
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
  TextEditingController regimeController = TextEditingController();
  bool isNewBankEmpty = false;
  @override
  Widget build(BuildContext context) {
    ScreenController.actualView = "RegimeView";
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
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          functions.showFormDialog(
            context,
            formKey,
            headerIcon: 'assets/img/icons/regim.png',
            title: 'Ajouter un régime',
            onValidate: () async {
              if (formKey.currentState!.validate()) {
                // ? get fields datas
                String libelle =
                    regimeController.text; // get name  // ! required
                // ? sending datas to API
                Api api = Api();
                final Map<String, dynamic> postRegimeResponse =
                    await api.postRegime(
                  context,
                  libelle,
                );
                // ? check the server response
                if (postRegimeResponse['msg'] ==
                    'Enregistrement effectué avec succès.') {
                  Navigator.of(context).pop();
                  functions.successSnackbar(
                    context: context,
                    message: 'Nouveau régime ajoutée !',
                  );
                } else {
                  functions.errorSnackbar(
                    context: context,
                    message: 'Un problème est survenu',
                  );
                }
                // ? Refresh bank list
                setState(() {});
              }
            },
            formElements: [
              //todo: Libelle Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Libelle label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: 'Libellé',
                        color: Color.fromRGBO(0, 27, 121, 1),
                        fontWeight: FontWeight.bold,
                      ),
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Color.fromRGBO(221, 75, 57, 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //todo: Libelle TextFormField
                  MyTextFormField(
                    textEditingController: regimeController,
                    validator: (value) {
                      return value!.isNotEmpty
                          ? null
                          : "Saisissez le libellé du régime";
                    },
                    prefixPadding: 10,
                    prefixIcon: Image.asset(
                      'assets/img/icons/regim.png',
                      fit: BoxFit.contain,
                      width: 15,
                      height: 15,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                    placeholder: 'Libellé du régime',
                    textColor: Color.fromRGBO(60, 141, 188, 1),
                    placeholderColor: Color.fromRGBO(60, 141, 188, 1),
                    fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
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
          DrawerLayout(panelController: panelController),
          //todo: Home Screen
          RegimeScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            panelController: panelController,
          ),
        ],
      ),
    );
  }
}
