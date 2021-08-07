import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class ClientFutureBuilder extends StatefulWidget {
  ClientFutureBuilder({Key? key}) : super(key: key);

  @override
  ClientFutureBuilderState createState() => ClientFutureBuilderState();
}

class ClientFutureBuilderState extends State<ClientFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Client>>(
      future: this.fetchClients(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // ? Check if the list of clients is empty or not
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
                                            client.code,
                                            client.nom,
                                            client.contact,
                                            client.pays,
                                            client.regime,
                                            client.email,
                                            client.adresse,
                                            client.montantPlafond.toString(),
                                            client.compteContrib,
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
                semanticsLabel: 'Chargement des clients',
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<Client>>? fetchClients() async {
    // init API instance
    Api api = Api();
    // call API method getClients
    Future<List<Client>> clients = api.getClients(context);
    // return results
    return clients;
  }
}
