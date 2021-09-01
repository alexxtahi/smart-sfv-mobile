import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Categorie.dart';
import 'package:smartsfv/models/Fournisseur.dart';
import 'package:smartsfv/models/SousCategorie.dart';
import 'package:smartsfv/models/Tva.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/layouts/DrawerLayout.dart';
import 'package:smartsfv/views/screens/article/ArticleScreen.dart';
import 'package:smartsfv/views/layouts/ProfileLayout.dart';
import 'package:smartsfv/functions.dart' as functions;

class ArticleView extends StatefulWidget {
  ArticleView({Key? key}) : super(key: key);
  @override
  ArticleViewState createState() => ArticleViewState();
}

class ArticleViewState extends State<ArticleView> {
  //todo: Method called when the view is launching
  @override
  void initState() {
    super.initState();
    // ? Launching configs
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "ArticleView";
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
        //mini: true,
        //splashColor: Colors.red,
        isExtended: true,
        elevation: 5,
        hoverElevation: 10,
        onPressed: () {
          // TextFormField controllers
          Map<String, dynamic> fieldControllers = {
            'codeBarre': TextEditingController(),
            'designation': TextEditingController(),
            'fournisseur': '',
            'categorie': '',
            'subCategorie': '',
            'stockMin': TextEditingController(),
            'tva': 45 / 100, // 45% de TVA
            'prixAchatTTC': TextEditingController(),
            'prixAchatHT': TextEditingController(),
            'tauxMargeAchat': TextEditingController(),
            'prixVenteTTC': TextEditingController(),
            'prixVenteHT': TextEditingController(),
            'tauxMargeVente': TextEditingController(),
            'imageArticle': TextEditingController(),
            'stockable': true
          };
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          functions.showFormDialog(
            scaffold.currentContext,
            formKey,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            headerIcon: 'assets/img/icons/box.png',
            headerIconColor: Color.fromRGBO(243, 156, 18, 1),
            title: 'Ajouter un nouvel article',
            onValidate: () async {
              if (formKey.currentState!.validate()) {
                // ? get fields datas
                String codeBarre = (fieldControllers['codeBarre'].text)
                    ? fieldControllers['codeBarre'].text
                    : ''; // get code barre
                String designation = fieldControllers['designation']
                    .text; // get designation // ! required
                String fournisseur =
                    (fieldControllers['fournisseur'].text != null)
                        ? fieldControllers['fournisseur'].text
                        : ''; // get fournisseur
                String categorie = fieldControllers['categorie']
                    .toString(); // get categorie // ! required
                String subCategorie = fieldControllers['subCategorie']
                    .toString(); // get subCategorie
                String stockMin = (fieldControllers['stockMin'].text != null)
                    ? fieldControllers['stockMin'].text
                    : ''; // get stockMin
                int tva = fieldControllers['tva']; // get tva // ! required
                int prixAchatTTC = int.parse(fieldControllers['prixAchatTTC']
                    .text); // get prixAchatTTC // ! required
                int prixAchatHT = int.parse(
                    fieldControllers['prixAchatHT'].text); // get prixAchatTTC
                int tauxMargeAchat = int.parse(
                    fieldControllers['tauxMargeAchat']
                        .text); // get tauxMargeAchat
                int prixVenteTTC = int.parse(
                    fieldControllers['prixVenteTTC'].text); // get prixVenteTTC
                int prixVenteHT = int.parse(
                    fieldControllers['prixVenteHT'].text); // get prixVenteTTC
                int tauxMargeVente = int.parse(
                    fieldControllers['tauxMargeVente']
                        .text); // get tauxMargeVente
                String imageArticle =
                    fieldControllers['imageArticle'].text; // get imageArticle
                bool stockable = fieldControllers['stockable']; // get stockable
                // ? sending datas to API
                Api api = Api();
                final Map<String, dynamic> postArticleResponse =
                    await api.postArticle(
                  scaffold.currentContext,
                  codeBarre: codeBarre,
                  designation: designation,
                  fournisseur: fournisseur,
                  categorie: categorie,
                  subCategorie: subCategorie,
                  stockMin: stockMin,
                  tva: tva,
                  prixAchatTTC: prixAchatTTC,
                  prixAchatHT: prixAchatHT,
                  tauxMargeAchat: tauxMargeAchat,
                  prixVenteTTC: prixVenteTTC,
                  prixVenteHT: prixVenteHT,
                  tauxMargeVente: tauxMargeVente,
                  imageArticle: imageArticle,
                  stockable: stockable,
                );
                // ? check the server response
                if (postArticleResponse['msg'] ==
                    'Enregistrement effectué avec succès.') {
                  Navigator.of(
                    scaffold.currentContext!,
                  ).pop();
                  functions.successSnackbar(
                    context: scaffold.currentContext,
                    message: 'Nouvel article ajouté !',
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
              //todo: Code barre Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Code barre label
                  MyText(
                    text: 'Code barre',
                    color: Color.fromRGBO(231, 57, 0, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Code barre TextFormField
                  MyTextFormField(
                    keyboardType: TextInputType.text,
                    textEditingController: fieldControllers['codeBarre'],
                    prefixPadding: 10,
                    prefixIcon: Image.asset(
                      'assets/img/icons/barcode.png',
                      fit: BoxFit.contain,
                      width: 15,
                      height: 15,
                      color: Color.fromRGBO(231, 57, 0, 1),
                    ),
                    placeholder: "Code barre de l'article",
                    textColor: Color.fromRGBO(231, 57, 0, 1),
                    placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                    fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Designation Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Designation label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: 'Désignation',
                        color: Color.fromRGBO(231, 57, 0, 1),
                        fontWeight: FontWeight.bold,
                      ),
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Color.fromRGBO(221, 75, 57, 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //todo: Designation TextFormField
                  MyTextFormField(
                    keyboardType: TextInputType.text,
                    textEditingController: fieldControllers['designation'],
                    validator: (value) {
                      return value!.isNotEmpty
                          ? null
                          : "Saisissez la désignation de l'article";
                    },
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.sort_by_alpha,
                      color: Color.fromRGBO(231, 57, 0, 1),
                    ),
                    placeholder: "Désignation de l'article",
                    textColor: Color.fromRGBO(231, 57, 0, 1),
                    placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                    fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Fournisseur Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Fournisseur label
                  MyText(
                    text: 'Fournisseur',
                    color: Color.fromRGBO(231, 57, 0, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Pays DropDown
                  (ScreenController.actualView != "LoginView")
                      ? FutureBuilder<List<Fournisseur>>(
                          future: this.fetchFournisseurs(),
                          builder: (fournisseurComboBoxContext, snapshot) {
                            if (snapshot.hasData) {
                              // ? get providers datas from server
                              return MyComboBox(
                                onChanged: (value) {
                                  // ? Iterate all providers to get the selected provider id
                                  for (var fournisseur in snapshot.data!) {
                                    if (fournisseur.nom == value) {
                                      fieldControllers['fournisseur'] = fournisseur
                                          .id; // save the new countrie selected
                                      print(
                                          "Nouveau fournisseur: $value, ${fieldControllers['fournisseur']}, ${fournisseur.id}");
                                      break;
                                    }
                                  }
                                },
                                initialDropDownValue:
                                    'Sélectionnez un fournisseur',
                                initialDropDownList: [
                                  'Sélectionnez un fournisseur',
                                  // ? datas integration
                                  for (var fournisseur in snapshot.data!)
                                    fournisseur.nom.toString(),
                                ],
                                prefixPadding: 10,
                                prefixIcon: Image.asset(
                                  'assets/img/icons/provider.png',
                                  fit: BoxFit.contain,
                                  width: 15,
                                  height: 15,
                                  color: Color.fromRGBO(231, 57, 0, 1),
                                ),
                                textColor: Color.fromRGBO(231, 57, 0, 1),
                                fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                                borderRadius: Radius.circular(10),
                                focusBorderColor: Colors.transparent,
                                enableBorderColor: Colors.transparent,
                              );
                            }
                            // ? on wait the combo with data load empty combo
                            return MyTextFormField(
                              prefixPadding: 10,
                              keyboardType: TextInputType.text,
                              prefixIcon: Image.asset(
                                'assets/img/icons/provider.png',
                                fit: BoxFit.contain,
                                width: 15,
                                height: 15,
                                color: Color.fromRGBO(231, 57, 0, 1),
                              ),
                              placeholder: 'Sélectionnez un fournisseur',
                              textColor: Color.fromRGBO(231, 57, 0, 1),
                              placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                              fillColor: Color.fromRGBO(243, 156, 18, 0.15),
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
              //todo: Categorie Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Categorie label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: 'Catégorie',
                        color: Color.fromRGBO(231, 57, 0, 1),
                        fontWeight: FontWeight.bold,
                      ),
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Color.fromRGBO(221, 75, 57, 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //todo: Categorie DropDown
                  (ScreenController.actualView != "LoginView")
                      ? FutureBuilder<List<Categorie>>(
                          future: this.fetchCategories(),
                          builder: (categoryComboBoxContext, snapshot) {
                            if (snapshot.hasData) {
                              // ? get providers datas from server
                              return MyComboBox(
                                onChanged: (value) {
                                  // ? Iterate all providers to get the selected provider id
                                  for (var categorie in snapshot.data!) {
                                    if (categorie.libelle == value) {
                                      fieldControllers['categorie'] = categorie
                                          .id; // save the new countrie selected
                                      print(
                                          "Nouvelle catégorie: $value, ${fieldControllers['categorie']}, ${categorie.id}");
                                      break;
                                    }
                                  }
                                },
                                initialDropDownValue:
                                    'Sélectionnez une catégorie',
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
                                  color: Color.fromRGBO(231, 57, 0, 1),
                                ),
                                textColor: Color.fromRGBO(231, 57, 0, 1),
                                fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                                borderRadius: Radius.circular(10),
                                focusBorderColor: Colors.transparent,
                                enableBorderColor: Colors.transparent,
                              );
                            }
                            // ? on wait the combo with data load empty combo
                            return MyTextFormField(
                              keyboardType: TextInputType.text,
                              prefixPadding: 10,
                              prefixIcon: Image.asset(
                                'assets/img/icons/category.png',
                                fit: BoxFit.contain,
                                width: 15,
                                height: 15,
                                color: Color.fromRGBO(231, 57, 0, 1),
                              ),
                              placeholder: 'Sélectionnez une catégorie',
                              textColor: Color.fromRGBO(231, 57, 0, 1),
                              placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                              fillColor: Color.fromRGBO(243, 156, 18, 0.15),
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
              //todo: SousCategorie Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: SousCategorie label
                  MyText(
                    text: 'Sous catégorie',
                    color: Color.fromRGBO(231, 57, 0, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: SousCategorie DropDown
                  (ScreenController.actualView != "LoginView")
                      ? FutureBuilder<List<SousCategorie>>(
                          future: this.fetchSousCategories(),
                          builder: (sousCategorieComboBoxContext, snapshot) {
                            if (snapshot.hasData) {
                              // ? get providers datas from server
                              return MyComboBox(
                                onChanged: (value) {
                                  // ? Iterate all providers to get the selected provider id
                                  for (var subCategorie in snapshot.data!) {
                                    if (subCategorie.libelle == value) {
                                      fieldControllers['subCategorie'] =
                                          subCategorie
                                              .id; // save the new countrie selected
                                      print(
                                          "Nouvelle catégorie: $value, ${fieldControllers['subCategorie']}, ${subCategorie.id}");
                                      break;
                                    }
                                  }
                                },
                                initialDropDownValue:
                                    'Sélectionnez une sous catégorie',
                                initialDropDownList: [
                                  'Sélectionnez une sous catégorie',
                                  // ? datas integration
                                  for (var subCategorie in snapshot.data!)
                                    subCategorie.libelle,
                                ],
                                prefixPadding: 10,
                                prefixIcon: Image.asset(
                                  'assets/img/icons/sub-category.png',
                                  fit: BoxFit.contain,
                                  width: 15,
                                  height: 15,
                                  color: Color.fromRGBO(231, 57, 0, 1),
                                ),
                                textColor: Color.fromRGBO(231, 57, 0, 1),
                                fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                                borderRadius: Radius.circular(10),
                                focusBorderColor: Colors.transparent,
                                enableBorderColor: Colors.transparent,
                              );
                            }
                            // ? on wait the combo with data load empty combo
                            return MyTextFormField(
                              keyboardType: TextInputType.text,
                              prefixPadding: 10,
                              prefixIcon: Image.asset(
                                'assets/img/icons/sub-category.png',
                                fit: BoxFit.contain,
                                width: 15,
                                height: 15,
                                color: Color.fromRGBO(231, 57, 0, 1),
                              ),
                              placeholder: 'Sélectionnez une sous catégorie',
                              textColor: Color.fromRGBO(231, 57, 0, 1),
                              placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                              fillColor: Color.fromRGBO(243, 156, 18, 0.15),
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
              //todo: Stock minimum Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Stock minimum label
                  MyText(
                    text: 'Stock minimum',
                    color: Color.fromRGBO(231, 57, 0, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Stock minimum TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['stockMin'],
                    keyboardType: TextInputType.number,
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.battery_alert_rounded,
                      color: Color.fromRGBO(231, 57, 0, 1),
                    ),
                    placeholder: "Stock minimun de l'article",
                    textColor: Color.fromRGBO(231, 57, 0, 1),
                    placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                    fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Tva Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Tva label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: 'TVA',
                        color: Color.fromRGBO(231, 57, 0, 1),
                        fontWeight: FontWeight.bold,
                      ),
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Color.fromRGBO(221, 75, 57, 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //todo: Tva DropDown
                  (ScreenController.actualView != "LoginView")
                      ? FutureBuilder<List<Tva>>(
                          future: this.fetchTvas(),
                          builder: (tvaComboBoxContext, snapshot) {
                            if (snapshot.hasData) {
                              // ? get providers datas from server
                              return MyComboBox(
                                onChanged: (value) {
                                  // ? Iterate all providers to get the selected provider id
                                  for (var tva in snapshot.data!) {
                                    if (tva.percent.toString() == value) {
                                      fieldControllers['tva'] = tva
                                          .id; // save the new countrie selected
                                      print(
                                          "Nouvelle catégorie: $value, ${fieldControllers['tva']}, ${tva.id}");
                                      break;
                                    }
                                  }
                                },
                                initialDropDownValue: 'Sélectionnez une taxe',
                                initialDropDownList: [
                                  'Sélectionnez une taxe',
                                  // ? datas integration
                                  for (var tva in snapshot.data!)
                                    tva.percent.toString(),
                                ],
                                prefixPadding: 10,
                                prefixIcon: Image.asset(
                                  'assets/img/icons/tax.png',
                                  fit: BoxFit.contain,
                                  width: 15,
                                  height: 15,
                                  color: Color.fromRGBO(231, 57, 0, 1),
                                ),
                                textColor: Color.fromRGBO(231, 57, 0, 1),
                                fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                                borderRadius: Radius.circular(10),
                                focusBorderColor: Colors.transparent,
                                enableBorderColor: Colors.transparent,
                              );
                            }
                            // ? on wait the combo with data load empty combo
                            return MyTextFormField(
                              prefixPadding: 10,
                              keyboardType: TextInputType.number,
                              prefixIcon: Image.asset(
                                'assets/img/icons/tax.png',
                                fit: BoxFit.contain,
                                width: 15,
                                height: 15,
                                color: Color.fromRGBO(231, 57, 0, 1),
                              ),
                              placeholder: 'Sélectionnez une taxe',
                              textColor: Color.fromRGBO(231, 57, 0, 1),
                              placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                              fillColor: Color.fromRGBO(243, 156, 18, 0.15),
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
              //todo: Prix d'achat TTC Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Prix d'achat TTC label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: "Prix d'achat TTC",
                        color: Color.fromRGBO(231, 57, 0, 1),
                        fontWeight: FontWeight.bold,
                      ),
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Color.fromRGBO(221, 75, 57, 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //todo: Prix d'achat TTC TextFormField
                  MyTextFormField(
                    textEditingController: fieldControllers['prixAchatTTC'],
                    keyboardType: TextInputType.number,
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.attach_money_rounded,
                      color: Color.fromRGBO(231, 57, 0, 1),
                    ),
                    placeholder: "Prix d'achat TTC de l'article",
                    textColor: Color.fromRGBO(231, 57, 0, 1),
                    placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                    fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                    onChanged: (value) {
                      int prixAchatTTC = int.parse(value!);
                      double prixAchatHT =
                          prixAchatTTC / (1 + fieldControllers['tva']);
                      fieldControllers['prixAchatHT'].text =
                          prixAchatHT.toInt().toString();
                      // ? Compute the Tolerance value
                      if (value.isNotEmpty &&
                          fieldControllers['prixVenteTTC'].text.isNotEmpty) {
                        int prixVenteTTC =
                            int.parse(fieldControllers['prixVenteTTC'].text);
                        // ? Taux Marge Vente
                        double tauxMargeVente = ((prixVenteTTC - prixAchatTTC) *
                            (100 / prixVenteTTC));
                        // ? Taux Marge Achat
                        double tauxMargeAchat = ((prixVenteTTC - prixAchatTTC) *
                            (100 / prixAchatTTC));
                        // ? Update field
                        fieldControllers['tauxMargeAchat'].text =
                            tauxMargeAchat.toInt().toString() + '%';
                        fieldControllers['tauxMargeVente'].text =
                            tauxMargeVente.toInt().toString() + '%';
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Prix d'achat HT Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Prix d'achat HT label
                  MyText(
                    text: "Prix d'achat HT",
                    color: Color.fromRGBO(231, 57, 0, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Prix d'achat HT TextFormField
                  MyTextFormField(
                    enabled: false,
                    keyboardType: TextInputType.number,
                    textEditingController: fieldControllers['prixAchatHT'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.attach_money_rounded,
                      color: Color.fromRGBO(231, 57, 0, 1),
                    ),
                    placeholder: "Prix d'achat hors taxe de l'article",
                    textColor: Color.fromRGBO(231, 57, 0, 1),
                    placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                    fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Taux de marge achat Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Taux de marge achat label
                  MyText(
                    text: "Taux de marge achat",
                    color: Color.fromRGBO(231, 57, 0, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Taux de marge achat TextFormField
                  MyTextFormField(
                    enabled: false,
                    keyboardType: TextInputType.number,
                    textEditingController: fieldControllers['tauxMargeAchat'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.circle,
                      color: Color.fromRGBO(231, 57, 0, 1),
                    ),
                    placeholder: "Taux de marge sur l'achat",
                    textColor: Color.fromRGBO(231, 57, 0, 1),
                    placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                    fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Prix de vente TTC Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Prix de vente TTC label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: "Prix de vente TTC",
                        color: Color.fromRGBO(231, 57, 0, 1),
                        fontWeight: FontWeight.bold,
                      ),
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Color.fromRGBO(221, 75, 57, 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //todo: Prix de vente TTC TextFormField
                  MyTextFormField(
                    keyboardType: TextInputType.number,
                    textEditingController: fieldControllers['prixVenteTTC'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.attach_money_rounded,
                      color: Color.fromRGBO(231, 57, 0, 1),
                    ),
                    placeholder: "Prix de vente TTC de l'article",
                    textColor: Color.fromRGBO(231, 57, 0, 1),
                    placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                    fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                    onChanged: (value) {
                      // ? Compute the HT Price
                      int prixVenteTTC = int.parse(value!);
                      double prixVenteHT =
                          prixVenteTTC / (1 + fieldControllers['tva']);
                      fieldControllers['prixVenteHT'].text =
                          prixVenteHT.toInt().toString();
                      // ? Compute the Tolerance value
                      if (value.isNotEmpty &&
                          fieldControllers['prixAchatTTC'].text.isNotEmpty) {
                        int prixAchatTTC =
                            int.parse(fieldControllers['prixAchatTTC'].text);
                        // ? Taux Marge Vente
                        double tauxMargeVente = ((prixVenteTTC - prixAchatTTC) *
                            (100 / prixVenteTTC));
                        // ? Taux Marge Achat
                        double tauxMargeAchat = ((prixVenteTTC - prixAchatTTC) *
                            (100 / prixAchatTTC));
                        // ? Update field
                        fieldControllers['tauxMargeAchat'].text =
                            tauxMargeAchat.toInt().toString() + '%';
                        fieldControllers['tauxMargeVente'].text =
                            tauxMargeVente.toInt().toString() + '%';
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Prix de vente HT Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Prix de vente HT label
                  MyText(
                    text: "Prix de vente HT",
                    color: Color.fromRGBO(231, 57, 0, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Prix de vente HT TextFormField
                  MyTextFormField(
                    enabled: false,
                    keyboardType: TextInputType.number,
                    textEditingController: fieldControllers['prixVenteHT'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.attach_money_rounded,
                      color: Color.fromRGBO(231, 57, 0, 1),
                    ),
                    placeholder: "Prix de vente hors taxe de l'article",
                    textColor: Color.fromRGBO(231, 57, 0, 1),
                    placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                    fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Taux de marge vente Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Taux de marge vente label
                  MyText(
                    text: "Taux de marge vente",
                    color: Color.fromRGBO(231, 57, 0, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Taux de marge vente TextFormField
                  MyTextFormField(
                    enabled: false,
                    keyboardType: TextInputType.number,
                    textEditingController: fieldControllers['tauxMargeVente'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.circle,
                      color: Color.fromRGBO(231, 57, 0, 1),
                    ),
                    placeholder: "Taux de marge sur la vente",
                    textColor: Color.fromRGBO(231, 57, 0, 1),
                    placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                    fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Image Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: Image label
                  MyText(
                    text: 'Image',
                    color: Color.fromRGBO(231, 57, 0, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  //todo: Image TextFormField
                  MyTextFormField(
                    keyboardType: TextInputType.number,
                    textEditingController: fieldControllers['imageArticle'],
                    prefixPadding: 10,
                    prefixIcon: Icon(
                      Icons.location_history_rounded,
                      color: Color.fromRGBO(231, 57, 0, 1),
                    ),
                    placeholder: "Image de l'article",
                    textColor: Color.fromRGBO(231, 57, 0, 1),
                    placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                    fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Stockabl CheckBox
              CheckboxListTile(
                value: fieldControllers['stockable'],
                checkColor: Color.fromRGBO(231, 57, 0, 1),
                title: MyText(
                  text: 'Article non stockable',
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  setState(() {
                    fieldControllers['stockable'] = false;
                  });
                },
              ),
            ],
          );
        },
        //backgroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(243, 156, 18, 1),
        child: Tooltip(
          message: 'Ajouter un article',
          decoration: BoxDecoration(
            color: Color.fromRGBO(243, 156, 18, 1),
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
            'assets/img/icons/add-box.png',
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
          DrawerLayout(panelController: panelController),
          //todo: Home Screen
          ArticleScreen(panelController: panelController),
          //todo: Profile Layout
          ProfileLayout(
            panelController: panelController,
          ),
        ],
      ),
    );
  }

  Future<List<Fournisseur>> fetchFournisseurs() async {
    // init API instance
    Api api = Api();
    // call API method getFournisseurs
    Future<List<Fournisseur>> fournisseurs = api.getFournisseurs(context);
    // return results
    return fournisseurs;
  }

  Future<List<Categorie>> fetchCategories() async {
    // init API instance
    Api api = Api();
    // call API method getCategories
    Future<List<Categorie>> categories = api.getCategories(context);
    // return results
    return categories;
  }

  Future<List<SousCategorie>> fetchSousCategories() async {
    // init API instance
    Api api = Api();
    // call API method getSousCategories
    Future<List<SousCategorie>> subcategories = api.getSousCategories(context);
    // return results
    return subcategories;
  }

  Future<List<Tva>>? fetchTvas() async {
    // init API instance
    Api api = Api();
    // call API method getTvas
    Future<List<Tva>> tvas = api.getTvas(context);
    // return results
    return tvas;
  }
}
