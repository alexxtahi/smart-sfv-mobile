import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/AchatClient.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/views/screens/client/FicheClientView.dart';

class ClientFutureBuilder extends StatefulWidget {
  ClientFutureBuilder({Key? key}) : super(key: key);

  @override
  ClientFutureBuilderState createState() => ClientFutureBuilderState();
}

class ClientFutureBuilderState extends State<ClientFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  // init API instance
  Api api = Api();

  //todo: setState function for the childrens
  void setstate(Function childSetState) {
    /*
    * This function is made to set state of this widget by this childrens
    */
    setState(() {
      childSetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return (ScreenController.actualView != "LoginView")
        ? FutureBuilder<List<Client>>(
            future: api.getClients(context),
            builder: (dataTableContext, snapshot) {
              if (snapshot.hasData) {
                // ? Check if the list of clients is empty or not
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
                                    "Vous n'avez pas encore ajouté de client. Remplissez le formulaire d'ajout pour en ajouter.",
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
                                          'Nº',
                                          'Code',
                                          'Nom du client',
                                          'Contact',
                                          'Pays',
                                          'Régime',
                                          'E-mail',
                                          'Adresse',
                                          'Montant plafond',
                                          'Compte contr.'
                                        ],
                                        rows: [
                                          for (var client in snapshot.data!)
                                            [
                                              (snapshot.data!.indexOf(client) +
                                                      1)
                                                  .toString(),
                                              client.code,
                                              client.nom,
                                              client.contact,
                                              client.pays.libelle,
                                              client.regime.libelle,
                                              client.email,
                                              client.adresse,
                                              client.montantPlafond.toString() +
                                                  ' FCFA',
                                              client.compteContrib,
                                            ],
                                        ],
                                        onCellLongPress: () {
                                          if (MyDataTable.selectedRowIndex !=
                                              null) {
                                            // ? Load Client instance
                                            Client.client = Client.fromInstance(
                                                snapshot.data![MyDataTable
                                                    .selectedRowIndex!]);
                                          }
                                          // ? Open view of the client fiche
                                          functions.openPage(
                                            context,
                                            FicheClientView(
                                              parentSetState: setstate,
                                            ),
                                          );
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
                  message: 'Echec de récupération des clients',
                );
                return MyText(
                  text: snapshot.error.toString(),
                  color: Color.fromRGBO(60, 141, 188, 0.5),
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
                      semanticsLabel: 'Chargement des clients...',
                    ),
                  ],
                ),
              );
            },
          )
        : Container();
  }
}
