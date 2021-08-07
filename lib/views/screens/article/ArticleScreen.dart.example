import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyAppBar.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyOutlinedIconButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextField.dart';
import 'package:smartsfv/functions.dart' as functions;

class ArticleScreen extends StatefulWidget {
  final SlidingUpPanelController panelController;
  ArticleScreen({Key? key, required this.panelController}) : super(key: key);
  @override
  ArticleScreenState createState() => ArticleScreenState();
}

class ArticleScreenState extends State<ArticleScreen> {
  ScrollController scrollController = new ScrollController();
  ScrollController datatableScrollController = new ScrollController();
  TextEditingController textEditingController = TextEditingController();
  String searchBy = 'Par nom';
  String searchByIcon = 'sort-az';
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
    // Return building scaffold
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
                  },
                  suffixIcon: MyOutlinedIconButton(
                    onPressed: () {
                      // dismiss keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
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
                      MyComboBox(
                        initialDropDownValue: 'Catégories',
                        initialDropDownList: [
                          'Catégories',
                          for (var i = 1; i <= 10; i++) 'Catégorie $i',
                        ],
                        //textOverflow: TextOverflow.visible,
                        prefixPadding: 10,
                        prefixIcon: Image.asset(
                          'assets/img/icons/category.png',
                          fit: BoxFit.contain,
                          width: 20,
                          height: 20,
                          color: Color.fromRGBO(231, 57, 0, 1),
                        ),
                        iconSize: 0,
                        textFontSize: 10,
                        textColor: Color.fromRGBO(231, 57, 0, 1),
                        textFontWeight: FontWeight.bold,
                        fillColor: Color.fromRGBO(243, 156, 18, 0.15),
                        borderRadius: Radius.circular(15),
                        focusBorderColor: Colors.transparent,
                        enableBorderColor: Colors.transparent,
                      ),
                      //todo: Filtres Button
                      MyOutlinedButton(
                        onPressed: () {
                          print('Filtre appuyé !');
                          functions.showFormDialog(
                            context,
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
                SizedBox(height: 10),
                //todo: Scrolling View
                Expanded(
                  child: FadingEdgeScrollView.fromSingleChildScrollView(
                    gradientFractionOnStart: 0.05,
                    gradientFractionOnEnd: 0.2,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          //todo: Table
                          Row(
                            children: [
                              Expanded(
                                child: FadingEdgeScrollView
                                    .fromSingleChildScrollView(
                                  gradientFractionOnStart: 0.2,
                                  gradientFractionOnEnd: 0.2,
                                  child: SingleChildScrollView(
                                    controller: datatableScrollController,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: MyDataTable(
                                      columns: [
                                        'Code barre',
                                        'Article',
                                        'Catégorie',
                                        'En stock',
                                        "Prix d'achat TTC",
                                        "Prix d'achat HT",
                                        "Prix de vente TTC",
                                        "Prix de vente HT",
                                        'Fournisseur(s)',
                                        'TVA',
                                        'Stock minimum',
                                      ],
                                      rows: [
                                        for (var i = 1; i < 100; i++)
                                          [
                                            '1',
                                            'Alexandre TAHI',
                                            '+225 05 84 64 98 25',
                                            "Côte d'ivoire",
                                            'Bio',
                                            'alexandretahi7@gmail.com',
                                            'Yopougon, Lièvre Rouge',
                                            '45.000.000 FCFA',
                                            'Compte001',
                                            'Compte001',
                                            'Compte001',
                                          ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
