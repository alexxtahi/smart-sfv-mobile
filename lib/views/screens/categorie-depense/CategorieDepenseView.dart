import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/CategorieDepense.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/views/screens/categorie-depense/CategorieDepenseScreen.dart';

class CategorieDepenseView extends StatefulWidget {
  CategorieDepenseView({Key? key}) : super(key: key);
  @override
  CategorieDepenseViewState createState() => CategorieDepenseViewState();
}

class CategorieDepenseViewState extends State<CategorieDepenseView> {
  //todo: Method called when the view is launching
  @override
  void initState() {
    super.initState();
    // ? Launching configs
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "CategorieDepenseView";
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
  String dropDownValue = 'Sélectionner un dépôt';
  List<String> depotlist = ['Sélectionner un dépôt', 'Two', 'Free', 'Four'];
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
            headerIcon: 'assets/img/icons/above.png',
            title: 'Ajouter une nouvelle categorieDepense',
            successMessage: 'Nouvelle categorieDepense ajouté !',
            padding: EdgeInsets.all(20),
            onValidate: () async {
              if (formKey.currentState!.validate()) {
                // ? sending datas to API
                Api api = Api();
                final Map<String, dynamic> postCategorieDepenseResponse =
                    await api.postCategorieDepense(
                  context: scaffold.currentContext,
                  // ? Create CategorieDepense instance from Json and pass it to the fucnction
                  categorieDepense: CategorieDepense.fromJson({
                    'libelle_categorieDepense': fieldControllers['libelle']
                        .text, // get libelle  // ! required
                  }),
                );
                // ? check the server response
                if (postCategorieDepenseResponse['msg'] ==
                    'Enregistrement effectué avec succès.') {
                  Navigator.of(context).pop();
                  functions.successSnackbar(
                    context: scaffold.currentContext,
                    message: 'Nouveau categorieDepense ajouté !',
                  );
                } else {
                  functions.errorSnackbar(
                    context: scaffold.currentContext,
                    message: 'Un problème est survenu',
                  );
                }
                // ? Refresh categorieDepense list
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
                      : 'Saisissez un nom de categorieDepense';
                },
                placeholder: 'Libellé du categorieDepense',
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
              //todo: Dépot DropDownButton
              (ScreenController.actualView != "LoginView")
                  ? FutureBuilder<List<CategorieDepense>>(
                      future: this.fetchCategorieDepenses(),
                      builder: (categorieDepenseComboBoxContext, snapshot) {
                        if (snapshot.hasData) {
                          // ? get nations datas from server
                          return MyComboBox(
                            validator: (value) {
                              return value! !=
                                      'Sélectionnez un categorieDepense'
                                  ? null
                                  : 'Choisissez un categorieDepense';
                            },
                            onChanged: (value) {
                              // ? Iterate all categorieDepenses to get the selected categorieDepense id
                              for (var categorieDepense in snapshot.data!) {
                                if (categorieDepense.libelle == value) {
                                  fieldControllers['depot'] = categorieDepense
                                      .id; // save the new categorieDepense selected
                                  print(
                                      "Nouveau categorieDepense: $value, ${fieldControllers['depot']}, ${categorieDepense.id}");
                                  break;
                                }
                              }
                            },
                            initialDropDownValue:
                                'Sélectionnez un categorieDepense',
                            initialDropDownList: [
                              'Sélectionnez un categorieDepense',
                              // ? datas integration
                              for (var categorieDepense in snapshot.data!)
                                categorieDepense.libelle,
                            ],
                            prefixPadding: 10,
                            prefixIcon: Image.asset(
                              'assets/img/icons/above.png',
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
                            'assets/img/icons/cashier.png',
                            fit: BoxFit.contain,
                            width: 15,
                            height: 15,
                            color: Color.fromRGBO(60, 141, 188, 1),
                          ),
                          placeholder: 'Sélectionnez un categorieDepense',
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
          CategorieDepenseScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            panelController: panelController,
          ),
        ],
      ),
    );
  }

  Future<List<CategorieDepense>> fetchCategorieDepenses() async {
    // init API instance
    Api api = Api();
    // call API method getCategorieDepenses
    Future<List<CategorieDepense>> categorieDepenses =
        api.getCategorieDepenses(context);
    // return results
    return categorieDepenses;
  }
}
