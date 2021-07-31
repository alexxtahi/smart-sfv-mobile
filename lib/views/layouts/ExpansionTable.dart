import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/views/components/MyDataTable.dart';
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
          MyExpandableBox(
            headerText: 'Caisses ouvertes',
            table: MyDataTable(
              columns: [
                'Dépôt',
                'Article',
                'lot',
                'Date de péremption',
                'Sera périmé dans',
              ],
              rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],
            ),
          ),
          MyExpandableBox(
            headerText: 'Articles en voie de péremption',
            table: MyDataTable(
              columns: [
                'Dépôt',
                'Article',
                'lot',
                'Date de péremption',
                'Sera périmé dans',
              ],
              rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],
            ),
          ),
          MyExpandableBox(
            headerText: 'Articles en voie de rupture',
            table: MyDataTable(
              columns: [
                'Dépôt',
                'Article',
                'lot',
                'Date de péremption',
                'Sera périmé dans',
              ],
              rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],
            ),
          ),
          MyExpandableBox(
            headerText: 'Liste des 5 meilleurs clients',
            table: MyDataTable(
              columns: [
                'Dépôt',
                'Article',
                'lot',
                'Date de péremption',
                'Sera périmé dans',
              ],
              rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],
            ),
          ),
          MyExpandableBox(
            headerText: 'Liste des 5 clients les moins rentables',
            table: MyDataTable(
              columns: [
                'Dépôt',
                'Article',
                'lot',
                'Date de péremption',
                'Sera périmé dans',
              ],
              rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],
            ),
          ),
          MyExpandableBox(
            headerText: 'Liste des 5 articles les plus vendus',
            table: MyDataTable(
              columns: [
                'Dépôt',
                'Article',
                'lot',
                'Date de péremption',
                'Sera périmé dans',
              ],
              rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],
            ),
          ),
          MyExpandableBox(
            headerText: 'Liste des 5 articles les moins vendus',
            table: MyDataTable(
              columns: [
                'Dépôt',
                'Article',
                'lot',
                'Date de péremption',
                'Sera périmé dans',
              ],
              rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],
            ),
          ),
          MyExpandableBox(
            headerText: 'Liste des 5 clients les plus endettés',
            table: MyDataTable(
              columns: [
                'Dépôt',
                'Article',
                'lot',
                'Date de péremption',
                'Sera périmé dans',
              ],
              rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],
            ),
          ),
          MyExpandableBox(
            headerText: 'Commandes en cours',
            table: MyDataTable(
              columns: [
                'Dépôt',
                'Article',
                'lot',
                'Date de péremption',
                'Sera périmé dans',
              ],
              rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
