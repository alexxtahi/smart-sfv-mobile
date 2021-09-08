import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Divers.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/views/screens/divers/DiversScreen.dart';

class DiversView extends StatefulWidget {
  DiversView({Key? key}) : super(key: key);
  @override
  DiversViewState createState() => DiversViewState();
}

class DiversViewState extends State<DiversView> {
  //todo: Method called when the view is launching
  @override
  void initState() {
    super.initState();
    // ? Launching configs
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "DiversView";
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
  GlobalKey scaffold = GlobalKey();
  // init API instance
  Api api = Api();

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
    return Scaffold(
      key: scaffold,
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        elevation: 5,
        hoverElevation: 10,
        onPressed: () async {
          // TextFormField controllers
          Map<String, dynamic> fieldControllers = {
            'libelle': TextEditingController(),
          };
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          functions.showFormDialog(
            scaffold.currentContext,
            formKey,
            headerIcon: 'assets/img/icons/more.png',
            title: 'Ajouter un nouveau divers',
            successMessage: 'Nouveau divers ajouté !',
            padding: EdgeInsets.all(20),
            onValidate: () async {
              if (formKey.currentState!.validate()) {
                // ? sending datas to API
                Api api = Api();
                final Map<String, dynamic> postDiversResponse =
                    await api.postDivers(
                  context: scaffold.currentContext,
                  // ? Create Divers instance from Json and pass it to the fucnction
                  divers: Divers.fromJson({
                    'libelle_divers': fieldControllers['libelle']
                        .text, // get libelle  // ! required
                  }),
                );
                // ? check the server response
                if (postDiversResponse['msg'] ==
                    'Enregistrement effectué avec succès.') {
                  // ? In Success case
                  Navigator.of(context).pop();
                  functions.showSuccessDialog(
                    context: scaffold.currentContext,
                    message: 'Nouveau ajoutée !',
                  );
                } else if (postDiversResponse['msg'] ==
                    'Cet enregistrement existe déjà dans la base') {
                  // ? In instance already exist case
                  Navigator.of(context).pop();
                  functions.showWarningDialog(
                    context: scaffold.currentContext,
                    message: 'Vous avez déjà enregistré ce divers !',
                  );
                } else {
                  // ? In Error case
                  Navigator.of(context).pop();
                  functions.showErrorDialog(
                    context: scaffold.currentContext,
                    message: "Une erreur s'est produite",
                  );
                }
                // ? Refresh divers list
                setState(() {});
              }
            },
            formElements: [
              //todo: TextFormField
              MyTextFormField(
                textEditingController: fieldControllers['libelle'],
                validator: (value) {
                  return value!.isNotEmpty
                      ? null
                      : 'Saisissez un nom de divers';
                },
                placeholder: 'Libellé du divers',
                prefixPadding: 10,
                prefixIcon: Icon(
                  Icons.sort_by_alpha,
                  color: Color.fromRGBO(60, 141, 188, 1),
                ),
                textColor: Color.fromRGBO(60, 141, 188, 1),
                placeholderColor: Color.fromRGBO(60, 141, 188, 1),
                fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                borderRadius: Radius.circular(10),
                focusBorderColor: Colors.transparent,
                enableBorderColor: Colors.transparent,
              ),
            ],
          );
        },
        backgroundColor: Color.fromRGBO(60, 141, 188, 1),
        child: Tooltip(
          message: 'Ajouter un divers',
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
          //todo: Home Screen
          DiversScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            panelController: panelController,
          ),
        ],
      ),
    );
  }
}
