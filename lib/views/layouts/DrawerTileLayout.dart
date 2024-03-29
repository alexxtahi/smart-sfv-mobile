import 'package:expandable/expandable.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/views/screens/parametres/article/ArticleView.dart';
import 'package:smartsfv/views/screens/parametres/banque/BanqueView.dart';
import 'package:smartsfv/views/screens/parametres/caisse/CaisseView.dart';
import 'package:smartsfv/views/screens/parametres/casier/CasierView.dart';
import 'package:smartsfv/views/screens/parametres/categorie-depense/CategorieDepenseView.dart';
import 'package:smartsfv/views/screens/parametres/categorie/CategorieView.dart';
import 'package:smartsfv/views/screens/parametres/client/ClientView.dart';
import 'package:smartsfv/views/screens/commande/CommandeView.dart';
import 'package:smartsfv/views/screens/parametres/divers/DiversView.dart';
import 'package:smartsfv/views/screens/home/HomeView.dart';
import 'package:smartsfv/views/screens/parametres/moyen-payement/MoyenReglementView.dart';
import 'package:smartsfv/views/screens/others/ListTableView.dart';
import 'package:smartsfv/views/screens/parametres/fournisseur/ProviderView.dart';
import 'package:smartsfv/views/components/DrawerExpandableBox.dart';
import 'package:smartsfv/views/components/MyDrawerTile.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/views/screens/parametres/pays/PaysView.dart';
import 'package:smartsfv/views/screens/parametres/rangee/RangeeView.dart';
import 'package:smartsfv/views/screens/parametres/rayon/RayonView.dart';
import 'package:smartsfv/views/screens/parametres/regime/RegimeView.dart';
import 'package:smartsfv/views/screens/parametres/sous-categorie/SousCategorieView.dart';
import 'package:smartsfv/views/screens/parametres/taille/TailleView.dart';
import 'package:smartsfv/views/screens/parametres/tva/TvaView.dart';
import 'package:smartsfv/views/screens/parametres/unite/UniteView.dart';

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
    return Expanded(
      child: FadingEdgeScrollView.fromSingleChildScrollView(
        gradientFractionOnStart: 0.1,
        gradientFractionOnEnd: 0.1,
        child: SingleChildScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: ExpandableNotifier(
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
                    onPressed: () {
                      setState(() {
                        DrawerLayoutController.close();
                      });
                      functions.openPage(
                        context,
                        HomeView(),
                        mode: 'pushReplacement',
                      );
                      //}
                    },
                  ),
                  //todo: Paramètres
                  DrawerExpandableBox(
                    expandableController: expandableController,
                    icon: 'assets/img/icons/settings.png',
                    headerText: 'Paramètres',
                    expandedElements: [
                      //todo: Client Tile
                      {
                        'icon': 'assets/img/icons/suitcase.png',
                        'headerText': 'Client',
                        'onPressed': () {
                          print('Dashboard card Client appuyé !');
                          functions.openPage(
                            context,
                            ClientView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      //todo: Fournisseur Tile
                      {
                        'icon': 'assets/img/icons/provider.png',
                        'headerText': 'Fournisseur',
                        'onPressed': () {
                          print('Dashboard card Fournisseur appuyé !');
                          functions.openPage(
                            context,
                            ProviderView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      //todo: Banque Tile
                      {
                        'icon': 'assets/img/icons/bank-building.png',
                        'headerText': 'Banque',
                        'onPressed': () {
                          print('Chargement de la fenêtre des banques');
                          functions.openPage(
                            context,
                            BanqueView(),
                            //mode: 'pushReplacement',
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/tax.png',
                        'headerText': 'TVA',
                        'onPressed': () {
                          print('Dashboard card TVA appuyé !');
                          functions.openPage(
                            context,
                            TvaView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/regim.png',
                        'headerText': 'Régime',
                        'onPressed': () {
                          print('Régime appuyé !');
                          functions.openPage(
                            context,
                            RegimeView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/box.png',
                        'headerText': 'Article',
                        'onPressed': () {
                          print('Article appuyé !');
                          functions.openPage(
                            context,
                            ArticleView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/cashier.png',
                        'headerText': 'Caisse',
                        'onPressed': () {
                          print('Caisse appuyé !');
                          functions.openPage(
                            context,
                            CaisseView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/countries.png',
                        'headerText': 'Pays',
                        'onPressed': () {
                          print('Pays appuyé !');
                          functions.openPage(
                            context,
                            PaysView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/category.png',
                        'headerText': 'Catégorie',
                        'onPressed': () {
                          print('Catégorie appuyé !');
                          functions.openPage(
                            context,
                            CategorieView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/sub-category.png',
                        'headerText': 'Sous catégorie',
                        'onPressed': () {
                          print('Sous Catégorie appuyé !');
                          functions.openPage(
                            context,
                            SousCategorieView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/wallet.png',
                        'headerText': 'Moyen de paiement',
                        'onPressed': () {
                          print('Sous Catégorie appuyé !');
                          functions.openPage(
                            context,
                            MoyenReglementView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/section.png',
                        'headerText': 'Rayon',
                        'onPressed': () {
                          print('Rayons appuyé !');
                          functions.openPage(
                            context,
                            RayonView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/above.png',
                        'headerText': 'Rangée',
                        'onPressed': () {
                          print('Rangée appuyé !');
                          functions.openPage(
                            context,
                            RangeeView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/locker.png',
                        'headerText': 'Casier',
                        'onPressed': () {
                          print('Casier appuyé !');
                          functions.openPage(
                            context,
                            CasierView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/unity.png',
                        'headerText': 'Unité',
                        'onPressed': () {
                          print('Unité appuyé !');
                          functions.openPage(
                            context,
                            UniteView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/package.png',
                        'headerText': 'Taille',
                        'onPressed': () {
                          print('Taille appuyé !');
                          functions.openPage(
                            context,
                            TailleView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/more.png',
                        'headerText': 'Divers',
                        'onPressed': () {
                          print('Divers appuyé !');
                          functions.openPage(
                            context,
                            DiversView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                      {
                        'icon': 'assets/img/icons/hand.png',
                        'headerText': 'Catégorie dépense',
                        'onPressed': () {
                          print('CategorieDepense appuyé !');
                          functions.openPage(
                            context,
                            CategorieDepenseView(),
                          );
                          setState(() {
                            DrawerLayoutController.close();
                          });
                        },
                      },
                    ],
                  ),
                  //todo: Stocks
                  DrawerExpandableBox(
                    expandableController: expandableController,
                    icon: 'assets/img/icons/stock.png',
                    headerText: 'Stocks',
                    expandedElements: [
                      {
                        'icon': 'assets/img/icons/document.png',
                        'headerText': 'Bon de commande',
                        'onPressed': () {
                          print('Chargement de la fenêtre des commandes');
                          functions.openPage(
                            context,
                            CommandeView(),
                            //mode: 'pushReplacement',
                          );
                        },
                      },
                      {
                        'icon': 'assets/img/icons/truck.png',
                        'headerText': 'Réception de commande'
                      },
                      {
                        'icon': 'assets/img/icons/supplies.png',
                        'headerText': 'Approvisionnement'
                      },
                      {
                        'icon': 'assets/img/icons/warehouse.png',
                        'headerText': 'Stock par dépôt',
                      },
                      {
                        'icon': 'assets/img/icons/arrows.png',
                        'headerText': 'Transfert de stock'
                      },
                      {
                        'icon': 'assets/img/icons/unpacking.png',
                        'headerText': 'Déstockage'
                      },
                      {
                        'icon': 'assets/img/icons/inventory.png',
                        'headerText': 'Inventaire'
                      },
                      {
                        'icon': 'assets/img/icons/stock-movement.png',
                        'headerText': 'Mouvements de stock'
                      },
                      {
                        'icon': 'assets/img/icons/packages.png',
                        'headerText': 'Mouvement stock article'
                      },
                    ],
                  ),
                  //todo: Boutique
                  DrawerExpandableBox(
                    expandableController: expandableController,
                    icon: 'assets/img/icons/shop.png',
                    headerText: 'Boutique',
                    expandedElements: [
                      {
                        'icon': 'assets/img/icons/credit-cards-payment.png',
                        'headerText': 'Vente'
                      },
                      {
                        'icon': 'assets/img/icons/cashier-machine.png',
                        'headerText': 'Point de caisse',
                        'onPressed': () => openListTableView(
                              title: 'Caisses ouvertes',
                              columns: [
                                'Dépôt',
                                'Caisse',
                                'Etat',
                                'Accéder',
                              ],
                              rows: [
                                for (var i = 1; i < 100; i++)
                                  [
                                    '1',
                                    'Alexandre TAHI',
                                    '+225 05 84 64 98 25',
                                    "Côte d'ivoire",
                                  ],
                              ],
                            ),
                      },
                      {
                        'icon': 'assets/img/icons/spending.png',
                        'headerText': 'Vente divers'
                      },
                      {
                        'icon': 'assets/img/icons/go-back-arrow.png',
                        'headerText': "Retour d'articles"
                      },
                      {
                        'icon': 'assets/img/icons/dollar.png',
                        'headerText': 'Règlement de facture'
                      },
                      {
                        'icon': 'assets/img/icons/exchange.png',
                        'headerText': 'Opération de caisse'
                      },
                      {
                        'icon': 'assets/img/icons/discount.png',
                        'headerText': 'Promotion'
                      },
                    ],
                  ),
                  //todo: Comptabilité
                  DrawerExpandableBox(
                    expandableController: expandableController,
                    icon: 'assets/img/icons/calculator.png',
                    headerText: 'Comptabilité',
                    expandedElements: [
                      {'headerText': 'Solde client'},
                      {'headerText': 'Solde fournisseur'},
                      {'headerText': 'Déclaration TVA'},
                      {'headerText': 'Ticket déclaré pour TVA'},
                      {'headerText': 'Timbre fiscal'},
                      {'headerText': 'Marge sur vente'},
                      {'headerText': 'Points de caisse cloturés'},
                      {'headerText': 'Dépenses'},
                    ],
                  ),
                  //todo: Etats
                  DrawerExpandableBox(
                    expandableController: expandableController,
                    icon: 'assets/img/icons/paper.png',
                    headerText: 'Etats',
                    expandedElements: [
                      {'headerText': 'Vente caisse'},
                      {'headerText': 'Article'},
                      {'headerText': 'Article vendus'},
                      {'headerText': 'Article reçus'},
                      {'headerText': 'Articles retournés'},
                      {'headerText': 'Fournisseur'},
                      {'headerText': 'Client'},
                      {'headerText': 'Dépôt'},
                    ],
                  ),
                  //todo: Canal
                  DrawerExpandableBox(
                    expandableController: expandableController,
                    icon: 'assets/img/icons/global-network.png',
                    headerText: 'Canal',
                    expandedElements: [
                      {
                        'icon': 'assets/img/icons/flag.png',
                        'headerText': 'Localité'
                      },
                      {
                        'icon': 'assets/img/icons/price-tag.png',
                        'headerText': 'Offres'
                      },
                      {
                        'icon': 'assets/img/icons/molecular.png',
                        'headerText': 'Options canal'
                      },
                      {
                        'icon': 'assets/img/icons/sub-category.png',
                        'headerText': 'Type de caution'
                      },
                      {
                        'icon': 'assets/img/icons/dollar.png',
                        'headerText': 'Type de pièce'
                      },
                      {
                        'icon': 'assets/img/icons/technics.png',
                        'headerText': 'Matériel'
                      },
                      {
                        'icon': 'assets/img/icons/company.png',
                        'headerText': 'Agence'
                      },
                      {
                        'icon': 'assets/img/icons/deposit.png',
                        'headerText': 'Caution canal'
                      },
                      {
                        'icon': 'assets/img/icons/suitcase.png',
                        'headerText': 'Caution agence'
                      },
                      {
                        'icon': 'assets/img/icons/google-docs.png',
                        'headerText': 'Liste des rechargements'
                      },
                      {
                        'icon': 'assets/img/icons/follower.png',
                        'headerText': 'Abonnés'
                      },
                      {
                        'icon': 'assets/img/icons/subscribe.png',
                        'headerText': 'Abonnement'
                      },
                      {
                        'icon': 'assets/img/icons/reload.png',
                        'headerText': 'Réabonnement'
                      },
                      {
                        'icon': 'assets/img/icons/briefcase.png',
                        'headerText': 'Vente de matériel'
                      },
                      {
                        'icon': 'assets/img/icons/spending-movement.png',
                        'headerText': 'Mouvement des ventes'
                      },
                      {
                        'icon': 'assets/img/icons/user.png',
                        'headerText': 'Utilisateur agence'
                      },
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

  void openListTableView(
      {String title: 'Nouvelle liste 1',
      List<String> columns: const [],
      List<List<String>> rows: const [],
      debugMessage: ''}) {
    print(debugMessage);
    functions.openPage(
      context,
      ListTableView(
        title: 'Caisses ouvertes',
        columns: columns,
        rows: rows,
      ),
    );
    setState(() {
      DrawerLayoutController.close();
    });
  }
}
