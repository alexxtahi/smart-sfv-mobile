import 'package:smartsfv/functions.dart' as functions;
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Article.dart';
import 'package:smartsfv/models/Categorie.dart';
import 'package:smartsfv/models/Fournisseur.dart';
import 'package:smartsfv/models/Research.dart';
import 'package:smartsfv/models/SousCategorie.dart';
import 'package:smartsfv/models/Tva.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyOutlinedIconButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';

class FicheArticleView extends StatefulWidget {
  final ValueChanged<Function> parentSetState;
  FicheArticleView({
    Key? key,
    required this.parentSetState,
  }) : super(key: key);
  @override
  FicheArticleViewState createState() => FicheArticleViewState();
}

class FicheArticleViewState extends State<FicheArticleView> {
  //todo: Method called when the view is launching
  @override
  void initState() {
    super.initState();
    // ? Launching configs
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "FicheArticleView";
      ScreenController.isChildView = true;
      // ? Call preset fields function
      presetFields();
    }
  }

  //todo: Method called when the view is closing
  @override
  void dispose() {
    // ? Set actualView to "HomeView"
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "ArticleView";
      ScreenController.isChildView = true;
      Article.article = null;
    }
    super.dispose();
  }

  ScrollController mainScrollController = ScrollController();
  TextEditingController numberFactureController = TextEditingController();
  Api api = Api();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey scaffold = GlobalKey();
  bool isEditMode = false;
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
  // method to put selected article value ton the inputs
  void presetFields() {
    if (Article.article != null) {
      fieldControllers['codeBarre'].text = Article.article!.codeBarre;
      fieldControllers['description'].text = Article.article!.description;
      fieldControllers['stockMin'].text = Article.article!.stockMin.toString();
      fieldControllers['prixAchatTTC'].text =
          Article.article!.prixAchatTTC.toString();
      fieldControllers['prixAchatHT'].text =
          Article.article!.prixAchatHT.toString();
      fieldControllers['tauxMargeAchat'].text =
          Article.article!.tauxMargeAchat.toString();
      fieldControllers['prixVenteTTC'].text =
          Article.article!.prixVenteTTC.toString();
      fieldControllers['prixVenteHT'].text =
          Article.article!.prixVenteHT.toString();
      fieldControllers['tauxMargeVente'].text =
          Article.article!.tauxMargeVente.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Flex(
            direction: Axis.vertical,
            children: [
              //todo: BackButton & Title
              Row(
                children: [
                  //todo: BackButton
                  MyOutlinedIconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color.fromRGBO(243, 156, 18, 1),
                      size: 40,
                    ),
                    iconSize: 30,
                    size: 50,
                    borderRadius: 15,
                    borderColor: Color.fromRGBO(243, 156, 18, 1),
                    backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                    onPressed: () {
                      print("isChildView -> " +
                          ScreenController.isChildView.toString()); // ! debug
                      Navigator.of(context).pop();
                      // ? Reload article table
                      widget.parentSetState(() {
                        ScreenController.isChildView = false;
                        MyDataTable.selectedRowIndex = null;
                        Article.article = null;
                        Research.reset(); // Reset last research datas
                      });
                    },
                  ),
                  SizedBox(width: 15),
                  //todo: Title
                  MyText(
                    text: 'Article',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Scrollable view
              Expanded(
                child: FadingEdgeScrollView.fromSingleChildScrollView(
                  gradientFractionOnStart: 0.2,
                  gradientFractionOnEnd: 0.2,
                  child: SingleChildScrollView(
                    controller: mainScrollController,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        //todo: Article Infos
                        Container(
                          width: screenSize[0],
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(243, 156, 18, 0.5),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //todo: Article Avatar
                              CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    Color.fromRGBO(243, 156, 18, 0.5),
                                child: Image.asset(
                                  'assets/img/icons/box.png',
                                  color: Colors.white,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(width: 15),
                              //todo: Article Description & Prix
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //todo: Article Description
                                  MyText(
                                    text: (Article.article != null)
                                        ? Article.article!.description
                                        : "Inconnu",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 10),
                                  //todo: Article Prix
                                  MyText(
                                    text: (Article.article != null)
                                        ? Article.article!.prixVenteTTC
                                                .toString() +
                                            ' FCFA'
                                        : "Aucun prix",
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        //todo: Article Form
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
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
                                    enabled: this.isEditMode,
                                    keyboardType: TextInputType.text,
                                    textEditingController:
                                        fieldControllers['codeBarre'],
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
                                    placeholderColor:
                                        Color.fromRGBO(231, 57, 0, 1),
                                    fillColor:
                                        Color.fromRGBO(243, 156, 18, 0.15),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                        text: 'Désignation',
                                        color: Color.fromRGBO(231, 57, 0, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CircleAvatar(
                                        radius: 5,
                                        backgroundColor:
                                            Color.fromRGBO(221, 75, 57, 1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  //todo: Designation TextFormField
                                  MyTextFormField(
                                    enabled: this.isEditMode,
                                    keyboardType: TextInputType.text,
                                    textEditingController:
                                        fieldControllers['description'],
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
                                    placeholderColor:
                                        Color.fromRGBO(231, 57, 0, 1),
                                    fillColor:
                                        Color.fromRGBO(243, 156, 18, 0.15),
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
                                          builder: (fournisseurComboBoxContext,
                                              snapshot) {
                                            if (snapshot.hasData) {
                                              // ? get providers datas from server
                                              return MyComboBox(
                                                onChanged: (value) {
                                                  // ? Iterate all providers to get the selected provider id
                                                  for (var fournisseur
                                                      in snapshot.data!) {
                                                    if (fournisseur.nom ==
                                                        value) {
                                                      fieldControllers[
                                                              'fournisseur'] =
                                                          fournisseur
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
                                                  for (var fournisseur
                                                      in snapshot.data!)
                                                    fournisseur.nom.toString(),
                                                ],
                                                prefixPadding: 10,
                                                prefixIcon: Image.asset(
                                                  'assets/img/icons/provider.png',
                                                  fit: BoxFit.contain,
                                                  width: 15,
                                                  height: 15,
                                                  color: Color.fromRGBO(
                                                      231, 57, 0, 1),
                                                ),
                                                textColor: Color.fromRGBO(
                                                    231, 57, 0, 1),
                                                fillColor: Color.fromRGBO(
                                                    243, 156, 18, 0.15),
                                                borderRadius:
                                                    Radius.circular(10),
                                                focusBorderColor:
                                                    Colors.transparent,
                                                enableBorderColor:
                                                    Colors.transparent,
                                              );
                                            }
                                            // ? on wait the combo with data load empty combo
                                            return MyTextFormField(
                                              enabled: this.isEditMode,
                                              prefixPadding: 10,
                                              keyboardType: TextInputType.text,
                                              prefixIcon: Image.asset(
                                                'assets/img/icons/provider.png',
                                                fit: BoxFit.contain,
                                                width: 15,
                                                height: 15,
                                                color: Color.fromRGBO(
                                                    231, 57, 0, 1),
                                              ),
                                              placeholder:
                                                  'Sélectionnez un fournisseur',
                                              textColor:
                                                  Color.fromRGBO(231, 57, 0, 1),
                                              placeholderColor:
                                                  Color.fromRGBO(231, 57, 0, 1),
                                              fillColor: Color.fromRGBO(
                                                  243, 156, 18, 0.15),
                                              borderRadius: Radius.circular(10),
                                              focusBorderColor:
                                                  Colors.transparent,
                                              enableBorderColor:
                                                  Colors.transparent,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                        text: 'Catégorie',
                                        color: Color.fromRGBO(231, 57, 0, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CircleAvatar(
                                        radius: 5,
                                        backgroundColor:
                                            Color.fromRGBO(221, 75, 57, 1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  //todo: Categorie DropDown
                                  (ScreenController.actualView != "LoginView")
                                      ? FutureBuilder<List<Categorie>>(
                                          future: api.getCategories(context),
                                          builder: (categoryComboBoxContext,
                                              snapshot) {
                                            if (snapshot.hasData) {
                                              // ? get providers datas from server
                                              return MyComboBox(
                                                onChanged: (value) {
                                                  // ? Iterate all providers to get the selected provider id
                                                  for (var categorie
                                                      in snapshot.data!) {
                                                    if (categorie.libelle ==
                                                        value) {
                                                      fieldControllers[
                                                              'categorie'] =
                                                          categorie
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
                                                  for (var categorie
                                                      in snapshot.data!)
                                                    categorie.libelle,
                                                ],
                                                prefixPadding: 10,
                                                prefixIcon: Image.asset(
                                                  'assets/img/icons/category.png',
                                                  fit: BoxFit.contain,
                                                  width: 15,
                                                  height: 15,
                                                  color: Color.fromRGBO(
                                                      231, 57, 0, 1),
                                                ),
                                                textColor: Color.fromRGBO(
                                                    231, 57, 0, 1),
                                                fillColor: Color.fromRGBO(
                                                    243, 156, 18, 0.15),
                                                borderRadius:
                                                    Radius.circular(10),
                                                focusBorderColor:
                                                    Colors.transparent,
                                                enableBorderColor:
                                                    Colors.transparent,
                                              );
                                            }
                                            // ? on wait the combo with data load empty combo
                                            return MyTextFormField(
                                              enabled: this.isEditMode,
                                              keyboardType: TextInputType.text,
                                              prefixPadding: 10,
                                              prefixIcon: Image.asset(
                                                'assets/img/icons/category.png',
                                                fit: BoxFit.contain,
                                                width: 15,
                                                height: 15,
                                                color: Color.fromRGBO(
                                                    231, 57, 0, 1),
                                              ),
                                              placeholder:
                                                  'Sélectionnez une catégorie',
                                              textColor:
                                                  Color.fromRGBO(231, 57, 0, 1),
                                              placeholderColor:
                                                  Color.fromRGBO(231, 57, 0, 1),
                                              fillColor: Color.fromRGBO(
                                                  243, 156, 18, 0.15),
                                              borderRadius: Radius.circular(10),
                                              focusBorderColor:
                                                  Colors.transparent,
                                              enableBorderColor:
                                                  Colors.transparent,
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
                                          future:
                                              api.getSousCategories(context),
                                          builder:
                                              (sousCategorieComboBoxContext,
                                                  snapshot) {
                                            if (snapshot.hasData) {
                                              // ? get providers datas from server
                                              return MyComboBox(
                                                onChanged: (value) {
                                                  // ? Iterate all providers to get the selected provider id
                                                  for (var sousCategorie
                                                      in snapshot.data!) {
                                                    if (sousCategorie.libelle ==
                                                        value) {
                                                      fieldControllers[
                                                              'sousCategorie'] =
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
                                                  for (var sousCategorie
                                                      in snapshot.data!)
                                                    sousCategorie.libelle,
                                                ],
                                                prefixPadding: 10,
                                                prefixIcon: Image.asset(
                                                  'assets/img/icons/sub-category.png',
                                                  fit: BoxFit.contain,
                                                  width: 15,
                                                  height: 15,
                                                  color: Color.fromRGBO(
                                                      231, 57, 0, 1),
                                                ),
                                                textColor: Color.fromRGBO(
                                                    231, 57, 0, 1),
                                                fillColor: Color.fromRGBO(
                                                    243, 156, 18, 0.15),
                                                borderRadius:
                                                    Radius.circular(10),
                                                focusBorderColor:
                                                    Colors.transparent,
                                                enableBorderColor:
                                                    Colors.transparent,
                                              );
                                            }
                                            // ? on wait the combo with data load empty combo
                                            return MyTextFormField(
                                              enabled: this.isEditMode,
                                              keyboardType: TextInputType.text,
                                              prefixPadding: 10,
                                              prefixIcon: Image.asset(
                                                'assets/img/icons/sub-category.png',
                                                fit: BoxFit.contain,
                                                width: 15,
                                                height: 15,
                                                color: Color.fromRGBO(
                                                    231, 57, 0, 1),
                                              ),
                                              placeholder:
                                                  'Sélectionnez une sous catégorie',
                                              textColor:
                                                  Color.fromRGBO(231, 57, 0, 1),
                                              placeholderColor:
                                                  Color.fromRGBO(231, 57, 0, 1),
                                              fillColor: Color.fromRGBO(
                                                  243, 156, 18, 0.15),
                                              borderRadius: Radius.circular(10),
                                              focusBorderColor:
                                                  Colors.transparent,
                                              enableBorderColor:
                                                  Colors.transparent,
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
                                    enabled: this.isEditMode,
                                    textEditingController:
                                        fieldControllers['stockMin'],
                                    keyboardType: TextInputType.number,
                                    prefixPadding: 10,
                                    prefixIcon: Icon(
                                      Icons.battery_alert_rounded,
                                      color: Color.fromRGBO(231, 57, 0, 1),
                                    ),
                                    placeholder: "Stock minimun de l'article",
                                    textColor: Color.fromRGBO(231, 57, 0, 1),
                                    placeholderColor:
                                        Color.fromRGBO(231, 57, 0, 1),
                                    fillColor:
                                        Color.fromRGBO(243, 156, 18, 0.15),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                        text: 'TVA',
                                        color: Color.fromRGBO(231, 57, 0, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CircleAvatar(
                                        radius: 5,
                                        backgroundColor:
                                            Color.fromRGBO(221, 75, 57, 1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  //todo: Tva DropDown
                                  (ScreenController.actualView != "LoginView")
                                      ? FutureBuilder<List<Tva>>(
                                          future: api.getTvas(context),
                                          builder:
                                              (tvaComboBoxContext, snapshot) {
                                            if (snapshot.hasData) {
                                              // ? get providers datas from server
                                              return MyComboBox(
                                                onChanged: (value) {
                                                  // ? Iterate all providers to get the selected provider id
                                                  for (var tva
                                                      in snapshot.data!) {
                                                    if (tva.percent
                                                            .toString() ==
                                                        value) {
                                                      fieldControllers['tva'] =
                                                          tva.id; // save the new countrie selected
                                                      print(
                                                          "Nouvelle catégorie: $value, ${fieldControllers['tva']}, ${tva.id}");
                                                      break;
                                                    }
                                                  }
                                                },
                                                initialDropDownValue:
                                                    'Sélectionnez une taxe',
                                                initialDropDownList: [
                                                  'Sélectionnez une taxe',
                                                  // ? datas integration
                                                  for (var tva
                                                      in snapshot.data!)
                                                    tva.percent.toString(),
                                                ],
                                                prefixPadding: 10,
                                                prefixIcon: Image.asset(
                                                  'assets/img/icons/tax.png',
                                                  fit: BoxFit.contain,
                                                  width: 15,
                                                  height: 15,
                                                  color: Color.fromRGBO(
                                                      231, 57, 0, 1),
                                                ),
                                                textColor: Color.fromRGBO(
                                                    231, 57, 0, 1),
                                                fillColor: Color.fromRGBO(
                                                    243, 156, 18, 0.15),
                                                borderRadius:
                                                    Radius.circular(10),
                                                focusBorderColor:
                                                    Colors.transparent,
                                                enableBorderColor:
                                                    Colors.transparent,
                                              );
                                            }
                                            // ? on wait the combo with data load empty combo
                                            return MyTextFormField(
                                              enabled: this.isEditMode,
                                              prefixPadding: 10,
                                              keyboardType:
                                                  TextInputType.number,
                                              prefixIcon: Image.asset(
                                                'assets/img/icons/tax.png',
                                                fit: BoxFit.contain,
                                                width: 15,
                                                height: 15,
                                                color: Color.fromRGBO(
                                                    231, 57, 0, 1),
                                              ),
                                              placeholder:
                                                  'Sélectionnez une taxe',
                                              textColor:
                                                  Color.fromRGBO(231, 57, 0, 1),
                                              placeholderColor:
                                                  Color.fromRGBO(231, 57, 0, 1),
                                              fillColor: Color.fromRGBO(
                                                  243, 156, 18, 0.15),
                                              borderRadius: Radius.circular(10),
                                              focusBorderColor:
                                                  Colors.transparent,
                                              enableBorderColor:
                                                  Colors.transparent,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                        text: "Prix d'achat TTC",
                                        color: Color.fromRGBO(231, 57, 0, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CircleAvatar(
                                        radius: 5,
                                        backgroundColor:
                                            Color.fromRGBO(221, 75, 57, 1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  //todo: Prix d'achat TTC TextFormField
                                  MyTextFormField(
                                    enabled: this.isEditMode,
                                    textEditingController:
                                        fieldControllers['prixAchatTTC'],
                                    keyboardType: TextInputType.number,
                                    prefixPadding: 10,
                                    prefixIcon: Icon(
                                      Icons.attach_money_rounded,
                                      color: Color.fromRGBO(231, 57, 0, 1),
                                    ),
                                    placeholder:
                                        "Prix d'achat TTC de l'article",
                                    textColor: Color.fromRGBO(231, 57, 0, 1),
                                    placeholderColor:
                                        Color.fromRGBO(231, 57, 0, 1),
                                    fillColor:
                                        Color.fromRGBO(243, 156, 18, 0.15),
                                    borderRadius: Radius.circular(10),
                                    focusBorderColor: Colors.transparent,
                                    enableBorderColor: Colors.transparent,
                                    onChanged: (value) {
                                      int prixAchatTTC = int.parse(value!);
                                      double prixAchatHT = prixAchatTTC /
                                          (1 + fieldControllers['tva']);
                                      fieldControllers['prixAchatHT'].text =
                                          prixAchatHT.toInt().toString();
                                      // ? Compute the Tolerance value
                                      if (value.isNotEmpty &&
                                          fieldControllers['prixVenteTTC']
                                              .text
                                              .isNotEmpty) {
                                        int prixVenteTTC = int.parse(
                                            fieldControllers['prixVenteTTC']
                                                .text);
                                        // ? Taux Marge Vente
                                        double tauxMargeVente =
                                            ((prixVenteTTC - prixAchatTTC) *
                                                (100 / prixVenteTTC));
                                        // ? Taux Marge Achat
                                        double tauxMargeAchat =
                                            ((prixVenteTTC - prixAchatTTC) *
                                                (100 / prixAchatTTC));
                                        // ? Update field
                                        fieldControllers['tauxMargeAchat']
                                                .text =
                                            tauxMargeAchat.toInt().toString() +
                                                '%';
                                        fieldControllers['tauxMargeVente']
                                                .text =
                                            tauxMargeVente.toInt().toString() +
                                                '%';
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
                                    textEditingController:
                                        fieldControllers['prixAchatHT'],
                                    prefixPadding: 10,
                                    prefixIcon: Icon(
                                      Icons.attach_money_rounded,
                                      color: Color.fromRGBO(231, 57, 0, 1),
                                    ),
                                    placeholder:
                                        "Prix d'achat hors taxe de l'article",
                                    textColor: Color.fromRGBO(231, 57, 0, 1),
                                    placeholderColor:
                                        Color.fromRGBO(231, 57, 0, 1),
                                    fillColor:
                                        Color.fromRGBO(243, 156, 18, 0.15),
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
                                    textEditingController:
                                        fieldControllers['tauxMargeAchat'],
                                    prefixPadding: 10,
                                    prefixIcon: Icon(
                                      Icons.circle,
                                      color: Color.fromRGBO(231, 57, 0, 1),
                                    ),
                                    placeholder: "Taux de marge sur l'achat",
                                    textColor: Color.fromRGBO(231, 57, 0, 1),
                                    placeholderColor:
                                        Color.fromRGBO(231, 57, 0, 1),
                                    fillColor:
                                        Color.fromRGBO(243, 156, 18, 0.15),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                        text: "Prix de vente TTC",
                                        color: Color.fromRGBO(231, 57, 0, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CircleAvatar(
                                        radius: 5,
                                        backgroundColor:
                                            Color.fromRGBO(221, 75, 57, 1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  //todo: Prix de vente TTC TextFormField
                                  MyTextFormField(
                                    enabled: this.isEditMode,
                                    keyboardType: TextInputType.number,
                                    textEditingController:
                                        fieldControllers['prixVenteTTC'],
                                    prefixPadding: 10,
                                    prefixIcon: Icon(
                                      Icons.attach_money_rounded,
                                      color: Color.fromRGBO(231, 57, 0, 1),
                                    ),
                                    placeholder:
                                        "Prix de vente TTC de l'article",
                                    textColor: Color.fromRGBO(231, 57, 0, 1),
                                    placeholderColor:
                                        Color.fromRGBO(231, 57, 0, 1),
                                    fillColor:
                                        Color.fromRGBO(243, 156, 18, 0.15),
                                    borderRadius: Radius.circular(10),
                                    focusBorderColor: Colors.transparent,
                                    enableBorderColor: Colors.transparent,
                                    onChanged: (value) {
                                      // ? Compute the HT Price
                                      int prixVenteTTC = int.parse(value!);
                                      double prixVenteHT = prixVenteTTC /
                                          (1 + fieldControllers['tva']);
                                      fieldControllers['prixVenteHT'].text =
                                          prixVenteHT.toInt().toString();
                                      // ? Compute the Tolerance value
                                      if (value.isNotEmpty &&
                                          fieldControllers['prixAchatTTC']
                                              .text
                                              .isNotEmpty) {
                                        int prixAchatTTC = int.parse(
                                            fieldControllers['prixAchatTTC']
                                                .text);
                                        // ? Taux Marge Vente
                                        double tauxMargeVente =
                                            ((prixVenteTTC - prixAchatTTC) *
                                                (100 / prixVenteTTC));
                                        // ? Taux Marge Achat
                                        double tauxMargeAchat =
                                            ((prixVenteTTC - prixAchatTTC) *
                                                (100 / prixAchatTTC));
                                        // ? Update field
                                        fieldControllers['tauxMargeAchat']
                                                .text =
                                            tauxMargeAchat.toInt().toString() +
                                                '%';
                                        fieldControllers['tauxMargeVente']
                                                .text =
                                            tauxMargeVente.toInt().toString() +
                                                '%';
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
                                    textEditingController:
                                        fieldControllers['prixVenteHT'],
                                    prefixPadding: 10,
                                    prefixIcon: Icon(
                                      Icons.attach_money_rounded,
                                      color: Color.fromRGBO(231, 57, 0, 1),
                                    ),
                                    placeholder:
                                        "Prix de vente hors taxe de l'article",
                                    textColor: Color.fromRGBO(231, 57, 0, 1),
                                    placeholderColor:
                                        Color.fromRGBO(231, 57, 0, 1),
                                    fillColor:
                                        Color.fromRGBO(243, 156, 18, 0.15),
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
                                    textEditingController:
                                        fieldControllers['tauxMargeVente'],
                                    prefixPadding: 10,
                                    prefixIcon: Icon(
                                      Icons.circle,
                                      color: Color.fromRGBO(231, 57, 0, 1),
                                    ),
                                    placeholder: "Taux de marge sur la vente",
                                    textColor: Color.fromRGBO(231, 57, 0, 1),
                                    placeholderColor:
                                        Color.fromRGBO(231, 57, 0, 1),
                                    fillColor:
                                        Color.fromRGBO(243, 156, 18, 0.15),
                                    borderRadius: Radius.circular(10),
                                    focusBorderColor: Colors.transparent,
                                    enableBorderColor: Colors.transparent,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
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
                                  print('Article stockable = ' +
                                      value.toString());
                                  setState(() {
                                    fieldControllers['stockable'] = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          //color: Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            iconSize: 35.0,
            items: [
              //todo: Edit
              BottomNavigationBarItem(
                label: 'Modifier',
                backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                icon: (!this.isEditMode)
                    ? IconButton(
                        icon: Icon(
                          Icons.edit_rounded,
                          color: Color.fromRGBO(231, 57, 0, 1),
                          size: 30,
                        ),
                        onPressed: () {
                          if (!this.isEditMode) {
                            setState(() {
                              this.isEditMode = true;
                            });
                          }
                        },
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 30,
                        ),
                        onPressed: () async {
                          if (Article.article != null) {
                            if (formKey.currentState!.validate()) {
                              // ? sending datas to API
                              Article articleToUpdate = Article.article!;
                              final Map<String, dynamic> updateArticleResponse =
                                  await api.updateArticle(
                                article: Article.fromJson({
                                  'id': articleToUpdate.id,
                                  'code_barre': (fieldControllers['codeBarre']
                                          .text
                                          .isNotEmpty)
                                      ? fieldControllers['codeBarre'].text
                                      : '', // get code barre
                                  'description_article': fieldControllers[
                                          'description']
                                      .text, // get description // ! required
                                  'fournisseur':
                                      (fieldControllers['fournisseur'] != 0)
                                          ? [
                                              {
                                                'id': fieldControllers[
                                                    'fournisseur'],
                                              },
                                            ]
                                          : [], // get fournisseur
                                  'categorie': {
                                    'id': fieldControllers['categorie'],
                                  }, // get categorie // ! required
                                  'sous_categorie':
                                      (fieldControllers['sousCategorie'] != 0)
                                          ? {
                                              'id': fieldControllers[
                                                  'sousCategorie'],
                                            }
                                          : null, // get sousCategorie
                                  'stock_mini': (fieldControllers['stockMin']
                                          .text
                                          .isNotEmpty)
                                      ? int.parse(
                                          fieldControllers['stockMin'].text)
                                      : 0, // get stockMin
                                  'param_tva': {
                                    'id': fieldControllers['tva'],
                                  }, // get tva // ! required
                                  'prix_achat_ttc': int.parse(fieldControllers[
                                          'prixAchatTTC']
                                      .text), // get prixAchatTTC // ! required
                                  'prix_achat_ht': int.parse(
                                      fieldControllers['prixAchatHT']
                                          .text), // get prixAchatTTC
                                  'taux_airsi_achat':
                                      (fieldControllers['tauxMargeAchat']
                                              .text
                                              .isNotEmpty)
                                          ? int.parse(
                                              fieldControllers['tauxMargeAchat']
                                                  .text
                                                  .replaceAll('%', ''))
                                          : null, // get tauxMargeAchat
                                  'prix_vente_ttc_base': int.parse(
                                      fieldControllers['prixVenteTTC']
                                          .text), // get prixVenteTTC
                                  'prix_vente_ht': int.parse(
                                      fieldControllers['prixVenteHT']
                                          .text), // get prixVenteTTC
                                  'taux_airsi_vente':
                                      (fieldControllers['tauxMargeVente']
                                              .text
                                              .isNotEmpty)
                                          ? int.parse(
                                              fieldControllers['tauxMargeVente']
                                                  .text
                                                  .replaceAll('%', ''))
                                          : null, // get tauxMargeVente
                                  /*'image': fieldControllers['imageArticle']
                        .text, // get imageArticle*/
                                  'stockable': fieldControllers[
                                      'stockable'], // get stockable
                                }),
                              );
                              // ? check the server response
                              if (updateArticleResponse['msg'] ==
                                  'Modification effectuée avec succès.') {
                                // ? In Success case
                                Navigator.of(context).pop();
                                functions.showSuccessDialog(
                                  context: context,
                                  message: 'Modification réussie !',
                                );
                                // ? Reload page
                                setState(() {
                                  Article.article = Article.fromJson(
                                      updateArticleResponse['data']);
                                });
                              } else {
                                // ? In Error case
                                Navigator.of(context).pop();
                                functions.showErrorDialog(
                                  context: context,
                                  message: "Une erreur s'est produite",
                                );
                              }
                              // ? Refresh article list
                              setState(() {});
                            }
                          } else {
                            functions.showWarningDialog(
                              context: context,
                              message: "Choisissez d'abord un article",
                            );
                          }
                        },
                      ),
              ),
              //todo: Delete
              BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                icon: IconButton(
                  onPressed: () {
                    if (Article.article != null) {
                      // ? Show confirm dialog
                      functions.showConfirmationDialog(
                        context: context,
                        message:
                            'Voulez-vous vraiment supprimer le article : ' +
                                Article.article!.description +
                                ' ?',
                        onValidate: () async {
                          // ? sending delete request to API
                          Article articleToDelete = Article.article!;
                          final Map<String, dynamic> deleteArticleResponse =
                              await api.deleteArticle(
                            article: articleToDelete,
                          );
                          // ? check the server response
                          if (deleteArticleResponse['msg'] ==
                              'Opération effectuée avec succès.') {
                            // ? In Success case
                            Navigator.of(context).pop();
                            Article.article = null;
                            functions.showSuccessDialog(
                              context: context,
                              message: "L'article : " +
                                  articleToDelete.description +
                                  " a bien été supprimé !",
                            );
                          } else {
                            // ? In Error case
                            Navigator.of(context).pop();
                            functions.showErrorDialog(
                              context: context,
                              message: "Une erreur s'est produite",
                            );
                          }
                          // ? Refresh article list
                          setState(() {});
                        },
                      );
                    } else {
                      functions.showWarningDialog(
                        context: context,
                        message: "Choisissez d'abord un article",
                      );
                    }
                  },
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Color.fromRGBO(187, 0, 0, 1),
                    size: 30,
                  ),
                ),
                label: 'Supprimer',
              ),
              //todo: Reload
              BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                icon: IconButton(
                  onPressed: () {
                    // show refresh message
                    functions.showMessageToSnackbar(
                      context: context,
                      message: "Rechargement...",
                      icon: CircularProgressIndicator(
                        color: Color.fromRGBO(243, 156, 18, 1),
                        strokeWidth: 5,
                      ),
                    );
                    // ? Reset & reload
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                label: 'Recharger',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
