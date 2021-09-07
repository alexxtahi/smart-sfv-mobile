import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Categorie.dart';
import 'package:smartsfv/models/Research.dart';
import 'package:smartsfv/views/components/MyAppBar.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyOutlinedIconButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextField.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/views/screens/article/ArticleFutureBuilder.dart';

class ArticleScreen extends StatefulWidget {
  final SlidingUpPanelController panelController;
  ArticleScreen({Key? key, required this.panelController}) : super(key: key);
  @override
  ArticleScreenState createState() => ArticleScreenState();
}

class ArticleScreenState extends State<ArticleScreen> {
  TextEditingController textEditingController = TextEditingController();
  String searchBy = 'Par nom';
  String searchByIcon = 'sort-az';
  Map<String, String> research = {}; // var to save user reasearch
  // init API instance
  Api api = Api();
  //todo: setState function for the childrens
  void setstate(Function childSetState) {
    /*
    * This function is made to set state of this widget by this childrens
    */
    setState(() {
      childSetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    return AnimatedContainer(
      transform: Matrix4.translationValues(
          DrawerLayoutController.xOffset, DrawerLayoutController.yOffset, 0)
        ..scale(DrawerLayoutController.scaleFactor),
      duration: Duration(milliseconds: 250),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(251, 251, 251, 1),
          borderRadius: DrawerLayoutController.borderRadius,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                //todo: AppBar
                MyAppBar(
                  parentSetState: setstate,
                  panelController: widget.panelController,
                  icon: 'assets/img/icons/box.png',
                  iconColor: Color.fromRGBO(243, 156, 18, 1),
                  title: 'Articles',
                ),
                SizedBox(height: 20),
                //todo: Search Bar
                MyTextField(
                  keyboardType: TextInputType.text,
                  focusNode: FocusNode(),
                  textEditingController: this.textEditingController,
                  borderRadius: Radius.circular(20),
                  placeholder: 'Rechercher un article',
                  placeholderColor: Color.fromRGBO(231, 57, 0, 1),
                  cursorColor: Colors.black,
                  textColor: Color.fromRGBO(231, 57, 0, 1),
                  enableBorderColor: Colors.transparent,
                  focusBorderColor: Colors.transparent,
                  fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                  onSubmitted: (text) {
                    // dismiss keyboard
                    FocusScope.of(context).requestFocus(FocusNode());
                    // ? Check if the field is empty or not
                    setState(() {
                      if (this.textEditingController.text.isEmpty)
                        Research.reset(); // Reset last research datas
                      else
                        // launch research
                        Research.find(
                            'Article', this.textEditingController.text,
                            searchBy: this.searchBy);
                    });
                  },
                  onChanged: (text) {
                    // ? Check if the field is empty or not
                    setState(() {
                      if (this.textEditingController.text.isEmpty)
                        Research.reset(); // Reset last research datas
                      else
                        // launch research
                        Research.find(
                            'Article', this.textEditingController.text,
                            searchBy: this.searchBy);
                    });
                  },
                  //todo: Research button
                  suffixIcon: MyOutlinedIconButton(
                    onPressed: () {
                      // ? Show reloading message
                      functions.showMessageToSnackbar(
                        context: context,
                        message: "Recherche...",
                        icon: CircularProgressIndicator(
                          color: Color.fromRGBO(60, 141, 188, 1),
                          backgroundColor: Colors.white.withOpacity(0.1),
                          strokeWidth: 5,
                        ),
                      );
                      // dismiss keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                      // ? Check if the field is empty or not
                      setState(() {
                        if (this.textEditingController.text.isEmpty)
                          Research.reset(); // Reset last research datas
                        else
                          // launch research
                          Research.find(
                              'Article', this.textEditingController.text,
                              searchBy: this.searchBy);
                      });
                    },
                    backgroundColor: Colors.white,
                    borderColor: Colors.transparent,
                    borderRadius: 15,
                    icon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(243, 156, 18, 1),
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //todo: Countries & Filters
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenSize[0]),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    childAspectRatio: 3,
                    crossAxisSpacing: 10,
                    children: [
                      //todo: Catégories DropDown
                      (ScreenController.actualView != "LoginView")
                          ? FutureBuilder<List<Categorie>>(
                              future: api.getCategories(context),
                              builder: (comboBoxContext, snapshot) {
                                if (snapshot.hasData) {
                                  // ? get nations datas from server
                                  return MyComboBox(
                                    initialDropDownValue: 'Catégories',
                                    initialDropDownList: [
                                      'Catégories',
                                      // ? datas integration
                                      for (var categorie in snapshot.data!)
                                        categorie.libelle,
                                    ],
                                    // ? On item selected function
                                    onItemSelected: (categorie) {
                                      print("Catégorie -> $categorie");
                                      // ? Check if the field is empty or not
                                      setState(() {
                                        if (categorie == 'Catégorie' ||
                                            categorie == null)
                                          Research
                                              .reset(); // Reset last research datas
                                        else
                                          // launch research
                                          Research.find(
                                            'Article',
                                            categorie,
                                            searchBy: 'Categorie',
                                          );
                                      });
                                    },
                                    iconSize: 0,
                                    textFontSize: 10,
                                    prefixPadding: 10,
                                    prefixIcon: Image.asset(
                                      'assets/img/icons/category.png',
                                      fit: BoxFit.contain,
                                      width: 20,
                                      height: 20,
                                      color: Color.fromRGBO(231, 57, 0, 1),
                                    ),
                                    textColor: Color.fromRGBO(231, 57, 0, 1),
                                    textFontWeight: FontWeight.bold,
                                    fillColor:
                                        Color.fromRGBO(243, 156, 18, 0.15),
                                    borderRadius: Radius.circular(15),
                                    focusBorderColor: Colors.transparent,
                                    enableBorderColor: Colors.transparent,
                                  );
                                } else if (snapshot.hasError) {
                                  functions.errorSnackbar(
                                    context: context,
                                    message:
                                        'Echec de récupération des catégories',
                                  );
                                  return MyText(
                                    text: snapshot.error.toString(),
                                    color: Color.fromRGBO(60, 141, 188, 0.5),
                                  );
                                }
                                // ? on wait the combo with data load empty combo
                                return MyOutlinedButton(
                                  backgroundColor:
                                      Color.fromRGBO(243, 156, 18, 0.15),
                                  borderRadius: 15,
                                  borderColor: Colors.transparent,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/img/icons/category.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.contain,
                                        color: Color.fromRGBO(231, 57, 0, 1),
                                      ),
                                      SizedBox(width: 15),
                                      MyText(
                                        text: 'Catégories',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(231, 57, 0, 1),
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Container(),
                      //todo: Filtres Button
                      MyOutlinedButton(
                        onPressed: () {
                          print('Filtre appuyé !');
                          GlobalKey<FormState> formKey = GlobalKey<FormState>();
                          functions.showFormDialog(
                            context,
                            formKey,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            hasCancelButton: false,
                            hasSnackbar: false,
                            headerIcon: 'assets/img/icons/filter.png',
                            title: 'Filtres',
                            formElements: [
                              for (var i = 0; i < 10; i++)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(text: 'Filtre $i'),
                                    Checkbox(
                                      value: true,
                                      checkColor: Colors.blue,
                                      onChanged: (checked) {
                                        print(checked);
                                      },
                                    ),
                                  ],
                                ),
                            ],
                          );
                        },
                        backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                        borderRadius: 15,
                        borderColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/icons/filter.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                              color: Color.fromRGBO(231, 57, 0, 1),
                            ),
                            SizedBox(width: 15),
                            Flexible(
                              child: MyText(
                                overflow: TextOverflow.visible,
                                text: 'Filtres',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(231, 57, 0, 1),
                              ),
                            ),
                          ],
                        ),
                      ),

                      MyOutlinedButton(
                        onPressed: () {
                          setState(() {
                            if (this.searchBy == 'Par nom') {
                              this.searchBy = 'Par code barre';
                              this.searchByIcon = 'barcode';
                            } else {
                              this.searchBy = 'Par nom';
                              this.searchByIcon = 'sort-az';
                            }
                            functions.showMessageToSnackbar(
                              context: context,
                              message: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(text: 'Recherche des articles '),
                                    TextSpan(
                                      text: this.searchBy.toLowerCase(),
                                      style: TextStyle(
                                        color: Color.fromRGBO(231, 57, 0, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              duration: 5,
                              icon: Icon(
                                Icons.info,
                                color: Color.fromRGBO(231, 57, 0, 1),
                              ),
                            );
                            print('Recherche: ' + this.searchBy);
                          });
                        },
                        backgroundColor: Color.fromRGBO(231, 57, 0, 1),
                        borderRadius: 15,
                        borderColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/icons/$searchByIcon.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                              color: Colors.white,
                            ),
                            SizedBox(width: 15),
                            Flexible(
                              child: MyText(
                                text: this.searchBy,
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //todo: List title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //todo: Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Color.fromRGBO(231, 57, 0, 1),
                        ),
                        SizedBox(width: 10),
                        MyText(
                          text: 'Liste des articles',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(231, 57, 0, 1),
                        ),
                      ],
                    ),
                    //todo: Reload button
                    IconButton(
                      splashColor: Color.fromRGBO(243, 156, 18, 0.15),
                      tooltip: 'Actualiser',
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.refresh_rounded,
                        color: Color.fromRGBO(231, 57, 0, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                //todo: Scrolling View
                ArticleFutureBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
