import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smart_sfv_mobile/controllers/DrawerLayoutController.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';
import 'package:smart_sfv_mobile/views/components/DashboardCard.dart';
import 'package:smart_sfv_mobile/views/components/MyAppBar.dart';
import 'package:smart_sfv_mobile/views/layouts/ExpansionTable.dart';

class DashboardScreen extends StatefulWidget {
  final SlidingUpPanelController panelController;
  DashboardScreen({Key? key, required this.panelController}) : super(key: key);
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  ScrollController scrollController = new ScrollController();
  //todo: setState function for the childrens
  void callback(Function childSetState) {
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
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        backgroundColor: (DrawerLayoutController.isDrawerOpen)
            ? Colors.transparent // color when the drawer is open
            : Color.fromRGBO(
                251, 251, 251, 1), // color when the drawer is close
        body: Container(
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
                    parentSetState: callback,
                    panelController: widget.panelController,
                  ),
                  SizedBox(height: 20),
                  //todo: Scrolling View
                  Expanded(
                    child: Stack(
                      children: [
                        FadingEdgeScrollView.fromSingleChildScrollView(
                          gradientFractionOnStart: 0.05,
                          gradientFractionOnEnd: 0.2,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                //todo: Dashboard
                                Container(
                                  width: screenSize[0],
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: [
                                      DashboardCard(
                                        text: 'Clients',
                                        icon: 'assets/img/icons/customer1.png',
                                        iconColor:
                                            Color.fromRGBO(0, 27, 121, 1),
                                      ),
                                      DashboardCard(
                                        text: 'Articles',
                                        icon: 'assets/img/icons/box.png',
                                        iconColor:
                                            Color.fromRGBO(231, 57, 0, 1),
                                        backgroundColor:
                                            Color.fromRGBO(243, 156, 18, 1),
                                      ),
                                      DashboardCard(
                                        text: 'Dépôts',
                                        icon: 'assets/img/icons/bank.png',
                                        iconColor: Color.fromRGBO(0, 77, 0, 1),
                                        backgroundColor:
                                            Color.fromRGBO(0, 166, 90, 1),
                                      ),
                                      DashboardCard(
                                        text: 'Fournisseurs',
                                        icon: 'assets/img/icons/provider.png',
                                        iconColor: Color.fromRGBO(187, 0, 0, 1),
                                        backgroundColor:
                                            Color.fromRGBO(221, 75, 57, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                //todo: Tables
                                ExpansionTable(),
                              ],
                            ),
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
      ),
    );
  }
}
