import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyAppBar.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyOutlinedIconButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextField.dart';
import 'package:smartsfv/views/layouts/DashboardGridViewLayout.dart';

class ClientScreen extends StatefulWidget {
  final SlidingUpPanelController panelController;
  ClientScreen({Key? key, required this.panelController}) : super(key: key);
  @override
  ClientScreenState createState() => ClientScreenState();
}

class ClientScreenState extends State<ClientScreen> {
  ScrollController scrollController = new ScrollController();
  ScrollController gridViewScrollController = new ScrollController();
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
                  icon: 'assets/img/icons/customer.png',
                  iconColor: Color.fromRGBO(60, 141, 188, 1),
                  title: 'Clients',
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
                            placeholder: 'Rechercher un client',
                            cursorColor: Colors.white,
                            textColor: Colors.white,
                            enableBorderColor: Colors.transparent,
                            focusBorderColor: Colors.transparent,
                            fillColor: Colors.black.withOpacity(1),
                            suffixIcon: MyOutlinedIconButton(
                              backgroundColor: Colors.white,
                              borderColor: Colors.transparent,
                              borderRadius: 15,
                              icon: Icon(
                                Icons.search,
                                color: Color.fromRGBO(60, 141, 188, 1),
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
                                        'assets/img/icons/countries.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.contain,
                                        color: Color.fromRGBO(0, 27, 121, 1),
                                      ),
                                      SizedBox(width: 15),
                                      MyText(
                                        text: 'Pays',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(0, 27, 121, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                MyOutlinedButton(
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
                                        'assets/img/icons/countries.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.contain,
                                        color: Color.fromRGBO(0, 27, 121, 1),
                                      ),
                                      SizedBox(width: 15),
                                      MyText(
                                        text: 'Filtres',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(0, 27, 121, 1),
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }
}
