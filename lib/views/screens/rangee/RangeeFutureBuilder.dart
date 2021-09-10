import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Rangee.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class RangeeFutureBuilder extends StatefulWidget {
  RangeeFutureBuilder({Key? key}) : super(key: key);

  @override
  RangeeFutureBuilderState createState() => RangeeFutureBuilderState();
}

class RangeeFutureBuilderState extends State<RangeeFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  ScrollController listViewScrollController = ScrollController();
  List<bool> rangeeStates = [];
  // init API instance
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return (ScreenController.actualView != "LoginView")
        ? FutureBuilder<List<Rangee>>(
            future: api.getRangees(context),
            builder: (dataTableContext, snapshot) {
              if (snapshot.hasData) {
                // ? Check if the list of rangee is empty or not
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
                                    "Vous n'avez pas encore enregistré de rangée. Remplissez le formulaire d'ajout pour en ajouter.",
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
                  // ? Reset rangeeStates list
                  rangeeStates = [
                    for (var rangee in snapshot.data!) false,
                  ];
                  // ? Return rangee list
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
                                color: (Rangee.rangee != null &&
                                        Rangee.rangee!.id ==
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
                                    if (Rangee.rangee != null &&
                                        Rangee.rangee!.id ==
                                            snapshot.data![index].id) {
                                      // When is already selected
                                      // ? Reset all rangeeStates
                                      Rangee.rangee = null;
                                    } else {
                                      // When is not selected yet
                                      // ? Load Rangee instance for deletion
                                      Rangee.rangee = Rangee.fromJson({
                                        'id': snapshot.data![index].id,
                                        'libelle_rangee':
                                            snapshot.data![index].libelle,
                                      });
                                    }
                                  });
                                },
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: (Rangee.rangee != null &&
                                          Rangee.rangee!.id ==
                                              snapshot.data![index].id)
                                      ? Color.fromRGBO(60, 141, 188, 1)
                                      : Color.fromRGBO(60, 141, 188, 0.15),
                                  child: MyText(
                                    text: (index + 1).toString(),
                                    color: (Rangee.rangee != null &&
                                            Rangee.rangee!.id ==
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
                  message: 'Echec de récupération des rangées',
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
                      semanticsLabel: 'Chargement des rangées...',
                    ),
                  ],
                ),
              );
            },
          )
        : Container();
  }
}
