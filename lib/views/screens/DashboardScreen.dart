import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/views/components/MyAppBar.dart';
import 'package:smartsfv/views/layouts/DashboardGridViewLayout.dart';
import 'package:smartsfv/views/layouts/ExpansionTable.dart';

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
    );
  }
}