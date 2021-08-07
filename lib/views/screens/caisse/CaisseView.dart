import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/views/screens/caisse/CaisseScreen.dart';
import 'package:smartsfv/functions.dart' as functions;

class CaisseView extends StatefulWidget {
  CaisseView({Key? key}) : super(key: key);
  @override
  CaisseViewState createState() => CaisseViewState();
}

class CaisseViewState extends State<CaisseView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  TextEditingController textEditingController = TextEditingController();
  bool isNewBankEmpty = false;
  String dropDownValue = 'Sélectionner un dépôt';
  List<String> depotlist = ['Sélectionner un dépôt', 'Two', 'Free', 'Four'];
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
        elevation: 5,
        hoverElevation: 10,
        onPressed: () async {
          final TextEditingController libEditingController =
              TextEditingController();
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          await functions.showFormDialog(
            context,
            formKey,
            headerIcon: 'assets/img/icons/cashier.png',
            title: 'Ajouter une nouvelle caisse',
            successMessage: 'Nouvelle caisse ajouté !',
            padding: EdgeInsets.all(20),
            formElements: [
              //todo: TextFormField
              MyTextFormField(
                textEditingController: libEditingController,
                validator: (value) {
                  return value!.isNotEmpty
                      ? null
                      : 'Saisissez un nom de caisse';
                },
                placeholder: 'Libellé de la caisse',
                textColor: Color.fromRGBO(60, 141, 188, 1),
                placeholderColor: Color.fromRGBO(60, 141, 188, 1),
                fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                borderRadius: Radius.circular(10),
                focusBorderColor: Colors.transparent,
                enableBorderColor: Colors.transparent,
              ),
              SizedBox(height: 10),
              //todo: Dépot DropDownButton
              MyComboBox(
                initialDropDownValue: 'Sélectionnez un dépôt',
                initialDropDownList: [
                  'Sélectionnez un dépôt',
                  for (var i = 1; i <= 10; i++) 'Dépôt $i',
                ],
              ),
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
          DrawerLayout(),
          //todo: Home Screen
          CaisseScreen(panelController: panelController),
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
