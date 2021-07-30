import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/views/components/MyExpandableBox.dart';

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
  // textfield controller
  @override
  Widget build(BuildContext context) {
    // Return building scaffold
    return ExpandableNotifier(
      // <-- Provides ExpandableController to its children
      child: Column(
        children: [
          MyExpandableBox(headerText: 'Caisses ouvertes'),
          MyExpandableBox(headerText: 'Articles en voie de péremption'),
          MyExpandableBox(headerText: 'Articles en voie de rupture'),
          MyExpandableBox(headerText: 'Liste des 5 meilleurs clients'),
          MyExpandableBox(
              headerText: 'Liste des 5 clients les moins rentables'),
          MyExpandableBox(headerText: 'Liste des 5 articles les plus vendus'),
          MyExpandableBox(headerText: 'Liste des 5 articles les moins vendus'),
          MyExpandableBox(headerText: 'Liste des 5 clients les plus endettés'),
          MyExpandableBox(headerText: 'Commandes en cours'),
        ],
      ),
    );
  }
}
