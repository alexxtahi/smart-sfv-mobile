import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';

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
  // textfield controller
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);

    // Return building scaffold
    return Card(
      elevation: 5,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Expandable(
        // <-- Driven by ExpandableController from ExpandableNotifier
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
                    Icons.add_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
        expanded: Container(
          width: screenSize[0],
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Icons.minimize_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
