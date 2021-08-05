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
import 'package:smartsfv/controllers/functions.dart' as functions;

class CommandeScreen extends StatefulWidget {
  final SlidingUpPanelController panelController;
  CommandeScreen({Key? key, required this.panelController}) : super(key: key);
  @override
  CommandeScreenState createState() => CommandeScreenState();
}

class CommandeScreenState extends State<CommandeScreen> {
  ScrollController scrollController = new ScrollController();
  ScrollController datatableScrollController = new ScrollController();
  TextEditingController textEditingController = TextEditingController();
  String searchBy = 'Par N° de bon';
  String searchByIcon = 'code';
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
          borderRadius: BorderRadius.circular(20),
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
                  icon: 'assets/img/icons/shopping-cart.png',
                  iconColor: Color.fromRGBO(0, 27, 121, 1),
                  title: 'Commandes',
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
                            placeholder: 'Rechercher une commande',
                            placeholderColor: Colors.black,
                            cursorColor: Colors.black,
                            textColor: Colors.black,
                            enableBorderColor: Colors.transparent,
                            focusBorderColor: Colors.transparent,
                            fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                            suffixIcon: MyOutlinedIconButton(
                              onPressed: () {},
                              backgroundColor: Colors.white,
                              borderColor: Colors.transparent,
                              borderRadius: 15,
                              icon: Icon(
                                Icons.search,
                                color: Color.fromRGBO(0, 27, 121, 1),
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
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              childAspectRatio: 3,
                              crossAxisSpacing: 10,
                              children: [
                                MyOutlinedButton(
                                  onPressed: () {},
                                  backgroundColor:
                                      Color.fromRGBO(0, 27, 121, 1),
                                  borderRadius: 15,
                                  borderColor: Colors.transparent,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/img/icons/provider.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 15),
                                      Flexible(
                                        child: MyText(
                                          text: 'Fournisseurs',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                MyOutlinedButton(
                                  onPressed: () {},
                                  backgroundColor:
                                      Color.fromRGBO(0, 27, 121, 1),
                                  borderRadius: 15,
                                  borderColor: Colors.transparent,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/img/icons/filter.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 15),
                                      MyText(
                                        text: 'Filtres',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                MyOutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (this.searchBy == 'Par N° de bon') {
                                        this.searchBy = 'Par date';
                                        this.searchByIcon = 'calendar';
                                      } else {
                                        this.searchBy = 'Par N° de bon';
                                        this.searchByIcon = 'code';
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
                                              TextSpan(
                                                  text:
                                                      'Recherche des commandes '),
                                              TextSpan(
                                                text:
                                                    this.searchBy.toLowerCase(),
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      60, 141, 188, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        duration: 5,
                                        icon: Icon(
                                          Icons.info,
                                          color:
                                              Color.fromRGBO(60, 141, 188, 1),
                                        ),
                                      );
                                      print('Recherche: ' + this.searchBy);
                                    });
                                  },
                                  backgroundColor:
                                      Color.fromRGBO(60, 141, 188, 0.15),
                                  borderRadius: 15,
                                  borderColor: Colors.transparent,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/img/icons/$searchByIcon.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                        color: Color.fromRGBO(0, 27, 121, 1),
                                      ),
                                      SizedBox(width: 15),
                                      Flexible(
                                        child: MyText(
                                          text: this.searchBy,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(0, 27, 121, 1),
                                        ),
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
                                        'Bon',
                                        'Date',
                                        'N° bon de commande',
                                        'Fournisseur',
                                        'Montant total',
                                      ],
                                      rows: [
                                        for (var i = 1; i < 100; i++)
                                          [
                                            '1',
                                            'Alexandre TAHI',
                                            '+225 05 84 64 98 25',
                                            "Côte d'ivoire",
                                            'Bio',
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
