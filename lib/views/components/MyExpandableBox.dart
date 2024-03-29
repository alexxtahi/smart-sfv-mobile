import 'package:delayed_display/delayed_display.dart';
import 'package:expandable/expandable.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyText.dart';

class MyExpandableBox extends StatefulWidget {
  final String headerText;
  final Widget table;
  final String seeMoreBtnText;
  final Icon seeMoreBtnIcon;
  final Function()? seeMoreBtn;
  MyExpandableBox({
    Key? key,
    required this.headerText,
    required this.table,
    this.seeMoreBtn,
    this.seeMoreBtnIcon = const Icon(
      Icons.print_rounded,
      color: Colors.white,
    ),
    this.seeMoreBtnText = 'Voir plus',
  }) : super(key: key);
  @override
  MyExpandableBoxState createState() => MyExpandableBoxState();
}

class MyExpandableBoxState extends State<MyExpandableBox> {
  // Scroll controller
  ScrollController scrollController = new ScrollController();
  // Expandable controller
  ExpandableController expandableController = new ExpandableController();
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);

    return DelayedDisplay(
      delay: Duration(seconds: 1),
      child: Card(
        elevation: 5,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: screenSize[0],
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ExpandablePanel(
                  controller: expandableController,
                  theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    iconPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                  ),
                  header: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Flexible(
                          child: MyText(
                            text: widget.headerText,
                            color: Colors.black,
                            fontSize: 16,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //todo: Collapsed Box
                  collapsed: Container(),
                  //todo: Expanded Box
                  expanded: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              //todo: Separator
                              SizedBox(
                                width: screenSize[0],
                                height: 2,
                                child: Container(
                                  color: Color.fromRGBO(60, 141, 188, 1),
                                ),
                              ),
                              //todo: Content
                              FadingEdgeScrollView.fromSingleChildScrollView(
                                gradientFractionOnStart: 0.2,
                                gradientFractionOnEnd: 0.2,
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: widget.table,
                                ),
                              ),
                              //todo: See more button
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 5,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: widget.seeMoreBtn,
                                      child: Row(
                                        children: [
                                          //todo: Text
                                          MyText(
                                            text: widget.seeMoreBtnText,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12,
                                          ),
                                          SizedBox(width: 5),
                                          //todo: Icon
                                          (widget.seeMoreBtnText != 'Voir plus')
                                              ? widget.seeMoreBtnIcon
                                              : Image.asset(
                                                  'assets/img/icons/previous.png',
                                                  width: 20,
                                                  height: 20,
                                                  fit: BoxFit.contain,
                                                  color: Colors.white,
                                                ),
                                        ],
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromRGBO(
                                                    60, 141, 188, 1)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
