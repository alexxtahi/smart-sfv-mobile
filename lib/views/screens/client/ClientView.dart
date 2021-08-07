import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
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
        elevation: 5,
        hoverElevation: 10,
        onPressed: () {
          // TextFormField controllers
          List<TextEditingController> fieldControllers = [
            for (var i = 1; i <= 8; i++) TextEditingController(),
          ];
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          functions.showFormDialog(
            context,
            formKey,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            headerIcon: 'assets/img/icons/customer.png',
            title: 'Ajouter un nouveau client',
            onValidate: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop();
                functions.successSnackbar(
                  context: context,
                  message: 'Nouveau client ajouté !',
                );
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
                    textEditingController: fieldControllers[0],
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
                    textEditingController: fieldControllers[1],
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
                    textEditingController: fieldControllers[2],
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
                  MyComboBox(
                    validator: (value) {
                      return value! != 'Sélectionnez un pays'
                          ? null
                          : 'Choisissez un pays';
                    },
                    initialDropDownValue: 'Sélectionnez un pays',
                    initialDropDownList: [
                      'Sélectionnez un pays',
                      for (var i = 1; i <= 10; i++) 'Pays $i',
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
                  ),
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
                    textEditingController: fieldControllers[3],
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
                    text: 'Adresse postale',
                    color: Color.fromRGBO(0, 27, 121, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Postal address TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers[4],
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
                        text: 'Regime',
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
                  MyComboBox(
                    validator: (value) {
                      return value! != 'Sélectionnez le régime'
                          ? null
                          : 'Choisissez un régime';
                    },
                    initialDropDownValue: 'Sélectionnez le régime',
                    initialDropDownList: [
                      'Sélectionnez le régime',
                      for (var i = 1; i <= 10; i++) 'Régime $i',
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
                  ),
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
                    textEditingController: fieldControllers[5],
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
                    textEditingController: fieldControllers[6],
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
                    textEditingController: fieldControllers[7],
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
          //todo: Drawer Screen
          DrawerLayout(),
          //todo: Home Screen
          ClientScreen(panelController: panelController),
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
