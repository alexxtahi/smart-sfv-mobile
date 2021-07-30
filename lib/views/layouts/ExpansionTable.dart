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
          MyExpandableBox(key: Key('1'), headerText: 'Caisses ouvertes'),
          MyExpandableBox(
              key: Key('2'), headerText: 'Articles en voie de péremption'),
          MyExpandableBox(
              key: Key('3'), headerText: 'Articles en voie de rupture'),
          MyExpandableBox(
              key: Key('4'), headerText: 'Liste des 5 meilleurs clients'),
          MyExpandableBox(
              key: Key('5'),
              headerText: 'Liste des 5 clients les moins rentables'),
          MyExpandableBox(
              key: Key('6'),
              headerText: 'Liste des 5 articles les plus vendus'),
          MyExpandableBox(
              key: Key('7'),
              headerText: 'Liste des 5 articles les moins vendus'),
          MyExpandableBox(
              key: Key('8'),
              headerText: 'Liste des 5 clients les plus endettés'),
          MyExpandableBox(key: Key('9'), headerText: 'Commandes en cours'),
        ],
      ),
    );
  }
}
