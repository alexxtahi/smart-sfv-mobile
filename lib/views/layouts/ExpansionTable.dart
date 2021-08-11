import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Article.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/models/Commande.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/layouts/ErrorLayout.dart';
import 'package:smartsfv/views/screens/commande/CommandeView.dart';
import 'package:smartsfv/views/screens/others/ListTableView.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyExpandableBox.dart';
import 'package:smartsfv/functions.dart' as functions;

class ExpansionTable extends StatefulWidget {
  ExpansionTable({
    Key? key,
  }) : super(key: key);
  @override
  ExpansionTableState createState() => ExpansionTableState();
}

class ExpansionTableState extends State<ExpansionTable> {
  // init API instance
  Api api = Api();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    // Return building scaffold
    return ExpandableNotifier(
      // <-- Provides ExpandableController to its children
      child: Column(
        children: [
          /*
          //todo: Caisses ouvertes
          MyExpandableBox(
            headerText: 'Caisses ouvertes',
            seeMoreBtn: () {
              openListTableView(
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
              );
            },
            table: FutureBuilder<List<Article>>(
              //future: api.getArticles(context),
              builder: (tableContext, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return MyDataTable(
                    columns: [
                      'Dépôt',
                      'Caisse',
                      "Date d'ouverture",
                      'Ouverte par',
                      "Solde d'ouverture",
                      "Solde actuel",
                    ],
                    rows: [],
                  );
                } else if (snapshot.hasError) {
                  // ? Get any snapshot error
                  return ErrorLayout();
                }
                //todo: Loading indicator
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenSize[0],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(text: 'Chargement...'),
                        SizedBox(height: 5),
                        LinearProgressIndicator(
                          color: Color.fromRGBO(60, 141, 188, 0.15),
                          backgroundColor: Colors.transparent,
                          semanticsLabel: 'Chargement...',
                          //backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),*/
          //todo: Articles en voie de péremption
          MyExpandableBox(
            headerText: 'Articles en voie de péremption',
            seeMoreBtn: () {
              openListTableView(
                title: 'Article en voie de péremption',
                columns: [
                  'Dépôt',
                  'Article',
                  'lot',
                  'Date de péremption',
                  'Sera périmé dans',
                ],
                rows: [
                  for (var i = 1; i < 100; i++)
                    [
                      '1',
                      'Alexandre TAHI',
                      '+225 05 84 64 98 25',
                      "Côte d'ivoire",
                      "Côte d'ivoire",
                    ],
                ],
              );
            },
            table: FutureBuilder<List<Article>>(
              future: api.getArticlesPeremption(context),
              builder: (tableContext, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return MyDataTable(
                    columns: [
                      'Dépôt',
                      'Article',
                      'lot',
                      'Date de péremption',
                      'Sera périmé dans',
                    ],
                    rows: [
                      for (var article in snapshot.data!)
                        [
                          article.libelleDepot,
                          article.description,
                          article.libelleUnite,
                          // get expiration date
                          dateFormat
                              .format(DateTime.parse(article.datePeremption)),
                          // compute difference between expiration date and now
                          DateTime.parse(article.datePeremption)
                                  .difference(now)
                                  .inDays
                                  .toString() +
                              ' jours',
                        ],
                    ],
                  );
                } else if (snapshot.hasError) {
                  // ? Get any snapshot error
                  return ErrorLayout();
                }
                //todo: Loading indicator
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenSize[0],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(text: 'Chargement...'),
                        SizedBox(height: 5),
                        LinearProgressIndicator(
                          color: Color.fromRGBO(60, 141, 188, 0.15),
                          backgroundColor: Colors.transparent,
                          semanticsLabel: 'Chargement...',
                          //backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //todo: Articles en voie de rupture
          MyExpandableBox(
            headerText: 'Articles en voie de rupture',
            seeMoreBtn: () {
              openListTableView(
                title: 'Article en voie de rupture',
                columns: [
                  'Article',
                  'Catégorie',
                  'Sous catégorie',
                  'En stock',
                  'Dépôt',
                ],
                rows: [
                  for (var i = 1; i < 100; i++)
                    [
                      '1',
                      'Alexandre TAHI',
                      '+225 05 84 64 98 25',
                      "Côte d'ivoire",
                      "Côte d'ivoire",
                    ],
                ],
              );
            },
            table: FutureBuilder<List<Article>>(
              future: api.getArticlesRupture(context),
              builder: (tableContext, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return MyDataTable(
                    columns: [
                      'Article',
                      'Catégorie',
                      'Sous catégorie',
                      'En stock',
                      'Dépôt',
                    ],
                    rows: [
                      for (var article in snapshot.data!)
                        [
                          article.description,
                          article.categorie,
                          article.subCategorie,
                          article.qteEnStock.toString(),
                          article.libelleDepot,
                        ],
                    ],
                  );
                } else if (snapshot.hasError) {
                  // ? Get any snapshot error
                  return ErrorLayout();
                }
                //todo: Loading indicator
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenSize[0],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(text: 'Chargement...'),
                        SizedBox(height: 5),
                        LinearProgressIndicator(
                          color: Color.fromRGBO(60, 141, 188, 0.15),
                          backgroundColor: Colors.transparent,
                          semanticsLabel: 'Chargement...',
                          //backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //todo: Liste des 5 meilleurs clients
          MyExpandableBox(
            headerText: 'Liste des 5 meilleurs clients',
            seeMoreBtn: () {
              openListTableView(
                title: 'Liste des 5 meilleurs clients',
                columns: [
                  'Client',
                  'Contact',
                  "Chiffre d'affaires",
                ],
                rows: [
                  for (var i = 1; i < 100; i++)
                    [
                      '1',
                      'Alexandre TAHI',
                      '+225 05 84 64 98 25',
                    ],
                ],
              );
            },
            table: FutureBuilder<List<Client>>(
              future: api.getBestClients(context),
              builder: (tableContext, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return MyDataTable(
                    columns: [
                      'Client',
                      'Contact',
                      "Chiffre d'affaires",
                    ],
                    rows: [
                      for (var client in snapshot.data!)
                        [
                          client.nom,
                          client.contact,
                          client.chiffreAffaire.toString(),
                        ],
                    ],
                  );
                } else if (snapshot.hasError) {
                  // ? Get any snapshot error
                  return ErrorLayout();
                }
                //todo: Loading indicator
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenSize[0],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(text: 'Chargement...'),
                        SizedBox(height: 5),
                        LinearProgressIndicator(
                          color: Color.fromRGBO(60, 141, 188, 0.15),
                          backgroundColor: Colors.transparent,
                          semanticsLabel: 'Chargement...',
                          //backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //todo: Liste des 5 clients les moins rentables
          MyExpandableBox(
            headerText: 'Liste des 5 clients les moins rentables',
            seeMoreBtn: () {
              openListTableView(
                title: 'Liste des 5 clients les moins rentables',
                columns: [
                  'Client',
                  'Contact',
                  "Chiffre d'affaires",
                ],
                rows: [
                  for (var i = 1; i < 100; i++)
                    [
                      '1',
                      'Alexandre TAHI',
                      '+225 05 84 64 98 25',
                    ],
                ],
              );
            },
            table: FutureBuilder<List<Client>>(
              future: api.getWorstRentabilityClients(context),
              builder: (tableContext, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return MyDataTable(
                    columns: [
                      'Client',
                      'Contact',
                      "Chiffre d'affaires",
                    ],
                    rows: [
                      for (var client in snapshot.data!)
                        [
                          client.nom,
                          client.contact,
                          client.chiffreAffaire.toString(),
                        ],
                    ],
                  );
                } else if (snapshot.hasError) {
                  // ? Get any snapshot error
                  return ErrorLayout();
                }
                //todo: Loading indicator
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenSize[0],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(text: 'Chargement...'),
                        SizedBox(height: 5),
                        LinearProgressIndicator(
                          color: Color.fromRGBO(60, 141, 188, 0.15),
                          backgroundColor: Colors.transparent,
                          semanticsLabel: 'Chargement...',
                          //backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //todo: Liste des 5 articles les plus vendus
          MyExpandableBox(
            headerText: 'Liste des 5 articles les plus vendus',
            seeMoreBtn: () {
              openListTableView(
                title: 'Liste des 5 articles les plus vendus',
                columns: [
                  'Article',
                  'Quantité',
                  'Montant',
                ],
                rows: [
                  for (var i = 1; i < 100; i++)
                    [
                      '1',
                      'Alexandre TAHI',
                      '+225 05 84 64 98 25',
                    ],
                ],
              );
            },
            table: FutureBuilder<List<Article>>(
              future: api.getBestArticles(context),
              builder: (tableContext, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return MyDataTable(
                    columns: [
                      'Article',
                      'Quantité',
                      'Montant',
                    ],
                    rows: [
                      for (var article in snapshot.data!)
                        [
                          article.description,
                          article.qteEnStock.toString(),
                          article.prixVenteTTC.toString(),
                        ],
                    ],
                  );
                } else if (snapshot.hasError) {
                  // ? Get any snapshot error
                  return ErrorLayout();
                }
                //todo: Loading indicator
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenSize[0],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(text: 'Chargement...'),
                        SizedBox(height: 5),
                        LinearProgressIndicator(
                          color: Color.fromRGBO(60, 141, 188, 0.15),
                          backgroundColor: Colors.transparent,
                          semanticsLabel: 'Chargement...',
                          //backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //todo: Liste des 5 articles les moins vendus
          MyExpandableBox(
            headerText: 'Liste des 5 articles les moins vendus',
            seeMoreBtn: () {
              openListTableView(
                title: 'Liste des 5 articles les moins vendus',
                columns: [
                  'Article',
                  'Quantité',
                  'Montant',
                ],
                rows: [
                  for (var i = 1; i < 100; i++)
                    [
                      '1',
                      'Alexandre TAHI',
                      '+225 05 84 64 98 25',
                    ],
                ],
              );
            },
            table: FutureBuilder<List<Article>>(
              future: api.getWorstArticles(context),
              builder: (tableContext, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return MyDataTable(
                    columns: [
                      'Article',
                      'Quantité',
                      'Montant',
                    ],
                    rows: [
                      for (var article in snapshot.data!)
                        [
                          article.description,
                          article.qteEnStock.toString(),
                          article.prixVenteTTC.toString(),
                        ],
                    ],
                  );
                } else if (snapshot.hasError) {
                  // ? Get any snapshot error
                  return ErrorLayout();
                }
                //todo: Loading indicator
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenSize[0],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(text: 'Chargement...'),
                        SizedBox(height: 5),
                        LinearProgressIndicator(
                          color: Color.fromRGBO(60, 141, 188, 0.15),
                          backgroundColor: Colors.transparent,
                          semanticsLabel: 'Chargement...',
                          //backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //todo: Liste des 5 clients les plus endettés
          MyExpandableBox(
            headerText: 'Liste des 5 clients les plus endettés',
            seeMoreBtn: () {
              openListTableView(
                title: 'Liste des 5 clients les plus endettés',
                columns: [
                  'Client',
                  'Contact',
                  'Adresse',
                  'Montant',
                ],
                rows: [
                  for (var i = 1; i < 100; i++)
                    [
                      '1',
                      'Alexandre TAHI',
                      '+225 05 84 64 98 25',
                      '+225 05 84 64 98 25',
                    ],
                ],
              );
            },
            table: FutureBuilder<List<Client>>(
              future: api.getDettesClients(context),
              builder: (tableContext, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return MyDataTable(
                    columns: [
                      'Client',
                      'Contact',
                      'Adresse',
                      'Montant',
                    ],
                    rows: [
                      for (var client in snapshot.data!)
                        [
                          client.nom,
                          client.contact,
                          client.adresse,
                          client.chiffreAffaire.toString(),
                        ],
                    ],
                  );
                } else if (snapshot.hasError) {
                  // ? Get any snapshot error
                  return ErrorLayout();
                }
                //todo: Loading indicator
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenSize[0],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(text: 'Chargement...'),
                        SizedBox(height: 5),
                        LinearProgressIndicator(
                          color: Color.fromRGBO(60, 141, 188, 0.15),
                          backgroundColor: Colors.transparent,
                          semanticsLabel: 'Chargement...',
                          //backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //todo: Commande en cours
          MyExpandableBox(
            headerText: 'Commandes en cours',
            seeMoreBtn: () {
              print('Chargement de la fenêtre des commandes');
              functions.openPage(
                context,
                CommandeView(),
                mode: 'pushReplacement',
              );
            },
            table: FutureBuilder<List<Commande>>(
              future: api.getCommandes(context),
              builder: (tableContext, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return MyDataTable(
                    columns: [
                      'Date commande',
                      'N° Bon',
                      'Fournisseur',
                      'Montant',
                    ],
                    rows: [
                      for (var commande in snapshot.data!)
                        [
                          commande.date,
                          commande.numeroBon.toString(),
                          commande.fournisseur,
                          commande.montant.toString(),
                        ],
                    ],
                  );
                } else if (snapshot.hasError) {
                  // ? Get any snapshot error
                  return ErrorLayout();
                }
                //todo: Loading indicator
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenSize[0],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(text: 'Chargement...'),
                        SizedBox(height: 5),
                        LinearProgressIndicator(
                          color: Color.fromRGBO(60, 141, 188, 0.15),
                          backgroundColor: Colors.transparent,
                          semanticsLabel: 'Chargement...',
                          //backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
        title: title,
        columns: columns,
        rows: rows,
      ),
    );
    setState(() {
      DrawerLayoutController.close();
    });
  }
}
