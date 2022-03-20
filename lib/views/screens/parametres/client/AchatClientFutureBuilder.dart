import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/AchatClient.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class AchatClientFutureBuilder extends StatefulWidget {
  AchatClientFutureBuilder({Key? key}) : super(key: key);

  @override
  AchatClientFutureBuilderState createState() =>
      AchatClientFutureBuilderState();
}

class AchatClientFutureBuilderState extends State<AchatClientFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  // init API instance
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return (ScreenController.actualView != "LoginView" && Client.client != null)
        ? FutureBuilder<List<AchatClient>>(
            future: api.getAchatClients(id: Client.client!.id),
            builder: (dataTableContext, snapshot) {
              if (snapshot.hasData) {
                // ? Check if the list of achatClients is empty or not
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
                                        "Ce client n'a pas encore fait d'achat",
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
                    : Row(
                        children: [
                          Expanded(
                            child:
                                FadingEdgeScrollView.fromSingleChildScrollView(
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
                                              physics: BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              child: MyDataTable(
                                                columns: [
                                                  'Nº',
                                                  'Date',
                                                  'Facture',
                                                  'Dépôt',
                                                  'Montant TTC',
                                                  'Remise',
                                                  'Acompte',
                                                  'Reste',
                                                ],
                                                rows: [
                                                  for (var achatClient
                                                      in snapshot.data!)
                                                    [
                                                      (snapshot.data!.indexOf(
                                                                  achatClient) +
                                                              1)
                                                          .toString(),
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(achatClient
                                                              .dateVentes),
                                                      achatClient.numeroFacture,
                                                      achatClient.depot.libelle,
                                                      achatClient.sommeTotale
                                                              .toString() +
                                                          ' FCFA',
                                                      achatClient.sommeRemise
                                                              .toString() +
                                                          ' FCFA',
                                                      achatClient.acompteFacture
                                                              .toString() +
                                                          ' FCFA',
                                                      achatClient.reste
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
                                    SizedBox(height: 20),
                                    Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      runAlignment: WrapAlignment.spaceBetween,
                                      children: [
                                        //todo: Total Achat
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              MyText(
                                                text: AchatClient.totalAchat
                                                        .toString() +
                                                    ' FCFA',
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    (AchatClient.totalAchat !=
                                                            0)
                                                        ? Colors.green
                                                        : Colors.black,
                                                fontSize: 24,
                                              ),
                                              MyText(
                                                text: 'TOTAL ACHAT',
                                                fontSize: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                        //todo: Total Remise
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              MyText(
                                                text: AchatClient.totalRemise
                                                        .toString() +
                                                    ' FCFA',
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    (AchatClient.totalRemise !=
                                                            0)
                                                        ? Colors.orange
                                                        : Colors.black,
                                                fontSize: 24,
                                              ),
                                              MyText(
                                                text: 'TOTAL REMISE',
                                                fontSize: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                        //todo: Total Acompte
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              MyText(
                                                text: AchatClient.totalAcompte
                                                        .toString() +
                                                    ' FCFA',
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    (AchatClient.totalAcompte !=
                                                            0)
                                                        ? Colors.green
                                                        : Colors.black,
                                                fontSize: 24,
                                              ),
                                              MyText(
                                                text: 'TOTAL ACOMPTE',
                                                fontSize: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                        //todo: Total Reste
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              MyText(
                                                text: (AchatClient.totalAchat -
                                                            AchatClient
                                                                .totalRemise)
                                                        .toString() +
                                                    ' FCFA',
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    (AchatClient.totalAchat !=
                                                            0)
                                                        ? Colors.red
                                                        : Colors.black,
                                                fontSize: 24,
                                              ),
                                              MyText(
                                                text: 'TOTAL RESTE',
                                                fontSize: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              } else if (snapshot.hasError) {
                functions.errorSnackbar(
                  context: context,
                  message: 'Echec de récupération des achatClients',
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
