import 'package:delayed_display/delayed_display.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/controllers/MyExpandableController.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';
import 'package:smart_sfv_mobile/views/components/MyDrawerTile.dart';
import 'package:smart_sfv_mobile/views/components/MyText.dart';

class DrawerExpandableBox extends StatefulWidget {
  final String icon;
  final String headerText;
  final ExpandableController expandableController;
  final List<List<String>> expandedElements;
  DrawerExpandableBox({
    Key? key,
    required this.icon,
    required this.headerText,
    required this.expandableController,
    required this.expandedElements,
  }) : super(key: key);
  @override
  DrawerExpandableBoxState createState() => DrawerExpandableBoxState();
}

class DrawerExpandableBoxState extends State<DrawerExpandableBox> {
  // Scroll controller
  ScrollController scrollController = ScrollController();
// Expandable Controller
  ExpandableController expandableController = ExpandableController();
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
// Expandable Controller
    /*ExpandableController? expandableController =
        MyExpandableController.expandableControllers[widget.headerText];*/
    return DelayedDisplay(
      delay: Duration(seconds: 2),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            widget.expandableController.addListener(() {});
          },
          child: ExpandablePanel(
            controller: expandableController,
            theme: ExpandableThemeData(
              iconColor: Color.fromRGBO(1, 21, 122, 1),
            ),
            header: Container(
              width: screenSize[0],
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.icon,
                      color: Color.fromRGBO(1, 21, 122, 1),
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 10),
                    MyText(
                      text: widget.headerText,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
            // <-- Driven by ExpandableController from ExpandableNotifier
            //todo: Collapsed Box
            collapsed: Container(),
            //todo: Expanded Box
            expanded: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        width: screenSize[0],
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 77, 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 50),
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (var element in widget.expandedElements)
                                  MyDrawerTile(
                                    icon: (element.length == 2)
                                        ? element[0]
                                        : 'assets/img/icons/button.png',
                                    headerText: (element.length == 2)
                                        ? element[1]
                                        : element[0],
                                    headerTextSize: 16,
                                    iconSize: 30,
                                    breakSpace: 2,
                                  ),
                              ],
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
    );
  }
}
