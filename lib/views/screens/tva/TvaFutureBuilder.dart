import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/models/Tva.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class TvaFutureBuilder extends StatefulWidget {
  TvaFutureBuilder({Key? key}) : super(key: key);

  @override
  TvaFutureBuilderState createState() => TvaFutureBuilderState();
}

class TvaFutureBuilderState extends State<TvaFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  ScrollController listViewScrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Tva>>(
      future: this.fetchTvas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // ? Check if the list of Tvas is empty or not
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
                            color: Color.fromRGBO(60, 141, 188, 0.5),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Flexible(
                            child: MyText(
                              text:
                                  "Vous n'avez pas encore ajouté de taxe. Remplissez le formulaire d'ajout pour en ajouter.",
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
                                    scrollDirection: Axis.vertical,
                                    child: ListView.separated(
                                      controller: this.listViewScrollController,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      scrollDirection: Axis
                                          .vertical, // direction of scrolling
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 20.0),
                                      itemBuilder: (context, index) {
                                        // other cards
                                        return ListTile(
                                          enableFeedback: true,
                                          onTap: () {
                                            print(snapshot.data![index].percent
                                                    .toString() +
                                                ' on tap !');
                                          },
                                          onLongPress: () {
                                            print(snapshot.data![index].percent
                                                    .toString() +
                                                ' long press !');
                                          },
                                          leading: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Color.fromRGBO(
                                                60, 141, 188, 0.15),
                                            child: MyText(
                                              text: (index + 1).toString(),
                                              color: Color.fromRGBO(
                                                  60, 141, 188, 1),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          title: MyText(
                                            text: snapshot.data![index].percent
                                                .toString(),
                                            //fontWeight: FontWeight.bold,
                                          ),
                                          selectedTileColor: Color.fromRGBO(
                                              60, 141, 188, 0.15),
                                          focusColor: Color.fromRGBO(
                                              60, 141, 188, 0.15),
                                          hoverColor: Color.fromRGBO(
                                              60, 141, 188, 0.15),
                                        );
                                      },
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
          functions.errorSnackbar(
            context: context,
            message: 'Echec de récupération des taxes',
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
                semanticsLabel: 'Chargement des taxes',
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<Tva>>? fetchTvas() async {
    // init API instance
    Api api = Api();
    // call API method getTvas
    Future<List<Tva>> tvas = api.getTvas(context);
    // return results
    return tvas;
  }
}
