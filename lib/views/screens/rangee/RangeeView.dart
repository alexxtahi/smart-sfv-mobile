import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Rangee.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/views/screens/rangee/RangeeScreen.dart';

class RangeeView extends StatefulWidget {
  RangeeView({Key? key}) : super(key: key);
  @override
  RangeeViewState createState() => RangeeViewState();
}

class RangeeViewState extends State<RangeeView> {
  //todo: Method called when the view is launching
  @override
  void initState() {
    super.initState();
    // ? Launching configs
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "RangeeView";
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
            title: 'Ajouter une nouvelle rangée',
            successMessage: 'Nouvelle rangée ajouté !',
            padding: EdgeInsets.all(20),
            onValidate: () async {
              if (formKey.currentState!.validate()) {
                // ? sending datas to API
                Api api = Api();
                final Map<String, dynamic> postRangeeResponse =
                    await api.postRangee(
                  context: scaffold.currentContext,
                  // ? Create Rangee instance from Json and pass it to the fucnction
                  rangee: Rangee.fromJson({
                    'libelle_rangee': fieldControllers['libelle']
                        .text, // get libelle  // ! required
                  }),
                );
                // ? check the server response
                if (postRangeeResponse['msg'] ==
                    'Enregistrement effectué avec succès.') {
                  Navigator.of(context).pop();
                  functions.successSnackbar(
                    context: scaffold.currentContext,
                    message: 'Nouveau rangee ajouté !',
                  );
                } else {
                  functions.errorSnackbar(
                    context: scaffold.currentContext,
                    message: 'Un problème est survenu',
                  );
                }
                // ? Refresh rangee list
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
                      : 'Saisissez un nom de rangee';
                },
                placeholder: 'Libellé du rangee',
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
                  ? FutureBuilder<List<Rangee>>(
                      future: this.fetchRangees(),
                      builder: (rangeeComboBoxContext, snapshot) {
                        if (snapshot.hasData) {
                          // ? get nations datas from server
                          return MyComboBox(
                            validator: (value) {
                              return value! != 'Sélectionnez un rangee'
                                  ? null
                                  : 'Choisissez un rangee';
                            },
                            onChanged: (value) {
                              // ? Iterate all rangees to get the selected rangee id
                              for (var rangee in snapshot.data!) {
                                if (rangee.libelle == value) {
                                  fieldControllers['depot'] =
                                      rangee.id; // save the new rangee selected
                                  print(
                                      "Nouveau rangee: $value, ${fieldControllers['depot']}, ${rangee.id}");
                                  break;
                                }
                              }
                            },
                            initialDropDownValue: 'Sélectionnez un rangee',
                            initialDropDownList: [
                              'Sélectionnez un rangee',
                              // ? datas integration
                              for (var rangee in snapshot.data!) rangee.libelle,
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
                          placeholder: 'Sélectionnez un rangee',
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
          RangeeScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            panelController: panelController,
          ),
        ],
      ),
    );
  }

  Future<List<Rangee>> fetchRangees() async {
    // init API instance
    Api api = Api();
    // call API method getRangees
    Future<List<Rangee>> rangees = api.getRangees(context);
    // return results
    return rangees;
  }
}
