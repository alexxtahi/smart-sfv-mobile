import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/models/Article.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class ArticleFutureBuilder extends StatefulWidget {
  ArticleFutureBuilder({Key? key}) : super(key: key);

  @override
  ArticleFutureBuilderState createState() => ArticleFutureBuilderState();
}

class ArticleFutureBuilderState extends State<ArticleFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: this.fetchArticle(),
      builder: (dataTablecontext, snapshot) {
        if (snapshot.hasData) {
          return (snapshot.data!.isEmpty)
              ? Flex(
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
                            color: Color.fromRGBO(231, 57, 0, 0.5),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Flexible(
                            child: MyText(
                              text:
                                  "Vous n'avez aucun article en stock. Remplissez le formulaire d'ajout pour en ajouter.",
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(231, 57, 0, 0.5),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Expanded(
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
                                    controller: this.datatableScrollController,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: MyDataTable(
                                      columns: [
                                        'Nº',
                                        'Code barre',
                                        'Article',
                                        'Catégorie',
                                        'En stock',
                                        "Prix d'achat TTC",
                                        "Prix d'achat HT",
                                        "Prix de vente TTC",
                                        "Prix de vente HT",
                                        'Fournisseur(s)',
                                        'TVA',
                                        'Stock minimum',
                                      ],
                                      rows: [
                                        for (var article in snapshot.data!)
                                          [
                                            (snapshot.data!.indexOf(article) +
                                                    1)
                                                .toString(),
                                            article.codeBarre,
                                            article.description,
                                            article.categorie,
                                            article.enStock.toString(),
                                            article.prixAchatTTC.toString(),
                                            article.prixAchatHT.toString(),
                                            article.prixVenteTTC.toString(),
                                            article.prixVenteHT.toString(),
                                            article.fournisseur,
                                            article.tva.toString(),
                                            article.stockMin.toString(),
                                          ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              //return Text(snapshot.data.imgPlat);
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        } else if (snapshot.hasError) {
          //print("Données non récupérables");
          functions.errorSnackbar(
            context: context,
            message: 'Echec de récupération des articles',
          );
          return MyText(
            text: snapshot.error.toString(),
            color: Colors.red,
          );
        }

        //todo: Loading indicator
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                color: Color.fromRGBO(231, 57, 0, 1),
                backgroundColor: Colors.transparent,
                semanticsLabel: 'Chargement des articles',
                //backgroundColor: Color.fromRGBO(243, 156, 18, 0.15),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<Article>>? fetchArticle() async {
    // init API instance
    Api api = Api();
    // call API method getArticles
    Future<List<Article>> articles = api.getArticles(context);
    // return results
    return articles;
  }
}
