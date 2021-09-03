import 'package:delayed_display/delayed_display.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyAppBar.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/layouts/DashboardGridViewLayout.dart';
import 'package:smartsfv/views/layouts/ExpansionTable.dart';
import 'package:smartsfv/functions.dart' as functions;

class DashboardScreen extends StatefulWidget {
  final SlidingUpPanelController panelController;
  DashboardScreen({Key? key, required this.panelController}) : super(key: key);
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  ScrollController scrollController = new ScrollController();
  ScrollController gridViewScrollController = new ScrollController();

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
    return GestureDetector(
      // ? Open or close drawer function of the gesture
      onHorizontalDragUpdate: (DragUpdateDetails drag) {
        int sensitivity = 8;
        setState(() {
          if (drag.delta.dx > sensitivity)
            DrawerLayoutController.open(context);
          else if (drag.delta.dx < sensitivity) DrawerLayoutController.close();
        });
      },
      child: AnimatedContainer(
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
                                DashboardGridViewLayout(
                                  elementsPerLine: 2,
                                  gridViewScrollController:
                                      this.gridViewScrollController,
                                  childAspectRatio: 1.25,
                                ),
                                SizedBox(height: 0),
                                //todo Reload button
                                DelayedDisplay(
                                  delay: Duration(milliseconds: 500),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //todo Title
                                        MyText(
                                          text: 'Tableau de bord',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        //todo Button
                                        InkWell(
                                          onTap: () {
                                            ScreenController.reloadDashboard =
                                                true;
                                            // ? Show reloading message
                                            functions.showMessageToSnackbar(
                                              context: context,
                                              message:
                                                  "Actualisation du tableau de bord...",
                                              icon: CircularProgressIndicator(
                                                color: Color.fromRGBO(
                                                    60, 141, 188, 1),
                                                backgroundColor: Colors.white
                                                    .withOpacity(0.1),
                                                strokeWidth: 5,
                                              ),
                                            );
                                            // ? Reload dashboard
                                            setState(() {});
                                          },
                                          child: Chip(
                                            backgroundColor: Color.fromRGBO(
                                                60, 141, 188, 0.15),
                                            label: MyText(
                                              text: 'Actualiser',
                                              color:
                                                  Color.fromRGBO(0, 27, 121, 1),
                                            ),
                                            avatar: Icon(
                                              Icons.refresh_rounded,
                                              color:
                                                  Color.fromRGBO(0, 27, 121, 1),
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 0),
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
