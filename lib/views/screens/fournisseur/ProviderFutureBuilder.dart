import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/models/Fournisseur.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class ProviderFutureBuilder extends StatefulWidget {
  ProviderFutureBuilder({Key? key}) : super(key: key);

  @override
  ProviderFutureBuilderState createState() => ProviderFutureBuilderState();
}

class ProviderFutureBuilderState extends State<ProviderFutureBuilder> {
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Fournisseur>>(
      future: this.fetchFournisseurs(),
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
                            color: Color.fromRGBO(187, 0, 0, 0.5),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Flexible(
                            child: MyText(
                              text:
                                  "Vous n'avez pas encore de fournisseurs. Remplissez le formulaire d'ajout pour en ajouter.",
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(187, 0, 0, 0.5),
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
                                        'Nom du fournisseur',
                                        'Contact',
                                        'Pays',
                                        'Banque',
                                        'Compte banque',
                                        'E-mail',
                                        'Boîte postale',
                                        'Adresse',
                                        'Fax',
                                        'Compte contr.'
                                      ],
                                      rows: [
                                        for (var fournisseur in snapshot.data!)
                                          [
                                            fournisseur.code,
                                            fournisseur.nom,
                                            fournisseur.contact,
                                            fournisseur.pays,
                                            fournisseur.banque,
                                            fournisseur.compteBanque,
                                            fournisseur.email,
                                            fournisseur.boitePostale,
                                            fournisseur.adresse,
                                            fournisseur.fax,
                                            fournisseur.compteContrib,
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
            message: 'Echec de récupération des fournisseurs',
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
                color: Color.fromRGBO(221, 75, 57, 1),
                backgroundColor: Colors.transparent,
                semanticsLabel: 'Chargement des fournisseurs',
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<Fournisseur>>? fetchFournisseurs() async {
    // init API instance
    Api api = Api();
    // call API method getFournisseurs
    Future<List<Fournisseur>> fournisseurs = api.getFournisseurs(context);
    // return results
    return fournisseurs;
  }
}
