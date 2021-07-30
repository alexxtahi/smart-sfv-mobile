import 'package:expandable/expandable.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';
import 'package:smart_sfv_mobile/views/components/MyDataTable.dart';

class MyExpandableBox extends StatefulWidget {
  final String headerText;
  MyExpandableBox({
    Key? key,
    required this.headerText,
  }) : super(key: key);
  @override
  MyExpandableBoxState createState() => MyExpandableBoxState();
}

class MyExpandableBoxState extends State<MyExpandableBox> {
  // Scroll controller
  ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);

    return Card(
      elevation: 5,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Expandable(
        // <-- Driven by ExpandableController from ExpandableNotifier
        //todo: Collapsed Box
        collapsed: ExpandableButton(
          // <-- Expands when tapped on the cover photo
          child: Container(
            width: screenSize[0],
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      widget.headerText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
        //todo: Expanded Box
        expanded: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      //todo: Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              widget.headerText,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ExpandableButton(
                            // <-- Collapses when tapped on
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
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
                          child: MyDataTable(
                            columns: [
                              'Dépôt',
                              'Article',
                              'lot',
                              'Date de péremption',
                              'Sera périmé dans',
                            ],
                            rows: [
                              [
                                '14',
                                'Sac à main',
                                '18n47b',
                                '23/09/2021',
                                '45 jours'
                              ],
                              [
                                '14',
                                'Sac à main',
                                '18n47b',
                                '23/09/2021',
                                '45 jours'
                              ],
                              [
                                '14',
                                'Sac à main',
                                '18n47b',
                                '23/09/2021',
                                '45 jours'
                              ],
                            ],
                          ),
                        ),
                      ),
                      //todo: See more button
                      /*ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          //todo: Text
                          Text(
                            'Voir plus',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width: 5),
                          //todo: Icon
                          Image.asset(
                            'assets/img/icons/previous.png',
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(60, 141, 188, 1)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),*/
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
