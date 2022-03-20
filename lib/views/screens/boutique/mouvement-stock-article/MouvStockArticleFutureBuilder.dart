import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/MouvStockArticle.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class MouvStockArticleFutureBuilder extends StatefulWidget {
  MouvStockArticleFutureBuilder({Key? key}) : super(key: key);

  @override
  MouvStockArticleFutureBuilderState createState() =>
      MouvStockArticleFutureBuilderState();
}

class MouvStockArticleFutureBuilderState
    extends State<MouvStockArticleFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  ScrollController listViewScrollController = ScrollController();
  // init API instance
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return (ScreenController.actualView != "LoginView")
        ? /*FutureBuilder<List<MouvStockArticle>>(
            future: api.getMouvStockArticles(context),
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
                                    "Il n'y'a pas encore de mouvement stock article",
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
                                          'Code barre',
                                          'Article',
                                          'Dépôt',
                                          'Quantité initiale',
                                          'Quantité approximative',
                                          'Quantité déstockée',
                                          'Quantité transférée',
                                          'Quantité vendue',
                                        ],
                                        rows: [
                                          for (var mouvement in snapshot.data!)
                                            [
                                              (snapshot.data!
                                                          .indexOf(mouvement) +
                                                      1)
                                                  .toString(),
                                              mouvement.article.codeBarre,
                                              mouvement.article.description,
                                              mouvement.depot.libelle,
                                              mouvement.qteInit.toString(),
                                              mouvement.qteApprox.toString(),
                                              mouvement.qteDestock.toString(),
                                              mouvement.qteTransf.toString(),
                                              mouvement.qteVendue.toString(),
                                            ],
                                        ],
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
                  message: 'Echec de récupération des données',
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
                      semanticsLabel: 'Chargement des données...',
                    ),
                  ],
                ),
              );
            },
          )
        : */Container() : Container();
  }
}
