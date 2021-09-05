import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Categorie.dart';
import 'package:smartsfv/models/SousCategorie.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/views/screens/sous-categorie/SousCategorieScreen.dart';
import 'package:smartsfv/functions.dart' as functions;

class SousCategorieView extends StatefulWidget {
  SousCategorieView({Key? key}) : super(key: key);
  @override
  SousCategorieViewState createState() => SousCategorieViewState();
}

class SousCategorieViewState extends State<SousCategorieView> {
  //todo: Method called when the view is launching
  @override
  void initState() {
    super.initState();
    // ? Launching configs
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "SousCategorieView";
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
  bool isNewBankEmpty = false;
  String dropDownValue = 'Sélectionner une catégorie';
  List<String> depotlist = [
    'Sélectionner une catégorie',
    'Two',
    'Free',
    'Four',
  ];
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
            'depot': '',
          };
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          functions.showFormDialog(
            scaffold.currentContext,
            formKey,
            headerIcon: 'assets/img/icons/sub-category.png',
            title: 'Ajouter une nouvelle sous catégorie',
            successMessage: 'Nouvelle sous catégorie ajouté !',
            padding: EdgeInsets.all(20),
            onValidate: () async {
              if (formKey.currentState!.validate()) {
                // ? sending datas to API
                Api api = Api();
                final Map<String, dynamic> postSousCategorieResponse =
                    await api.postSousCategorie(
                  context: scaffold.currentContext,
                  // ? Create SousCategorie instance from Json and pass it to the fucnction
                  sousCategorie: SousCategorie.fromJson({
                    'libelle_sous_categorie': fieldControllers['libelle']
                        .text, // get libelle  // ! required
                  }),
                );
                // ? check the server response
                if (postSousCategorieResponse['msg'] ==
                    'Enregistrement effectué avec succès.') {
                  Navigator.of(context).pop();
                  functions.successSnackbar(
                    context: scaffold.currentContext,
                    message: 'Nouvelle sous catégorie ajoutée !',
                  );
                } else {
                  functions.errorSnackbar(
                    context: scaffold.currentContext,
                    message: 'Un problème est survenu',
                  );
                }
                // ? Refresh sous catégorie list
                setState(() {});
              }
            },
            formElements: [
              //todo: TextFormField
              MyTextFormField(
                keyboardType: TextInputType.text,
                textEditingController: fieldControllers['libelle'],
                validator: (value) {
                  return value!.isNotEmpty
                      ? null
                      : 'Saisissez un nom de sous catégorie';
                },
                placeholder: 'Libellé de la sous catégorie',
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
              SizedBox(height: 10),
              //todo: Catégorie DropDownButton
              (ScreenController.actualView != "LoginView")
                  ? FutureBuilder<List<Categorie>>(
                      future: api.getCategories(context),
                      builder: (sousCategorieComboBoxContext, snapshot) {
                        if (snapshot.hasData) {
                          // ? get nations datas from server
                          return MyComboBox(
                            validator: (value) {
                              return value! != 'Sélectionnez une catégorie'
                                  ? null
                                  : 'Choisissez une catégorie';
                            },
                            onChanged: (value) {
                              // ? Iterate all catégories to get the selected catégorie id
                              for (var categorie in snapshot.data!) {
                                if (categorie.libelle == value) {
                                  fieldControllers['categorie'] = categorie
                                      .id; // save the new catégorie selected
                                  print(
                                      "Nouveau catégorie: $value, ${fieldControllers['categorie']}, ${categorie.id}");
                                  break;
                                }
                              }
                            },
                            initialDropDownValue: 'Sélectionnez une catégorie',
                            initialDropDownList: [
                              'Sélectionnez une catégorie',
                              // ? datas integration
                              for (var categorie in snapshot.data!)
                                categorie.libelle,
                            ],
                            prefixPadding: 10,
                            prefixIcon: Image.asset(
                              'assets/img/icons/category.png',
                              fit: BoxFit.contain,
                              width: 15,
                              height: 15,
                              color: Color.fromRGBO(60, 141, 188, 1),
                            ),
                            textColor: Color.fromRGBO(60, 141, 188, 1),
                            fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                            borderRadius: Radius.circular(10),
                            focusBorderColor: Colors.transparent,
                            enableBorderColor: Colors.transparent,
                          );
                        }
                        // ? on wait the combo with data load empty combo
                        return MyTextFormField(
                          prefixPadding: 10,
                          prefixIcon: Image.asset(
                            'assets/img/icons/category.png',
                            fit: BoxFit.contain,
                            width: 15,
                            height: 15,
                            color: Color.fromRGBO(60, 141, 188, 1),
                          ),
                          placeholder: 'Sélectionnez une catégorie',
                          textColor: Color.fromRGBO(60, 141, 188, 1),
                          placeholderColor: Color.fromRGBO(60, 141, 188, 1),
                          fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                          borderRadius: Radius.circular(10),
                          focusBorderColor: Colors.transparent,
                          enableBorderColor: Colors.transparent,
                        );
                      },
                    )
                  : Container(),
            ],
          );
        },
        backgroundColor: Color.fromRGBO(60, 141, 188, 1),
        child: Tooltip(
          message: 'Ajouter une sous catégorie',
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
          SousCategorieScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            panelController: panelController,
          ),
        ],
      ),
    );
  }
}
