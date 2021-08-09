import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/models/Banque.dart';
import 'package:smartsfv/models/Fournisseur.dart';
import 'package:smartsfv/models/Pays.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/views/screens/fournisseur/ProviderScreen.dart';
import 'package:smartsfv/functions.dart' as functions;

class ProviderView extends StatefulWidget {
  ProviderView({Key? key}) : super(key: key);
  @override
  ProviderViewState createState() => ProviderViewState();
}

class ProviderViewState extends State<ProviderView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
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
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        backgroundColor: Color.fromRGBO(221, 75, 57, 1),
        child: Tooltip(
          message: 'Ajouter un fournisseur',
          decoration: BoxDecoration(
            color: Color.fromRGBO(221, 75, 57, 1),
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
            'assets/img/icons/provider.png',
            color: Colors.white,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
        elevation: 5,
        hoverElevation: 10,
        onPressed: () {
          // TextFormField controllers
          Map<String, dynamic> fieldControllers = {
            'name': TextEditingController(),
            'contact': TextEditingController(),
            'pays': '',
            'email': TextEditingController(),
            'geoAdr': TextEditingController(),
            'postalAdr': TextEditingController(),
            'banque': '',
            'compteBanque': TextEditingController(),
            'compteContrib': TextEditingController(),
            'fax': TextEditingController(),
          };
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          functions.showFormDialog(
            context,
            formKey,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            headerIcon: 'assets/img/icons/provider.png',
            headerIconColor: Color.fromRGBO(221, 75, 57, 1),
            title: 'Ajouter un nouveau fournisseur',
            onValidate: () async {
              if (formKey.currentState!.validate()) {
                // ? sending datas to API
                Api api = Api();
                final Map<String, dynamic> postClientResponse =
                    await api.postFournisseur(
                  context: context,
                  // ? Create Fournisseur instance from Json and pass it to the fucnction
                  fournisseur: Fournisseur.fromJson({
                    'id': 0,
                    'full_name_fournisseur': fieldControllers['name']
                        .text, // get name  // ! required
                    'contact_fournisseur': fieldControllers['contact']
                        .text, // get contact // ! required
                    'nation': {
                      'libelle_nation': fieldControllers['pays'].toString()
                    }, // get pays // ! required
                    'banque': {
                      'libelle_banque': fieldControllers['banque'].toString()
                    }, // get banque
                    'email_fournisseur': fieldControllers['email'].text,
                    'adresse_fournisseur': fieldControllers['geoAdr'].text,
                    'boite_postale_fournisseur':
                        fieldControllers['postalAdr'].text,
                    'compteBanque': fieldControllers['compteBanque'].text,
                    'fax_fournisseur': fieldControllers['fax'].text,
                    'compte_contribuable_fournisseur':
                        fieldControllers['compteContrib'].text,
                  }),
                );
                // ? check the server response
                if (postClientResponse['msg'] ==
                    'Enregistrement effectué avec succès.') {
                  Navigator.of(context).pop();
                  functions.successSnackbar(
                    context: context,
                    message: 'Nouveau fournisseur ajouté !',
                  );
                } else {
                  functions.errorSnackbar(
                    context: context,
                    message: 'Un problème est survenu',
                  );
                }
                // ? Refresh provider list
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
                        text: 'Nom complet ou raison sociale',
                        color: Color.fromRGBO(221, 75, 57, 1),
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
                          : 'Saisissez le nom du fournisseur';
                    },
                    prefixPadding: 10,
                    prefixIcon: Image.asset(
                      'assets/img/icons/provider.png',
                      fit: BoxFit.contain,
                      width: 15,
                      height: 15,
                      color: Color.fromRGBO(221, 75, 57, 1),
                    ),
                    placeholder:
                        'Nom & prénom(s) ou raison sociale du fournisseur',
                    textColor: Color.fromRGBO(221, 75, 57, 1),
                    placeholderColor: Color.fromRGBO(221, 75, 57, 1),
                    fillColor: Color.fromRGBO(221, 75, 57, 0.15),
                    errorColor: Colors.yellow.shade800,
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
                        color: Color.fromRGBO(221, 75, 57, 1),
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
                          : 'Saisissez le contact du fournisseur';
                    },
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.phone_android_rounded,
                      color: Color.fromRGBO(221, 75, 57, 1),
                    ),
                    placeholder: 'Contact du fournisseur',
                    textColor: Color.fromRGBO(221, 75, 57, 1),
                    placeholderColor: Color.fromRGBO(221, 75, 57, 1),
                    fillColor: Color.fromRGBO(221, 75, 57, 0.15),
                    errorColor: Colors.yellow.shade800,
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
                    color: Color.fromRGBO(221, 75, 57, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Email TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['email'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.mail_outline_rounded,
                      color: Color.fromRGBO(221, 75, 57, 1),
                    ),
                    placeholder: 'Adresse mail du fournisseur',
                    textColor: Color.fromRGBO(221, 75, 57, 1),
                    placeholderColor: Color.fromRGBO(221, 75, 57, 1),
                    fillColor: Color.fromRGBO(221, 75, 57, 0.15),
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
                        color: Color.fromRGBO(221, 75, 57, 1),
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
                  FutureBuilder<List<Pays>>(
                      future: this.fetchCountries(),
                      builder: (context, snapshot) {
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
                                  fieldControllers['pays'] =
                                      pays.id; // save the new countrie selected
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
                              color: Color.fromRGBO(221, 75, 57, 1),
                            ),
                            textColor: Color.fromRGBO(221, 75, 57, 1),
                            fillColor: Color.fromRGBO(221, 75, 57, 0.15),
                            errorColor: Colors.yellow.shade800,
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
                            color: Color.fromRGBO(221, 75, 57, 1),
                          ),
                          placeholder: 'Sélectionnez un pays',
                          textColor: Color.fromRGBO(221, 75, 57, 1),
                          placeholderColor: Color.fromRGBO(221, 75, 57, 1),
                          fillColor: Color.fromRGBO(221, 75, 57, 0.15),
                          errorColor: Colors.yellow.shade800,
                          borderRadius: Radius.circular(10),
                          focusBorderColor: Colors.transparent,
                          enableBorderColor: Colors.transparent,
                        );
                      }),
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
                    color: Color.fromRGBO(221, 75, 57, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Geographical address TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['geoAdr'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.location_city_rounded,
                      color: Color.fromRGBO(221, 75, 57, 1),
                    ),
                    placeholder: 'Adresse géographique du fournisseur',
                    textColor: Color.fromRGBO(221, 75, 57, 1),
                    placeholderColor: Color.fromRGBO(221, 75, 57, 1),
                    fillColor: Color.fromRGBO(221, 75, 57, 0.15),
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
                    text: 'Adresse postale',
                    color: Color.fromRGBO(221, 75, 57, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Postal address TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['postalAdr'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.location_history_rounded,
                      color: Color.fromRGBO(221, 75, 57, 1),
                    ),
                    placeholder: 'Adresse de la boite postale du fournisseur',
                    textColor: Color.fromRGBO(221, 75, 57, 1),
                    placeholderColor: Color.fromRGBO(221, 75, 57, 1),
                    fillColor: Color.fromRGBO(221, 75, 57, 0.15),
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
                  MyText(
                    text: 'Banque',
                    color: Color.fromRGBO(221, 75, 57, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Banque DropDown
                  FutureBuilder<List<Banque>>(
                    future: this.fetchBanques(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // ? get nations datas from server
                        return MyComboBox(
                          onChanged: (value) {
                            // ? Iterate all bank to get the selected banque id
                            for (var banque in snapshot.data!) {
                              if (banque.libelle == value) {
                                // if the regime name match with the selected
                                fieldControllers['banque'] =
                                    banque.id; // save the new banque selected
                                print(
                                    "Nouvelle banque: $value, ${fieldControllers['banque']}, ${banque.id}");

                                break;
                              }
                            }
                          },
                          initialDropDownValue: 'Sélectionnez une banque',
                          initialDropDownList: [
                            'Sélectionnez une banque',
                            // ? datas integration
                            for (var regime in snapshot.data!) regime.libelle,
                          ],
                          prefixPadding: 10,
                          prefixIcon: Image.asset(
                            'assets/img/icons/bank-building.png',
                            fit: BoxFit.contain,
                            width: 15,
                            height: 15,
                            color: Color.fromRGBO(221, 75, 57, 1),
                          ),
                          textColor: Color.fromRGBO(221, 75, 57, 1),
                          fillColor: Color.fromRGBO(221, 75, 57, 0.15),
                          borderRadius: Radius.circular(10),
                          focusBorderColor: Colors.transparent,
                          enableBorderColor: Colors.transparent,
                        );
                      }
                      // ? on wait the combo with data load empty combo
                      return MyTextFormField(
                        prefixPadding: 10,
                        prefixIcon: Image.asset(
                          'assets/img/icons/bank-building.png',
                          fit: BoxFit.contain,
                          width: 15,
                          height: 15,
                          color: Color.fromRGBO(221, 75, 57, 1),
                        ),
                        placeholder: 'Sélectionnez une banque',
                        textColor: Color.fromRGBO(221, 75, 57, 1),
                        placeholderColor: Color.fromRGBO(221, 75, 57, 1),
                        fillColor: Color.fromRGBO(221, 75, 57, 0.15),
                        borderRadius: Radius.circular(10),
                        focusBorderColor: Colors.transparent,
                        enableBorderColor: Colors.transparent,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Compte banque Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Compte banque label
                  MyText(
                    text: 'Compte banque',
                    color: Color.fromRGBO(221, 75, 57, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Compte banque TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['compteBanque'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.sort_rounded,
                      color: Color.fromRGBO(221, 75, 57, 1),
                    ),
                    placeholder: 'Compte banque du fournisseur',
                    textColor: Color.fromRGBO(221, 75, 57, 1),
                    placeholderColor: Color.fromRGBO(221, 75, 57, 1),
                    fillColor: Color.fromRGBO(221, 75, 57, 0.15),
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
                    color: Color.fromRGBO(221, 75, 57, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: N° Fax TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['fax'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.phone_rounded,
                      color: Color.fromRGBO(221, 75, 57, 1),
                    ),
                    placeholder: 'Numéro fax du fournisseur',
                    textColor: Color.fromRGBO(221, 75, 57, 1),
                    placeholderColor: Color.fromRGBO(221, 75, 57, 1),
                    fillColor: Color.fromRGBO(221, 75, 57, 0.15),
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
                    color: Color.fromRGBO(221, 75, 57, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: N° Compte contribuable TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['compteContrib'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.file_copy_rounded,
                      color: Color.fromRGBO(221, 75, 57, 1),
                    ),
                    placeholder: 'Numéro du compte contribuable du fournisseur',
                    textColor: Color.fromRGBO(221, 75, 57, 1),
                    placeholderColor: Color.fromRGBO(221, 75, 57, 1),
                    fillColor: Color.fromRGBO(221, 75, 57, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                  ),
                ],
              ),
            ],
          );
        },
      ),
      body: Stack(
        children: [
          //todo: Drawer Screen
          DrawerLayout(panelController: panelController),
          //todo: Home Screen
          ProviderScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            username: 'Alexandre TAHI',
            panelController: panelController,
          ),
        ],
      ),
    );
  }

  Future<List<Pays>> fetchCountries() async {
    // init API instance
    Api api = Api();
    // call API method getPays
    Future<List<Pays>> countries = api.getPays(context);
    // return results
    return countries;
  }

  Future<List<Banque>> fetchBanques() async {
    // init API instance
    Api api = Api();
    // call API method getBanques
    Future<List<Banque>> banques = api.getBanques(context);
    // return results
    return banques;
  }
}
