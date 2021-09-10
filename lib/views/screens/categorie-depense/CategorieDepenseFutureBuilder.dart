import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/CategorieDepense.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class CategorieDepenseFutureBuilder extends StatefulWidget {
  CategorieDepenseFutureBuilder({Key? key}) : super(key: key);

  @override
  CategorieDepenseFutureBuilderState createState() =>
      CategorieDepenseFutureBuilderState();
}

class CategorieDepenseFutureBuilderState
    extends State<CategorieDepenseFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  ScrollController listViewScrollController = ScrollController();
  List<bool> categorieDepenseStates = [];
  // init API instance
  Api api = Api();
  @override
  Widget build(BuildContext context) {
    return (ScreenController.actualView != "LoginView")
        ? FutureBuilder<List<CategorieDepense>>(
            future: api.getCategorieDepenses(context),
            builder: (dataTableContext, snapshot) {
              if (snapshot.hasData) {
                // ? Check if the list of categorieDepense is empty or not
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
                                    "Vous n'avez pas encore enregistré de catégorie de dépenses. Remplissez le formulaire d'ajout pour en ajouter.",
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
                  // ? Reset categorieDepenseStates list
                  categorieDepenseStates = [
                    for (var categorieDepense in snapshot.data!) false,
                  ];
                  // ? Return categorieDepense list
                  return Expanded(
                    child: FadingEdgeScrollView.fromSingleChildScrollView(
                      gradientFractionOnStart: 0.05,
                      gradientFractionOnEnd: 0.2,
                      child: SingleChildScrollView(
                        controller: this.scrollController,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: ListView.separated(
                          controller: this.listViewScrollController,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          scrollDirection:
                              Axis.vertical, // direction of scrolling
                          separatorBuilder: (separatorContext, index) =>
                              SizedBox(width: 20.0),
                          itemBuilder: (itemBuilderContext, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: (CategorieDepense.categorieDepense !=
                                            null &&
                                        CategorieDepense.categorieDepense!.id ==
                                            snapshot.data![index].id)
                                    ? Color.fromRGBO(60, 141, 188, 0.15)
                                    : null,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                enableFeedback: true,
                                onTap: () {
                                  print(snapshot.data![index].libelle +
                                      ' on tap !');
                                },
                                onLongPress: () {
                                  print(snapshot.data![index].id.toString() +
                                      ' -> ' +
                                      snapshot.data![index].libelle +
                                      ' long press !');
                                  setState(() {
                                    // ? Check if actual ListTile is already selected or not
                                    if (CategorieDepense.categorieDepense !=
                                            null &&
                                        CategorieDepense.categorieDepense!.id ==
                                            snapshot.data![index].id) {
                                      // When is already selected
                                      // ? Reset all categorieDepenseStates
                                      CategorieDepense.categorieDepense = null;
                                    } else {
                                      // When is not selected yet
                                      // ? Load CategorieDepense instance for deletion
                                      CategorieDepense.categorieDepense =
                                          CategorieDepense.fromJson({
                                        'id': snapshot.data![index].id,
                                        'libelle_categorie_depense':
                                            snapshot.data![index].libelle,
                                      });
                                    }
                                  });
                                },
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      (CategorieDepense.categorieDepense !=
                                                  null &&
                                              CategorieDepense
                                                      .categorieDepense!.id ==
                                                  snapshot.data![index].id)
                                          ? Color.fromRGBO(60, 141, 188, 1)
                                          : Color.fromRGBO(60, 141, 188, 0.15),
                                  child: MyText(
                                    text: (index + 1).toString(),
                                    color: (CategorieDepense.categorieDepense !=
                                                null &&
                                            CategorieDepense
                                                    .categorieDepense!.id ==
                                                snapshot.data![index].id)
                                        ? Colors.white
                                        : Color.fromRGBO(60, 141, 188, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                title: MyText(
                                  text: snapshot.data![index].libelle,
                                  //fontWeight: FontWeight.bold,
                                ),
                                selectedTileColor:
                                    Color.fromRGBO(60, 141, 188, 0.5),
                                focusColor: Color.fromRGBO(60, 141, 188, 0.15),
                                hoverColor: Color.fromRGBO(60, 141, 188, 0.15),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                functions.errorSnackbar(
                  context: context,
                  message: 'Echec de récupération des catégories de dépenses',
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
                      semanticsLabel:
                          'Chargement des catégories de dépenses...',
                    ),
                  ],
                ),
              );
            },
          )
        : Container();
  }
}
