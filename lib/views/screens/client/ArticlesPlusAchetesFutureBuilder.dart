import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Article.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class ArticlesPlusAchetesFutureBuilder extends StatefulWidget {
  ArticlesPlusAchetesFutureBuilder({Key? key}) : super(key: key);

  @override
  ArticlesPlusAchetesFutureBuilderState createState() =>
      ArticlesPlusAchetesFutureBuilderState();
}

class ArticlesPlusAchetesFutureBuilderState
    extends State<ArticlesPlusAchetesFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  // init API instance
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return (ScreenController.actualView != "LoginView" && Client.client != null)
        ? FutureBuilder<List<Article>>(
            future: api.getArticlesPlusAchetes(Client.client!.id),
            builder: (dataTableContext, snapshot) {
              if (snapshot.hasData) {
                // ? Check if the list of articles is empty or not
                return (snapshot.data!.isEmpty)
                    ? Column(
                        children: [
                          //todo: Articles les plus achetés
                          MyText(
                            text: "Articles les plus achetés",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          SizedBox(height: 10),
                          //todo: Empty message
                          Flex(
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
                                            "Ce client n'a pas encore acheter d'articles",
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromRGBO(60, 141, 188, 0.5),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          //todo: Articles les plus achetés
                          MyText(
                            text: "Articles les plus achetés",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          SizedBox(height: 10),
                          //todo: DataTable
                          Row(
                            children: [
                              Expanded(
                                child: FadingEdgeScrollView
                                    .fromSingleChildScrollView(
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
                                                  controller: this
                                                      .datatableScrollController,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: MyDataTable(
                                                    columns: [
                                                      'Nº',
                                                      'Article',
                                                      'Quantité',
                                                      'Montant',
                                                    ],
                                                    rows: [
                                                      for (var article
                                                          in snapshot.data!)
                                                        [
                                                          (snapshot.data!.indexOf(
                                                                      article) +
                                                                  1)
                                                              .toString(),
                                                          article.description,
                                                          article
                                                              .quantiteAchetee
                                                              .toString(),
                                                          article.sommeTotaleAchetee
                                                                  .toString() +
                                                              ' FCFA',
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
                              ),
                            ],
                          ),
                        ],
                      );
              } else if (snapshot.hasError) {
                functions.errorSnackbar(
                  context: context,
                  message: 'Echec de récupération des articles',
                );
                return MyText(
                  text: snapshot.error.toString(),
                  color: Color.fromRGBO(60, 141, 188, 0.5),
                );
              }

              //todo: Loading indicator
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Color.fromRGBO(60, 141, 188, 1),
                        backgroundColor: Colors.transparent,
                        semanticsLabel: 'Chargement des articles du client...',
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Container();
  }
}
