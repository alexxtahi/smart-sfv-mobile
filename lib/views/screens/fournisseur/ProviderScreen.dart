import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyAppBar.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyOutlinedIconButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextField.dart';

class ProviderScreen extends StatefulWidget {
  final SlidingUpPanelController panelController;
  ProviderScreen({Key? key, required this.panelController}) : super(key: key);
  @override
  ProviderScreenState createState() => ProviderScreenState();
}

class ProviderScreenState extends State<ProviderScreen> {
  ScrollController scrollController = new ScrollController();
  ScrollController datatableScrollController = new ScrollController();
  TextEditingController textEditingController = TextEditingController();
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
                  icon: 'assets/img/icons/provider.png',
                  iconColor: Color.fromRGBO(221, 75, 57, 1),
                  title: 'Fournisseurs',
                ),
                SizedBox(height: 20),
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
                          //todo: Search Bar
                          MyTextField(
                            focusNode: FocusNode(),
                            textEditingController: this.textEditingController,
                            borderRadius: Radius.circular(20),
                            placeholder: 'Rechercher un fournisseur',
                            placeholderColor: Colors.black,
                            cursorColor: Colors.black,
                            textColor: Colors.black,
                            enableBorderColor: Colors.transparent,
                            focusBorderColor: Colors.transparent,
                            fillColor: Color.fromRGBO(221, 75, 57, 0.15),
                            suffixIcon: MyOutlinedIconButton(
                              onPressed: () {},
                              backgroundColor: Colors.white,
                              borderColor: Colors.transparent,
                              borderRadius: 15,
                              icon: Icon(
                                Icons.search,
                                color: Color.fromRGBO(187, 0, 0, 1),
                                size: 40,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          //todo: Countries & Filters
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: screenSize[0]),
                            child: GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              childAspectRatio: 4,
                              crossAxisSpacing: 10,
                              children: [
                                MyOutlinedButton(
                                  onPressed: () {},
                                  backgroundColor:
                                      Color.fromRGBO(221, 75, 57, 0.15),
                                  borderRadius: 15,
                                  borderColor: Colors.transparent,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/img/icons/australia.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.contain,
                                        color: Color.fromRGBO(187, 0, 0, 1),
                                      ),
                                      SizedBox(width: 15),
                                      MyText(
                                        text: 'Pays',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(187, 0, 0, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                MyOutlinedButton(
                                  onPressed: () {},
                                  backgroundColor:
                                      Color.fromRGBO(221, 75, 57, 0.15),
                                  borderRadius: 15,
                                  borderColor: Colors.transparent,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/img/icons/filter.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.contain,
                                        color: Color.fromRGBO(187, 0, 0, 1),
                                      ),
                                      SizedBox(width: 15),
                                      MyText(
                                        text: 'Filtres',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(187, 0, 0, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
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
                                        'Code',
                                        'Nom du fournisseur',
                                        'Contact',
                                        'Pays',
                                        'Banque',
                                        'Compte banque',
                                        'E-mail',
                                        'Boîte postale',
                                        'Adresse',
                                        'Fax',
                                        'Compte contr.'
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
