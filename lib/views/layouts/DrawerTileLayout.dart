import 'package:expandable/expandable.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/views/components/DrawerExpandableBox.dart';
import 'package:smart_sfv_mobile/views/components/MyDrawerTile.dart';

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
            //todo: Drawer Tiles
            child: Column(
              children: [
                //todo: Tableau de bord
                MyDrawerTile(
                  icon: 'assets/img/icons/dashboard.png',
                  iconSize: 40,
                  headerText: 'Tableau de bord',
                  headerTextSize: 16,
                  headerTextWeight: FontWeight.bold,
                ),
                //todo: Paramètres
                DrawerExpandableBox(
                  icon: 'assets/img/icons/settings.png',
                  headerText: 'Paramètres',
                  expandedElements: [
                    ['assets/img/icons/suitcase.png', 'Client'],
                    ['assets/img/icons/provider.png', 'Fournisseur'],
                    ['assets/img/icons/bank.png', 'Banque'],
                    ['assets/img/icons/suitcase.png', 'TVA'],
                    ['assets/img/icons/suitcase.png', 'Régime'],
                    ['assets/img/icons/suitcase.png', 'Article'],
                    ['assets/img/icons/suitcase.png', 'Caisse'],
                    ['assets/img/icons/suitcase.png', 'Pays'],
                    ['assets/img/icons/suitcase.png', 'Catégorie'],
                    ['assets/img/icons/suitcase.png', 'Sous catégorie'],
                    ['assets/img/icons/suitcase.png', 'Moyen de paiement'],
                    ['assets/img/icons/suitcase.png', 'Rayon'],
                    ['assets/img/icons/suitcase.png', 'Rangée'],
                    ['assets/img/icons/suitcase.png', 'Casier'],
                    ['assets/img/icons/suitcase.png', 'Unité'],
                    ['assets/img/icons/suitcase.png', 'Taille'],
                    ['assets/img/icons/suitcase.png', 'Divers'],
                    ['assets/img/icons/suitcase.png', 'Catégorie dépense'],
                  ],
                ),
                //todo: Stocks
                DrawerExpandableBox(
                  icon: 'assets/img/icons/stock.png',
                  headerText: 'Stocks',
                  expandedElements: [
                    ['assets/img/icons/suitcase.png', 'Bon de commande'],
                    ['assets/img/icons/suitcase.png', 'Réception de commande'],
                    ['assets/img/icons/suitcase.png', 'Approvisionnement'],
                    ['assets/img/icons/suitcase.png', 'Stock par dépôt'],
                    ['assets/img/icons/suitcase.png', 'Transfert de stock'],
                    ['assets/img/icons/suitcase.png', 'Déstockage'],
                    ['assets/img/icons/suitcase.png', 'Inventaire'],
                    ['assets/img/icons/suitcase.png', 'Mouvements de stock'],
                    [
                      'assets/img/icons/suitcase.png',
                      'Mouvement stock article'
                    ],
                  ],
                ),
                //todo: Boutique
                DrawerExpandableBox(
                  icon: 'assets/img/icons/shop.png',
                  headerText: 'Boutique',
                  expandedElements: [
                    ['assets/img/icons/credit-cards-payment.png', 'Vente'],
                    ['assets/img/icons/suitcase.png', 'Point de caisse'],
                    ['assets/img/icons/suitcase.png', 'Vente divers'],
                    ['assets/img/icons/go-back-arrow.png', "Retour d'articles"],
                    ['assets/img/icons/dollar.png', 'Règlement de facture'],
                    ['assets/img/icons/suitcase.png', 'Déstockage'],
                    ['assets/img/icons/suitcase.png', 'Opération de caisse'],
                    ['assets/img/icons/suitcase.png', 'Promotion'],
                  ],
                ),
                //todo: Comptabilité
                DrawerExpandableBox(
                  icon: 'assets/img/icons/calculator.png',
                  headerText: 'Comptabilité',
                  expandedElements: [
                    [
                      'assets/img/icons/credit-cards-payment.png',
                      'Solde client'
                    ],
                    ['assets/img/icons/suitcase.png', 'Solde fournisseur'],
                    ['assets/img/icons/suitcase.png', 'Déclaration TVA'],
                    [
                      'assets/img/icons/go-back-arrow.png',
                      'Ticket déclaré pour TVA'
                    ],
                    ['assets/img/icons/dollar.png', 'Timbre fiscal'],
                    ['assets/img/icons/suitcase.png', 'Marge sur vente'],
                    [
                      'assets/img/icons/suitcase.png',
                      'Points de caisse cloturés'
                    ],
                    ['assets/img/icons/suitcase.png', 'Dépenses'],
                  ],
                ),
                //todo: Etats
                DrawerExpandableBox(
                  icon: 'assets/img/icons/paper.png',
                  headerText: 'Etats',
                  expandedElements: [
                    [
                      'assets/img/icons/credit-cards-payment.png',
                      'Vente caisse'
                    ],
                    ['assets/img/icons/suitcase.png', 'Article'],
                    ['assets/img/icons/suitcase.png', 'Article vendus'],
                    ['assets/img/icons/go-back-arrow.png', 'Article reçus'],
                    ['assets/img/icons/dollar.png', 'Articles retournés'],
                    ['assets/img/icons/suitcase.png', 'Fournisseur'],
                    ['assets/img/icons/suitcase.png', 'Client'],
                    ['assets/img/icons/suitcase.png', 'Dépôt'],
                  ],
                ),
                //todo: Canal
                DrawerExpandableBox(
                  icon: 'assets/img/icons/global-network.png',
                  headerText: 'Canal',
                  expandedElements: [
                    ['assets/img/icons/credit-cards-payment.png', 'Localité'],
                    ['assets/img/icons/suitcase.png', 'Offres'],
                    ['assets/img/icons/suitcase.png', 'Options canal'],
                    ['assets/img/icons/go-back-arrow.png', 'Type de caution'],
                    ['assets/img/icons/dollar.png', 'Type de pièce'],
                    ['assets/img/icons/suitcase.png', 'Matériel'],
                    ['assets/img/icons/suitcase.png', 'Agence'],
                    ['assets/img/icons/suitcase.png', 'Caution canal'],
                    ['assets/img/icons/suitcase.png', 'Caution agence'],
                    [
                      'assets/img/icons/suitcase.png',
                      'Liste des rechargements'
                    ],
                    ['assets/img/icons/suitcase.png', 'Abonnés'],
                    ['assets/img/icons/suitcase.png', 'Abonnement'],
                    ['assets/img/icons/suitcase.png', 'Réabonnement'],
                    ['assets/img/icons/suitcase.png', 'Vente de matériel'],
                    ['assets/img/icons/suitcase.png', 'Mouvement des ventes'],
                    ['assets/img/icons/suitcase.png', 'Utilisateur agence'],
                  ],
                ),
                //todo: Cautions
                MyDrawerTile(
                  icon: 'assets/img/icons/dashboard.png',
                  iconSize: 40,
                  headerText: 'Cautions',
                  headerTextSize: 16,
                  headerTextWeight: FontWeight.bold,
                ),
                //todo: Utilisateurs
                MyDrawerTile(
                  icon: 'assets/img/icons/dashboard.png',
                  iconSize: 40,
                  headerText: 'Utilisateurs',
                  headerTextSize: 16,
                  headerTextWeight: FontWeight.bold,
                ),
                //todo: Configuration
                MyDrawerTile(
                  icon: 'assets/img/icons/dashboard.png',
                  iconSize: 40,
                  headerText: 'Configuration',
                  headerTextSize: 16,
                  headerTextWeight: FontWeight.bold,
                ),
                //todo: Dépot
                MyDrawerTile(
                  icon: 'assets/img/icons/dashboard.png',
                  iconSize: 40,
                  headerText: 'Dépot',
                  headerTextSize: 16,
                  headerTextWeight: FontWeight.bold,
                ),
                //todo: Restaurer les données
                MyDrawerTile(
                  icon: 'assets/img/icons/dashboard.png',
                  iconSize: 40,
                  headerText: 'Restaurer les données',
                  headerTextSize: 16,
                  headerTextWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
