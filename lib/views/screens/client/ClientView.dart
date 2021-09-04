import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/models/Pays.dart';
import 'package:smartsfv/models/Regime.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/screens/client/ClientScreen.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/functions.dart' as functions;

class ClientView extends StatefulWidget {
  ClientView({Key? key}) : super(key: key);
  @override
  ClientViewState createState() => ClientViewState();
}

class ClientViewState extends State<ClientView> {
  //todo: Method called when the view is launching
  @override
  void initState() {
    super.initState();
    // ? Launching configs
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "ClientView";
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

  //The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
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
    // Return building scaffold
    return Scaffold(
      key: scaffold,
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        hoverElevation: 10,
        onPressed: () {
          // TextFormField controllers
          Map<String, dynamic> fieldControllers = {
            'name': TextEditingController(),
            'contact': TextEditingController(),
            'email': TextEditingController(),
            'pays': '',
            'geoAdr': TextEditingController(),
            'postalAdr': TextEditingController(),
            'regimes': '',
            'montantPlafond': TextEditingController(),
            'fax': TextEditingController(),
            'compteContrib': TextEditingController(),
          };
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          functions.showFormDialog(
            scaffold.currentContext,
            formKey,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            headerIcon: 'assets/img/icons/customer.png',
            title: 'Ajouter un nouveau client',
            onValidate: () async {
              if (formKey.currentState!.validate()) {
                // ? get fields datas
                Map<String, dynamic> clientDatas = {
                  'full_name_client':
                      fieldControllers['name'].text, // get name  // ! required
                  'contact_client': fieldControllers['contact']
                      .text, // get contact // ! required
                  'email_client': (fieldControllers['email'].text != null)
                      ? fieldControllers['email'].text
                      : '', // get email
                  'nation_id': fieldControllers['pays']
                      .toString(), // get pays // ! required
                  'adresse_client': (fieldControllers['geoAdr'].text != null)
                      ? fieldControllers['geoAdr'].text
                      : '', // get geoAdr
                  'boite_postale_client':
                      (fieldControllers['postalAdr'].text != null)
                          ? fieldControllers['postalAdr'].text
                          : '', // get postalAdr
                  'regime_id': fieldControllers['regime']
                      .toString(), // get regime // ! required
                  'plafond_client':
                      (fieldControllers['montantPlafond'].text != null)
                          ? fieldControllers['montantPlafond'].text
                          : '', // get montant plafond
                  'fax_client': (fieldControllers['fax'].text != null)
                      ? fieldControllers['fax'].text
                      : '', // get fax
                  'compte_contribuable_client':
                      (fieldControllers['compteContrib'].text != null)
                          ? fieldControllers['compteContrib'].text
                          : '', // get compte contribuable
                };
                // ? sending datas to API
                Api api = Api();
                final Map<String, dynamic> postClientResponse =
                    await api.postClient(
                  context: scaffold.currentContext,
                  client: Client.fromJson(clientDatas),
                );
                // ? check the server response
                if (postClientResponse['msg'] ==
                    'Enregistrement effectué avec succès.') {
                  Navigator.of(context).pop();
                  functions.successSnackbar(
                    context: scaffold.currentContext,
                    message: 'Nouveau client ajouté !',
                  );
                } else {
                  functions.errorSnackbar(
                    context: scaffold.currentContext,
                    message: 'Un problème est survenu',
                  );
                }
                // ? Refresh client list
                setState(() {});
              }
            },
            formElements: [
              //todo: Name Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Name label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: 'Nom & prénom(s)',
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
                  //todo: Name TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['name'],
                    validator: (value) {
                      return value!.isNotEmpty
                          ? null
                          : 'Saisissez le nom du client';
                    },
                    prefixPadding: 10,
                    prefixIcon: Image.asset(
                      'assets/img/icons/account.png',
                      fit: BoxFit.contain,
                      width: 15,
                      height: 15,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                    placeholder: 'Nom & prénom(s)',
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
              //todo: Contact Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Contact label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: 'Contact',
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
                  //todo: Contact TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['contact'],
                    validator: (value) {
                      return value!.isNotEmpty
                          ? null
                          : 'Saisissez le contact du client';
                    },
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.phone_android_rounded,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                    placeholder: 'Contact du client',
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
              //todo: Email Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Email label
                  MyText(
                    text: 'Email',
                    color: Color.fromRGBO(0, 27, 121, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Email TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['email'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.mail_outline_rounded,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                    placeholder: 'Adresse mail du client',
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
              //todo: Pays Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Pays label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: 'Pays',
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
                  //todo: Pays DropDown
                  (ScreenController.actualView != "LoginView")
                      ? FutureBuilder<List<Pays>>(
                          future: api.getPays(context),
                          builder: (paysComboBoxContext, snapshot) {
                            if (snapshot.hasData) {
                              // ? get nations datas from server
                              return MyComboBox(
                                validator: (value) {
                                  return value! != 'Sélectionnez un pays'
                                      ? null
                                      : 'Choisissez un pays';
                                },
                                onChanged: (value) {
                                  // ? Iterate all countries to get the selected countrie id
                                  for (var pays in snapshot.data!) {
                                    if (pays.libelle == value) {
                                      fieldControllers['pays'] = pays
                                          .id; // save the new countrie selected
                                      print(
                                          "Nouveau pays: $value, ${fieldControllers['pays']}, ${pays.id}");
                                      break;
                                    }
                                  }
                                },
                                initialDropDownValue: 'Sélectionnez un pays',
                                initialDropDownList: [
                                  'Sélectionnez un pays',
                                  // ? datas integration
                                  for (var pays in snapshot.data!) pays.libelle,
                                ],
                                prefixPadding: 10,
                                prefixIcon: Image.asset(
                                  'assets/img/icons/countries.png',
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
                                'assets/img/icons/countries.png',
                                fit: BoxFit.contain,
                                width: 15,
                                height: 15,
                                color: Color.fromRGBO(60, 141, 188, 1),
                              ),
                              placeholder: 'Sélectionnez un pays',
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
              ),
              SizedBox(height: 10),
              //todo: Geographical address Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Geographical address label
                  MyText(
                    text: 'Adresse géographique',
                    color: Color.fromRGBO(0, 27, 121, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Geographical address TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['geoAdr'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.location_city_rounded,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                    placeholder: 'Adresse géographique du client',
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
              //todo: Postal address Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Postal address label
                  MyText(
                    text: 'Boite postale',
                    color: Color.fromRGBO(0, 27, 121, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Postal address TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['postalAdr'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.location_history_rounded,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                    placeholder: 'Adresse de la boite postale du client',
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
              //todo: Regime Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Regime label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: 'Régime',
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
                  //todo: Regime DropDown
                  (ScreenController.actualView != "LoginView")
                      ? FutureBuilder<List<Regime>>(
                          future: api.getRegimes(context),
                          builder: (regimeComboBoxContext, snapshot) {
                            if (snapshot.hasData) {
                              // ? get nations datas from server
                              return MyComboBox(
                                validator: (value) {
                                  return value! != 'Sélectionnez le régime'
                                      ? null
                                      : 'Choisissez un régime';
                                },
                                onChanged: (value) {
                                  // ? Iterate all countries to get the selected regime id
                                  for (var regime in snapshot.data!) {
                                    if (regime.libelle == value) {
                                      // if the regime name match with the selected
                                      fieldControllers['regime'] = regime
                                          .id; // save the new regime selected
                                      print(
                                          "Nouveau régime: $value, ${fieldControllers['regime']}, ${regime.id}");

                                      break;
                                    }
                                  }
                                },
                                initialDropDownValue: 'Sélectionnez le régime',
                                initialDropDownList: [
                                  'Sélectionnez le régime',
                                  // ? datas integration
                                  for (var regime in snapshot.data!)
                                    regime.libelle,
                                ],
                                prefixPadding: 10,
                                prefixIcon: Icon(
                                  Icons.circle_outlined,
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
                              prefixIcon: Icon(
                                Icons.circle_outlined,
                                color: Color.fromRGBO(60, 141, 188, 1),
                              ),
                              placeholder: 'Sélectionnez un régime',
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
              ),
              SizedBox(height: 10),
              //todo: Montant plafond Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Montant plafond label
                  MyText(
                    text: 'Montant plafond',
                    color: Color.fromRGBO(0, 27, 121, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Montant plafond TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['montantPlafond'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.attach_money_rounded,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                    placeholder: 'Montant plafond du client',
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
              //todo: N° Fax Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: N° Fax label
                  MyText(
                    text: 'N° Fax',
                    color: Color.fromRGBO(0, 27, 121, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: N° Fax TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['fax'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.phone_rounded,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                    placeholder: 'Numéro fax du client',
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
              //todo: N° Compte contribuable Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: N° Compte contribuable label
                  MyText(
                    text: 'N° Compte contribuable',
                    color: Color.fromRGBO(0, 27, 121, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: N° Compte contribuable TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['compteContrib'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.file_copy_rounded,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                    placeholder: 'Numéro du compte contribuable du client',
                    textColor: Color.fromRGBO(60, 141, 188, 1),
                    placeholderColor: Color.fromRGBO(60, 141, 188, 1),
                    fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                  ),
                ],
              ),
            ],
          );
        },
        //backgroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(60, 141, 188, 1),
        child: Tooltip(
          message: 'Ajouter un client',
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
          child: Image.asset(
            'assets/img/icons/follower.png',
            //color: Color.fromRGBO(60, 141, 188, 1),
            color: Colors.white,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Stack(
        children: [
          //todo: Home Screen
          ClientScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            panelController: panelController,
          ),
        ],
      ),
    );
  }
}
