import 'package:expandable/expandable.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/views/components/DrawerExpandableBox.dart';
import 'package:smart_sfv_mobile/views/components/MyDataTable.dart';
import 'package:smart_sfv_mobile/views/components/MyExpandableBox.dart';

class DrawerTileLayout extends StatefulWidget {
  DrawerTileLayout({
    Key? key,
  }) : super(key: key);
  @override
  DrawerTileLayoutState createState() => DrawerTileLayoutState();
}

class DrawerTileLayoutState extends State<DrawerTileLayout> {
  ScrollController scrollController = ScrollController();
  ExpandableController expandableController = ExpandableController();
  @override
  Widget build(BuildContext context) {
    // Return building scaffold
    return Expanded(
      child: FadingEdgeScrollView.fromSingleChildScrollView(
        gradientFractionOnStart: 0.1,
        gradientFractionOnEnd: 0.1,
        child: SingleChildScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: ExpandableNotifier(
            controller: expandableController,
            // <-- Provides ExpandableController to its children
            child: Column(
              children: [
                DrawerExpandableBox(
                  icon: 'Caisses ouvertes',
                  headerText: 'Caisses ouvertes',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
