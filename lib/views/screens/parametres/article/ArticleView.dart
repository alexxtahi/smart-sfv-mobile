import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Article.dart';
import 'package:smartsfv/models/Categorie.dart';
import 'package:smartsfv/models/Fournisseur.dart';
import 'package:smartsfv/models/SousCategorie.dart';
import 'package:smartsfv/models/Tva.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/screens/parametres/article/ArticleScreen.dart';
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
            'description': TextEditingController(),
            'fournisseur': [],
            'categorie': 0,
            'sousCategorie': 0,
            'stockMin': TextEditingController(),
            'tva': 45 / 100, // 45% de TVA
            'prixAchatTTC': TextEditingController(),
            'prixAchatHT': TextEditingController(),
            'tauxMargeAchat': TextEditingController(),
            'prixVenteTTC': TextEditingController(),
            'prixVenteHT': TextEditingController(),
            'tauxMargeVente': TextEditingController(),
            'imageArticle': TextEditingController(),
            'stockable': true,
          };
          // ! Start debug
          fieldControllers['codeBarre'].text = '0345';
          fieldControllers['description'].text = 'Assiette cassable';
          fieldControllers['stockMin'].text = '12';
          fieldControllers['prixAchatTTC'].text = '200';
          fieldControllers['prixAchatHT'].text = '50';
          fieldControllers['tauxMargeAchat'].text = '27';
          fieldControllers['prixVenteTTC'].text = '1500';
          fieldControllers['prixVenteHT'].text = '1000';
          fieldControllers['tauxMargeVente'].text = '39';
          // ! End debug
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
                // ? sending datas to API
                Api api = Api();
                final Map<String, dynamic> postArticleResponse =
                    await api.postArticle(
                  context: scaffold.currentContext,
                  article: Article.fromJson({
                    'code_barre':
                        (fieldControllers['codeBarre'].text.isNotEmpty)
                            ? fieldControllers['codeBarre'].text
                            : '', // get code barre
                    'description_article': fieldControllers['description']
                        .text, // get description // ! required
                    'fournisseur': (fieldControllers['fournisseur'] != 0)
                        ? [
                            {
                              'id': fieldControllers['fournisseur'],
                            },
                          ]
                        : [], // get fournisseur
                    'categorie': {
                      'id': fieldControllers['categorie'],
                    }, // get categorie // ! required
                    'sous_categorie': (fieldControllers['sousCategorie'] != 0)
                        ? {
                            'id': fieldControllers['sousCategorie'],
                          }
                        : null, // get sousCategorie
                    'stock_mini': (fieldControllers['stockMin'].text.isNotEmpty)
                        ? int.parse(fieldControllers['stockMin'].text)
                        : 0, // get stockMin
                    'param_tva': {
                      'id': fieldControllers['tva'],
                    }, // get tva // ! required
                    'prix_achat_ttc': int.parse(fieldControllers['prixAchatTTC']
                        .text), // get prixAchatTTC // ! required
                    'prix_achat_ht': int.parse(fieldControllers['prixAchatHT']
                        .text), // get prixAchatTTC
                    'taux_airsi_achat':
                        (fieldControllers['tauxMargeAchat'].text.isNotEmpty)
                            ? int.parse(fieldControllers['tauxMargeAchat']
                                .text
                                .replaceAll('%', ''))
                            : null, // get tauxMargeAchat
                    'prix_vente_ttc_base': int.parse(
                        fieldControllers['prixVenteTTC']
                            .text), // get prixVenteTTC
                    'prix_vente_ht': int.parse(fieldControllers['prixVenteHT']
                        .text), // get prixVenteTTC
                    'taux_airsi_vente':
                        (fieldControllers['tauxMargeVente'].text.isNotEmpty)
                            ? int.parse(fieldControllers['tauxMargeVente']
                                .text
                                .replaceAll('%', ''))
                            : null, // get tauxMargeVente
                    /*'image': fieldControllers['imageArticle']
                        .text, // get imageArticle*/
                    'stockable': fieldControllers['stockable'], // get stockable
                  }),
                );
                // ? check the server response
                if (postArticleResponse['msg'] ==
                    'Enregistrement effectué avec succès.') {
                  // ? In Success case
                  Navigator.of(context).pop();
                  functions.showSuccessDialog(
                    context: scaffold.currentContext,
                    message: 'Nouvel article ajouté !',
                  );
                } else if (postArticleResponse['msg'] ==
                    "Cet enregistrement existe déjà dans la base, vérifier le nom de l'article ou le code barre") {
                  // ? In instance already exist case
                  Navigator.of(context).pop();
                  functions.showWarningDialog(
                    context: scaffold.currentContext,
                    message: 'Vous avez déjà enregistré cet article !',
                  );
                } else {
                  // ? In Error case
                  Navigator.of(context).pop();
                  functions.showErrorDialog(
                    context: scaffold.currentContext,
                    message: "Une erreur s'est produite",
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
                    textEditingController: fieldControllers['description'],
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
                          future: api.getFournisseurs(context),
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
                          future: api.getCategories(context),
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
                          future: api.getSousCategories(context),
                          builder: (sousCategorieComboBoxContext, snapshot) {
                            if (snapshot.hasData) {
                              // ? get providers datas from server
                              return MyComboBox(
                                onChanged: (value) {
                                  // ? Iterate all providers to get the selected provider id
                                  for (var sousCategorie in snapshot.data!) {
                                    if (sousCategorie.libelle == value) {
                                      fieldControllers['sousCategorie'] =
                                          sousCategorie
                                              .id; // save the new countrie selected
                                      print(
                                          "Nouvelle catégorie: $value, ${fieldControllers['sousCategorie']}, ${sousCategorie.id}");
                                      break;
                                    }
                                  }
                                },
                                initialDropDownValue:
                                    'Sélectionnez une sous catégorie',
                                initialDropDownList: [
                                  'Sélectionnez une sous catégorie',
                                  // ? datas integration
                                  for (var sousCategorie in snapshot.data!)
                                    sousCategorie.libelle,
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
                          future: api.getTvas(context),
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
              /*Column(
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
              SizedBox(height: 10),*/
              //todo: Stockable CheckBox
              CheckboxListTile(
                value: fieldControllers['stockable'],
                checkColor: Color.fromRGBO(231, 57, 0, 1),
                title: MyText(
                  text: 'Article non stockable',
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  print('Article stockable = ' + value.toString());
                  setState(() {
                    fieldControllers['stockable'] = value;
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
}
