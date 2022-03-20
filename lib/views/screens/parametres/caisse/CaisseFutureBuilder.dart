import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Caisse.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class CaisseFutureBuilder extends StatefulWidget {
  CaisseFutureBuilder({Key? key}) : super(key: key);

  @override
  CaisseFutureBuilderState createState() => CaisseFutureBuilderState();
}

class CaisseFutureBuilderState extends State<CaisseFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  ScrollController listViewScrollController = ScrollController();
  // init API instance
  Api api = Api();
  @override
  Widget build(BuildContext context) {
    return (ScreenController.actualView != "LoginView")
        ? FutureBuilder<List<Caisse>>(
            future: api.getCaisses(context),
            builder: (dataTableContext, snapshot) {
              if (snapshot.hasData) {
                // ? Check if the list of caisses is empty or not
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
                                    "Vous n'avez pas encore enregistré de caisse. Remplissez le formulaire d'ajout pour en ajouter.",
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
                                          'Dépôt',
                                        ],
                                        rows: [
                                          for (var caisse in snapshot.data!)
                                            [
                                              (snapshot.data!.indexOf(caisse) +
                                                      1)
                                                  .toString(),
                                              caisse.libelle,
                                              caisse.depot.libelle,
                                            ],
                                        ],
                                        onCellLongPress: () {
                                          setState(() {
                                            // ? Check if actual DataRow is already selected or not
                                            if (MyDataTable.selectedRowIndex !=
                                                    null &&
                                                Caisse.caisse != null &&
                                                Caisse.caisse!.id ==
                                                    snapshot
                                                        .data![MyDataTable
                                                            .selectedRowIndex!]
                                                        .id) {
                                              // When is already selected
                                              // ? Reset all caisseStates
                                              Caisse.caisse = null;
                                              MyDataTable.selectedRowIndex =
                                                  null;
                                            } else {
                                              // When is not selected yet
                                              // ? Load Caisse instance for deletion
                                              Caisse.caisse = Caisse.fromJson({
                                                'id': snapshot
                                                    .data![MyDataTable
                                                        .selectedRowIndex!]
                                                    .id,
                                                'libelle_caisse': snapshot
                                                    .data![MyDataTable
                                                        .selectedRowIndex!]
                                                    .libelle,
                                                'depot': {
                                                  'id': snapshot
                                                      .data![MyDataTable
                                                          .selectedRowIndex!]
                                                      .depot
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
                  message: 'Echec de récupération des caisses',
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
                      semanticsLabel: 'Chargement des caisses',
                    ),
                  ],
                ),
              );
            },
          )
        : Container();
  }
}
