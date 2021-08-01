import 'package:delayed_display/delayed_display.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';
import 'package:smart_sfv_mobile/views/components/MyDrawerTile.dart';
import 'package:smart_sfv_mobile/views/components/MyText.dart';

class DrawerExpandableBox extends StatefulWidget {
  final String icon;
  final String headerText;
  final List<List<String>> expandedElements;
  DrawerExpandableBox({
    Key? key,
    required this.icon,
    required this.headerText,
    required this.expandedElements,
  }) : super(key: key);
  @override
  DrawerExpandableBoxState createState() => DrawerExpandableBoxState();
}

class DrawerExpandableBoxState extends State<DrawerExpandableBox> {
  // Scroll controller
  ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);

    return DelayedDisplay(
      delay: Duration(seconds: 2),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: ExpandablePanel(
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
                  ),
                  SizedBox(width: 10),
                  MyText(
                    text: widget.headerText,
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  /*Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: Color.fromRGBO(1, 21, 122, 1),
                  ),*/
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
                child: Container(
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
                              icon: element[0],
                              headerText: element[1],
                              headerTextSize: 16,
                              iconSize: 30,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
