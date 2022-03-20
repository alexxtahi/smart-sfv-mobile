import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Reglement.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class ReglementFutureBuilder extends StatefulWidget {
  ReglementFutureBuilder({Key? key}) : super(key: key);

  @override
  ReglementFutureBuilderState createState() => ReglementFutureBuilderState();
}

class ReglementFutureBuilderState extends State<ReglementFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  // init API instance
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return (ScreenController.actualView != "LoginView" && Client.client != null)
        ? FutureBuilder<List<Reglement>>(
            future: api.getReglements(id: Client.client!.id),
            builder: (dataTableContext, snapshot) {
              if (snapshot.hasData) {
                // ? Check if the list of reglements is empty or not
                return (snapshot.data!.isEmpty)
                    ? Column(
                        children: [
                          //todo: Liste des règlements
                          MyText(
                            text: "Liste des règlements",
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
                                            "Ce client n'a pas encore fait de règlement",
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
                          //todo: Liste des règlements
                          MyText(
                            text: "Liste des règlements",
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
                                                      'Reçu',
                                                      'Date',
                                                      'Moyen de paiement',
                                                      'Montant',
                                                      'Objet',
                                                      'N° virement ou chèque',
                                                      'Chèque',
                                                    ],
                                                    rows: [
                                                      for (var reglement
                                                          in snapshot.data!)
                                                        [
                                                          (snapshot.data!.indexOf(
                                                                      reglement) +
                                                                  1)
                                                              .toString(),
                                                          reglement.montant
                                                              .toString(),
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(reglement
                                                                  .date),
                                                          reglement
                                                              .moyenReglement
                                                              .libelle,
                                                          reglement.montant
                                                                  .toString() +
                                                              ' FCFA',
                                                          reglement.objet,
                                                          reglement
                                                              .numeroChequeVirement,
                                                          reglement.scanCheque,
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
                  message: 'Echec de récupération des reglements',
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
                        semanticsLabel: 'Chargement des achats du client...',
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
