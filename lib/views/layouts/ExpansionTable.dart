import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';

class ExpansionTable extends StatefulWidget {
  final String headerText;
  ExpansionTable({
    Key? key,
    required this.headerText,
  }) : super(key: key);
  @override
  ExpansionTableState createState() => ExpansionTableState();
}

class ExpansionTableState extends State<ExpansionTable> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  // textfield controller
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);

    // Return building scaffold
    return ExpandableNotifier(
      // <-- Provides ExpandableController to its children
      child: Column(
        children: [
          Expandable(
            // <-- Driven by ExpandableController from ExpandableNotifier
            collapsed: ExpandableButton(
              // <-- Expands when tapped on the cover photo
              child: Container(
                width: screenSize[0],
                height: 150,
                color: Colors.red,
              ),
            ),
            expanded: Column(children: [
              Container(
                width: screenSize[0],
                height: 150,
                color: Colors.green,
              ),
              ExpandableButton(
                // <-- Collapses when tapped on
                child: Text(
                  "Back",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
    /*ExpandablePanel(
      header: Text(
        widget.headerText,
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      collapsed: Text(
        'COLAPSED',
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      expanded: Text(
        'EXPANDED',
        softWrap: true,
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      theme: ExpandableThemeData(
        hasIcon: true,
        iconColor: Colors.black,
        //expandIcon: IconData(0),
        //collapseIcon: IconData(1),
      ),
    );*/
  }
}
