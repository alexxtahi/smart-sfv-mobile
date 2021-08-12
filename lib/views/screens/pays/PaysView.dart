import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Pays.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/screens/pays/PaysScreen.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/functions.dart' as functions;

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
    // Return building scaffold
    return Scaffold(
      key: scaffold,
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        elevation: 5,
        hoverElevation: 10,
        onPressed: () {
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          functions.showFormDialog(
            context,
            formKey,
            headerIcon: 'assets/img/icons/countries.png',
            title: 'Ajouter un pays',
            onValidate: () async {
              if (formKey.currentState!.validate()) {
                // ? sending datas to API
                Api api = Api();
                final Map<String, dynamic> postPaysResponse =
                    await api.postPays(
                  context: context,
                  // ? Create Pays instance from Json and pass it to the fucnction
                  pays: Pays.fromJson({
                    'libelle_nation': paysController.text,
                  }),
                );
                // ? check the server response
                if (postPaysResponse['msg'] ==
                    'Enregistrement effectué avec succès.') {
                  Navigator.of(context).pop();
                  functions.successSnackbar(
                    context: context,
                    message: 'Nouveau pays ajoutée !',
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
                    textEditingController: paysController,
                    validator: (value) {
                      return value!.isNotEmpty
                          ? null
                          : "Saisissez le libellé de la pays";
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
          message: 'Ajouter un pays',
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
