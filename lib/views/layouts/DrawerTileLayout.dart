import 'package:expandable/expandable.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/views/components/DrawerExpandableBox.dart';
import 'package:smartsfv/views/components/MyDrawerTile.dart';

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
            child: ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: true,
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
                    expandableController: expandableController,
                    icon: 'assets/img/icons/settings.png',
                    headerText: 'Paramètres',
                    expandedElements: [
                      ['assets/img/icons/suitcase.png', 'Client'],
                      ['assets/img/icons/provider.png', 'Fournisseur'],
                      ['assets/img/icons/bank-building.png', 'Banque'],
                      ['assets/img/icons/tax.png', 'TVA'],
                      ['assets/img/icons/regim.png', 'Régime'],
                      ['assets/img/icons/box.png', 'Article'],
                      ['assets/img/icons/cashier.png', 'Caisse'],
                      ['assets/img/icons/countries.png', 'Pays'],
                      ['assets/img/icons/category.png', 'Catégorie'],
                      ['assets/img/icons/sub-category.png', 'Sous catégorie'],
                      ['assets/img/icons/wallet.png', 'Moyen de paiement'],
                      ['assets/img/icons/section.png', 'Rayon'],
                      ['assets/img/icons/above.png', 'Rangée'],
                      ['assets/img/icons/locker.png', 'Casier'],
                      ['assets/img/icons/unity.png', 'Unité'], // ! à revenir
                      ['assets/img/icons/package.png', 'Taille'],
                      ['assets/img/icons/more.png', 'Divers'],
                      ['assets/img/icons/hand.png', 'Catégorie dépense'],
                    ],
                  ),
                  //todo: Stocks
                  DrawerExpandableBox(
                    expandableController: expandableController,
                    icon: 'assets/img/icons/stock.png',
                    headerText: 'Stocks',
                    expandedElements: [
                      ['assets/img/icons/document.png', 'Bon de commande'],
                      ['assets/img/icons/truck.png', 'Réception de commande'],
                      ['assets/img/icons/supplies.png', 'Approvisionnement'],
                      ['assets/img/icons/warehouse.png', 'Stock par dépôt'],
                      ['assets/img/icons/arrows.png', 'Transfert de stock'],
                      ['assets/img/icons/unpacking.png', 'Déstockage'],
                      ['assets/img/icons/inventory.png', 'Inventaire'],
                      [
                        'assets/img/icons/stock-movement.png',
                        'Mouvements de stock'
                      ],
                      [
                        'assets/img/icons/packages.png',
                        'Mouvement stock article'
                      ],
                    ],
                  ),
                  //todo: Boutique
                  DrawerExpandableBox(
                    expandableController: expandableController,
                    icon: 'assets/img/icons/shop.png',
                    headerText: 'Boutique',
                    expandedElements: [
                      ['assets/img/icons/credit-cards-payment.png', 'Vente'],
                      [
                        'assets/img/icons/cashier-machine.png',
                        'Point de caisse'
                      ],
                      ['assets/img/icons/spending.png', 'Vente divers'],
                      [
                        'assets/img/icons/go-back-arrow.png',
                        "Retour d'articles"
                      ],
                      ['assets/img/icons/dollar.png', 'Règlement de facture'],
                      ['assets/img/icons/exchange.png', 'Opération de caisse'],
                      ['assets/img/icons/discount.png', 'Promotion'],
                    ],
                  ),
                  //todo: Comptabilité
                  DrawerExpandableBox(
                    expandableController: expandableController,
                    icon: 'assets/img/icons/calculator.png',
                    headerText: 'Comptabilité',
                    expandedElements: [
                      ['Solde client'],
                      ['Solde fournisseur'],
                      ['Déclaration TVA'],
                      ['Ticket déclaré pour TVA'],
                      ['Timbre fiscal'],
                      ['Marge sur vente'],
                      ['Points de caisse cloturés'],
                      ['Dépenses'],
                    ],
                  ),
                  //todo: Etats
                  DrawerExpandableBox(
                    expandableController: expandableController,
                    icon: 'assets/img/icons/paper.png',
                    headerText: 'Etats',
                    expandedElements: [
                      ['Vente caisse'],
                      ['Article'],
                      ['Article vendus'],
                      ['Article reçus'],
                      ['Articles retournés'],
                      ['Fournisseur'],
                      ['Client'],
                      ['Dépôt'],
                    ],
                  ),
                  //todo: Canal
                  DrawerExpandableBox(
                    expandableController: expandableController,
                    icon: 'assets/img/icons/global-network.png',
                    headerText: 'Canal',
                    expandedElements: [
                      ['assets/img/icons/flag.png', 'Localité'],
                      ['assets/img/icons/price-tag.png', 'Offres'],
                      ['assets/img/icons/molecular.png', 'Options canal'],
                      ['assets/img/icons/sub-category.png', 'Type de caution'],
                      ['assets/img/icons/dollar.png', 'Type de pièce'],
                      ['assets/img/icons/technics.png', 'Matériel'],
                      ['assets/img/icons/company.png', 'Agence'],
                      ['assets/img/icons/deposit.png', 'Caution canal'],
                      ['assets/img/icons/suitcase.png', 'Caution agence'],
                      [
                        'assets/img/icons/google-docs.png',
                        'Liste des rechargements'
                      ],
                      ['assets/img/icons/follower.png', 'Abonnés'],
                      ['assets/img/icons/subscribe.png', 'Abonnement'],
                      ['assets/img/icons/reload.png', 'Réabonnement'],
                      ['assets/img/icons/briefcase.png', 'Vente de matériel'],
                      [
                        'assets/img/icons/spending-movement.png',
                        'Mouvement des ventes'
                      ],
                      ['assets/img/icons/user.png', 'Utilisateur agence'],
                    ],
                  ),
                  //todo: Cautions
                  MyDrawerTile(
                    icon: 'assets/img/icons/deposit.png',
                    iconSize: 40,
                    headerText: 'Cautions',
                    headerTextSize: 16,
                    headerTextWeight: FontWeight.bold,
                  ),
                  //todo: Utilisateurs
                  MyDrawerTile(
                    icon: 'assets/img/icons/user.png',
                    iconSize: 40,
                    headerText: 'Utilisateurs',
                    headerTextSize: 16,
                    headerTextWeight: FontWeight.bold,
                  ),
                  //todo: Configuration
                  MyDrawerTile(
                    icon: 'assets/img/icons/setting-lines.png',
                    iconSize: 40,
                    headerText: 'Configuration',
                    headerTextSize: 16,
                    headerTextWeight: FontWeight.bold,
                  ),
                  //todo: Dépot
                  MyDrawerTile(
                    icon: 'assets/img/icons/bank-building.png',
                    iconSize: 40,
                    headerText: 'Dépot',
                    headerTextSize: 16,
                    headerTextWeight: FontWeight.bold,
                  ),
                  //todo: Restaurer les données
                  MyDrawerTile(
                    icon: 'assets/img/icons/backup.png',
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
      ),
    );
  }
}
