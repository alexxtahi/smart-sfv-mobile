import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Banque.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
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
  //todo: Method called when the view is launching
  @override
  void initState() {
    super.initState();
    // ? Launching configs
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "BanqueView";
      ScreenController.isChildView = true;
    }
  }

  //todo: Method called when the view is closing
  @override
  void dispose() {
    // ? Set actualView to "HomeView"
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "HomeView";
      ScreenController.isChildView = false;
    }
    super.dispose();
  }

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  bool isNewBankEmpty = false;
  GlobalKey scaffold = GlobalKey();
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
    // Return building Scaffold
    return Scaffold(
      key: scaffold,
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        elevation: 5,
        hoverElevation: 10,
        onPressed: () {
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          functions.showFormDialog(
            scaffold.currentContext,
            formKey,
            headerIcon: 'assets/img/icons/bank-building.png',
            title: 'Ajouter une banque',
            onValidate: () async {
              if (formKey.currentState!.validate()) {
                // ? sending datas to API
                Api api = Api();
                final Map<String, dynamic> postBankResponse =
                    await api.postBank(
                  context: scaffold.currentContext,
                  // ? Create Banque instance from Json and pass it to the fucnction
                  banque: Banque.fromJson({
                    'libelle_banque': bankController.text,
                  }),
                );
                // ? check the server response
                if (postBankResponse['msg'] ==
                    'Enregistrement effectué avec succès.') {
                  Navigator.of(scaffold.currentContext!).pop();
                  functions.successSnackbar(
                    context: scaffold.currentContext,
                    message: 'Nouvelle banque ajoutée !',
                  );
                } else {
                  functions.errorSnackbar(
                    context: scaffold.currentContext,
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
                    textEditingController: bankController,
                    validator: (value) {
                      return value!.isNotEmpty
                          ? null
                          : "Saisissez le libellé de la banque";
                    },
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.sort_by_alpha,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                    placeholder: 'Libellé',
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
          DrawerLayout(panelController: panelController),
          //todo: Home Screen
          BanqueScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            panelController: panelController,
          ),
        ],
      ),
    );
  }
}
