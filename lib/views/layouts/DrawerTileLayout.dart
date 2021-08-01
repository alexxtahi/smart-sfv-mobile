import 'package:expandable/expandable.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/views/components/DrawerExpandableBox.dart';
import 'package:smart_sfv_mobile/views/components/MyDataTable.dart';
import 'package:smart_sfv_mobile/views/components/MyDrawerTile.dart';
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
                MyDrawerTile(
                  icon: 'assets/img/icons/dashboard.png',
                  headerText: 'Tableau de bord',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/settings.png',
                  headerText: 'Paramètres',
                  expandedElements: [
                    ['assets/img/icons/suitcase.png', 'client'],
                  ],
                ),
                /*DrawerExpandableBox(
                  icon: 'assets/img/icons/stock.png',
                  headerText: 'Stocks',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/shop.png',
                  headerText: 'Boutique',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/calculator.png',
                  headerText: 'Comptabilité',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/paper.png',
                  headerText: 'Etats',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/global-network.png',
                  headerText: 'Canal',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/customer.png',
                  headerText: 'Abonnés',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/customer.png',
                  headerText: 'Abonnement',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/customer.png',
                  headerText: 'Réabonnement',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/customer.png',
                  headerText: 'Vente de matériel',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/customer.png',
                  headerText: 'Cautions',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/customer.png',
                  headerText: 'Utilisateurs',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/customer.png',
                  headerText: 'Configuration',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/bank.png',
                  headerText: 'Dépôt',
                ),
                DrawerExpandableBox(
                  icon: 'assets/img/icons/customer.png',
                  headerText: 'Restauration de données',
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
