import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/models/Commande.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/views/layouts/ErrorLayout.dart';

class CommandeFutureBuilder extends StatefulWidget {
  CommandeFutureBuilder({Key? key}) : super(key: key);

  @override
  CommandeFutureBuilderState createState() => CommandeFutureBuilderState();
}

class CommandeFutureBuilderState extends State<CommandeFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  // init API instance
  Api api = Api();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Commande>>(
      future: api.getCommandes(context),
      builder: (dataTableContext, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // ? Check if the list of commandes is empty or not
          return (snapshot.data!.isEmpty)
              ? ErrorLayout(
                  image: 'assets/img/icons/no-wifi.png',
                  message:
                      "Nous n'arrivons à charger vos commandes. Vérifiez votre connexion internet.",
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
                                        'Bon',
                                        'Date',
                                        'N° bon de commande',
                                        'Fournisseur',
                                        'Montant total',
                                      ],
                                      rows: [
                                        for (var commande in snapshot.data!)
                                          [
                                            (snapshot.data!.indexOf(commande) +
                                                    1)
                                                .toString(),
                                            commande.date.toString(),
                                            commande.numeroBon.toString(),
                                            commande.fournisseur.toString(),
                                            commande.montant.toString() +
                                                ' FCFA',
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
          functions.errorSnackbar(
            context: context,
            message: 'Echec de récupération des commandes',
          );
          return ErrorLayout(
            image: 'assets/img/icons/no-wifi.png',
            message:
                "Nous n'arrivons à charger vos commandes. Vérifiez votre connexion internet.",
          );
        }

        //todo: Loading indicator
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                color: Color.fromRGBO(0, 27, 121, 1),
                backgroundColor: Colors.transparent,
                semanticsLabel: 'Chargement des commandes',
              ),
            ],
          ),
        );
      },
    );
  }
}
