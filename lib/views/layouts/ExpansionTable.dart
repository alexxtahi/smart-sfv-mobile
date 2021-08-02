import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:smart_sfv/views/components/MyDataTable.dart';
import 'package:smart_sfv/views/components/MyExpandableBox.dart';

class ExpansionTable extends StatefulWidget {
  ExpansionTable({
    Key? key,
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
          //todo: Caisses ouvertes
          MyExpandableBox(
            headerText: 'Caisses ouvertes',
            table: MyDataTable(
              columns: [
                'Dépôt',
                'Caisse',
                "Date d'ouverture",
                'Ouverte par',
                "Solde d'ouverture",
                "Solde actuel",
              ],
              /*rows: [
                ['14', 'Chaise', '53dd5', '23/09/2021', '45 jours'],
                ['45', 'Paquet de chips', '7728t', '01/05/2021', '17 jours'],
                ['77', 'Sac à main', '336tf6', '30/12/2021', '23 jours'],
              ],*/
            ),
          ),
          //todo: Articles en voie de péremption
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
              /*rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],*/
            ),
          ),
          //todo: Articles en voie de rupture
          MyExpandableBox(
            headerText: 'Articles en voie de rupture',
            table: MyDataTable(
              columns: [
                'Article',
                'Catégorie',
                'Sous catégorie',
                'En stock',
                'Dépôt',
              ],
              /*rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],*/
            ),
          ),
          //todo: Liste des 5 meilleurs clients
          MyExpandableBox(
            headerText: 'Liste des 5 meilleurs clients',
            table: MyDataTable(
              columns: [
                'Client',
                'Contact',
                "Chiffre d'affaires",
              ],
              /*rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],*/
            ),
          ),
          //todo: Liste des 5 clients les moins rentables
          MyExpandableBox(
            headerText: 'Liste des 5 clients les moins rentables',
            table: MyDataTable(
              columns: [
                'Client',
                'Contact',
                "Chiffre d'affaires",
              ],
              /*rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],*/
            ),
          ),
          //todo: Liste des 5 articles les plus vendus
          MyExpandableBox(
            headerText: 'Liste des 5 articles les plus vendus',
            table: MyDataTable(
              columns: [
                'Article',
                'Quantité',
                'Montant',
              ],
              /*rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],*/
            ),
          ),
          //todo: Liste des 5 articles les moins vendus
          MyExpandableBox(
            headerText: 'Liste des 5 articles les moins vendus',
            table: MyDataTable(
              columns: [
                'Article',
                'Quantité',
                'Montant',
              ],
              /*rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],*/
            ),
          ),
          //todo: Liste des 5 clients les plus endettés
          MyExpandableBox(
            headerText: 'Liste des 5 clients les plus endettés',
            table: MyDataTable(
              columns: [
                'Client',
                'Contact',
                'Adresse',
                'Montant',
              ],
              /*rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],*/
            ),
          ),
          //todo: Commande en cours
          MyExpandableBox(
            headerText: 'Commandes en cours',
            table: MyDataTable(
              columns: [
                'Date commande',
                'N° Bon',
                'Fournisseur',
                'Montant',
              ],
              /*rows: [
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
                ['14', 'Sac à main', '18n47b', '23/09/2021', '45 jours'],
              ],*/
            ),
          ),
        ],
      ),
    );
  }
}
