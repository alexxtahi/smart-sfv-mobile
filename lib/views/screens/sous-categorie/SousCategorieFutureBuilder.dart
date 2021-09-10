import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/SousCategorie.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class SousCategorieFutureBuilder extends StatefulWidget {
  SousCategorieFutureBuilder({Key? key}) : super(key: key);

  @override
  SousCategorieFutureBuilderState createState() =>
      SousCategorieFutureBuilderState();
}

class SousCategorieFutureBuilderState
    extends State<SousCategorieFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  ScrollController listViewScrollController = ScrollController();
  // init API instance
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return (ScreenController.actualView != "LoginView")
        ? FutureBuilder<List<SousCategorie>>(
            future: api.getSousCategories(context),
            builder: (dataTableContext, snapshot) {
              if (snapshot.hasData) {
                // ? Check if the list of sous categories is empty or not
                if (snapshot.data!.isEmpty) {
                  return Flex(
                    direction: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/img/icons/sad.png',
                              fit: BoxFit.contain,
                              width: 100,
                              height: 100,
                              color: Color.fromRGBO(60, 141, 188, 0.5),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Flexible(
                              child: MyText(
                                text:
                                    "Vous n'avez pas encore enregistré de sous categorie. Remplissez le formulaire d'ajout pour en ajouter.",
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(60, 141, 188, 0.5),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Expanded(
                    child: FadingEdgeScrollView.fromSingleChildScrollView(
                      gradientFractionOnStart: 0.05,
                      gradientFractionOnEnd: 0.2,
                      child: SingleChildScrollView(
                        controller: this.scrollController,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            //todo: Table
                            Row(
                              children: [
                                Expanded(
                                  child: FadingEdgeScrollView
                                      .fromSingleChildScrollView(
                                    gradientFractionOnStart: 0.2,
                                    gradientFractionOnEnd: 0.2,
                                    child: SingleChildScrollView(
                                      controller:
                                          this.datatableScrollController,
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      child: MyDataTable(
                                        hasRowSelectable: true,
                                        columns: [
                                          'N°',
                                          'Libellé',
                                          'Catégorie',
                                        ],
                                        rows: [
                                          for (var sousCategorie
                                              in snapshot.data!)
                                            [
                                              (snapshot.data!.indexOf(
                                                          sousCategorie) +
                                                      1)
                                                  .toString(),
                                              sousCategorie.libelle,
                                              sousCategorie.categorie.libelle,
                                            ],
                                        ],
                                        onCellLongPress: () {
                                          setState(() {
                                            // ? Check if actual DataRow is already selected or not
                                            if (MyDataTable.selectedRowIndex !=
                                                    null &&
                                                SousCategorie.sousCategorie !=
                                                    null &&
                                                SousCategorie
                                                        .sousCategorie!.id ==
                                                    snapshot
                                                        .data![MyDataTable
                                                            .selectedRowIndex!]
                                                        .id) {
                                              // When is already selected
                                              // ? Reset all sousCategorieStates
                                              SousCategorie.sousCategorie =
                                                  null;
                                              MyDataTable.selectedRowIndex =
                                                  null;
                                            } else {
                                              // When is not selected yet
                                              // ? Load SousCategorie instance for deletion
                                              SousCategorie.sousCategorie =
                                                  SousCategorie.fromJson({
                                                'id': snapshot
                                                    .data![MyDataTable
                                                        .selectedRowIndex!]
                                                    .id,
                                                'libelle_sous_categorie':
                                                    snapshot
                                                        .data![MyDataTable
                                                            .selectedRowIndex!]
                                                        .libelle,
                                                'categorie': {
                                                  'id': snapshot
                                                      .data![MyDataTable
                                                          .selectedRowIndex!]
                                                      .categorie
                                                      .id,
                                                },
                                              });
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                functions.errorSnackbar(
                  context: context,
                  message: 'Echec de récupération des sous categories',
                );
                return MyText(
                  text: snapshot.error.toString(),
                  color: Color.fromRGBO(221, 75, 57, 0.5),
                );
              }

              //todo: Loading indicator
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(
                      color: Color.fromRGBO(60, 141, 188, 1),
                      backgroundColor: Colors.transparent,
                      semanticsLabel: 'Chargement des sous categories...',
                    ),
                  ],
                ),
              );
            },
          )
        : Container();
  }
}
