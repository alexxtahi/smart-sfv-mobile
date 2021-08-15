import 'package:smartsfv/functions.dart' as functions;
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:intl/intl.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/pdf.dart' as pdf;
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/layouts/ErrorLayout.dart';
// PDF packages
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ListTableView extends StatefulWidget {
  final String title;
  final List<String> columns;
  final List<List<String>> rows;
  final String listName;
  ListTableView({
    Key? key,
    required this.columns,
    this.rows = const [],
    this.title = 'Nouvelle liste',
    this.listName = 'Nouvelle liste',
  }) : super(key: key);
  @override
  ListTableViewState createState() => ListTableViewState();
}

class ListTableViewState extends State<ListTableView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime now = DateTime.now();
  List<List<String>> docDatas = [];

  @override
  Widget build(BuildContext context) {
    GlobalKey scaffold = GlobalKey();
    List<double> screenSize = ScreenController.getScreenSize(context);
    if (ScreenController.actualView != "LoginView")
      ScreenController.actualView = "ListTableView";
    // Change system UI properties
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    // lock screen orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Return building scaffold
    return Scaffold(
      key: scaffold,
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        onPressed: () async {
          // ? Show loading dialog
          functions.showFormDialog(
            scaffold.currentContext,
            GlobalKey<FormState>(),
            hasCancelButton: false,
            hasHeaderIcon: false,
            hasHeaderTitle: false,
            hasSnackbar: false,
            hasValidationButton: false,
            barrierDismissible: false,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            formElements: [
              Image.asset(
                'assets/img/icons/document.png',
                fit: BoxFit.contain,
                width: 70,
                height: 70,
              ),
              SizedBox(height: 10),
              MyText(text: "Génération du PDF en cours..."),
              SizedBox(height: 20),
              Container(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(60, 141, 188, 1),
                  backgroundColor: Color.fromRGBO(60, 141, 188, 0.1),
                ),
              )
            ],
          );
          // ? Call generate PDF method
          String result = await pdf.generatePDF(
              widget.title, widget.columns, this.docDatas);
          // ? Check result to give response to the user
          Navigator.of(context).pop(); // remove the AlertDialog to the screen
          if (result == "Document enregistré") {
            functions.successSnackbar(
              context: scaffold.currentContext,
              message: "Document PDF enregistré !",
            );
          } else if (result == "Enregistrement annulé") {
            functions.showMessageToSnackbar(
              context: scaffold.currentContext,
              message: "Enregistrement annulé",
              icon: Icon(
                Icons.file_download_off_rounded,
                color: Colors.red,
              ),
            );
          } else {
            functions.errorSnackbar(
              context: scaffold.currentContext,
              message: "Une erreur s'est produite lors de la génération du PDF",
            );
          }
        },
        backgroundColor: Color.fromRGBO(60, 141, 188, 1),
        child: Tooltip(
          message: 'Imprimer',
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(60, 141, 188, 1),
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
          ),
          child: Icon(
            Icons.print_rounded,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: MyText(
          text: widget.title,
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.2),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //todo: Scrolling View
              Expanded(
                child: FadingEdgeScrollView.fromSingleChildScrollView(
                  gradientFractionOnStart: 0.05,
                  gradientFractionOnEnd: 0.2,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        //todo: Table
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FadingEdgeScrollView
                                  .fromSingleChildScrollView(
                                gradientFractionOnStart: 0.2,
                                gradientFractionOnEnd: 0.2,
                                child: SingleChildScrollView(
                                  controller: datatableScrollController,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: FutureBuilder<List<dynamic>>(
                                    future: getList(),
                                    builder: (tableContext, snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        switch (widget.listName) {
                                          //todo: Liste des articles en voie de péremption
                                          case 'getArticlesPeremption':
                                            this.docDatas = [
                                              for (var article
                                                  in snapshot.data!)
                                                [
                                                  article.libelleDepot,
                                                  article.description,
                                                  article.libelleUnite,
                                                  // get expiration date
                                                  dateFormat.format(
                                                      DateTime.parse(article
                                                          .datePeremption)),
                                                  // compute difference between expiration date and now
                                                  DateTime.parse(article
                                                              .datePeremption)
                                                          .difference(now)
                                                          .inDays
                                                          .toString() +
                                                      ' jours',
                                                ],
                                            ];
                                            return MyDataTable(
                                              columns: widget.columns,
                                              rows: this.docDatas,
                                            );
                                          //todo: Liste des articles en voie de rupture
                                          case 'getArticlesRupture':
                                            this.docDatas = [
                                              for (var article
                                                  in snapshot.data!)
                                                [
                                                  article.description,
                                                  article.categorie,
                                                  article.subCategorie,
                                                  article.qteEnStock.toString(),
                                                  article.libelleDepot,
                                                ],
                                            ];
                                            return MyDataTable(
                                              columns: widget.columns,
                                              rows: this.docDatas,
                                            );
                                          //todo: Liste des meilleurs clients
                                          case 'getBestClients':
                                            this.docDatas = [
                                              for (var client in snapshot.data!)
                                                [
                                                  client.nom,
                                                  client.contact,
                                                  client.chiffreAffaire
                                                      .toString(),
                                                ],
                                            ];
                                            return MyDataTable(
                                              columns: widget.columns,
                                              rows: this.docDatas,
                                            );
                                          //todo: Liste des clients les moins rentables
                                          case 'getWorstRentabilityClients':
                                            this.docDatas = [
                                              for (var client in snapshot.data!)
                                                [
                                                  client.nom,
                                                  client.contact,
                                                  client.chiffreAffaire
                                                      .toString(),
                                                ],
                                            ];
                                            return MyDataTable(
                                              columns: widget.columns,
                                              rows: this.docDatas,
                                            );
                                          //todo: Liste des meilleurs articles
                                          case 'getBestArticles':
                                            this.docDatas = [
                                              for (var article
                                                  in snapshot.data!)
                                                [
                                                  article.description,
                                                  article.qteEnStock.toString(),
                                                  article.prixVenteTTC
                                                      .toString(),
                                                ],
                                            ];
                                            return MyDataTable(
                                              columns: widget.columns,
                                              rows: this.docDatas,
                                            );
                                          //todo: Liste des pires articles
                                          case 'getWorstArticles':
                                            this.docDatas = [
                                              for (var article
                                                  in snapshot.data!)
                                                [
                                                  article.description,
                                                  article.qteEnStock.toString(),
                                                  article.prixVenteTTC
                                                      .toString(),
                                                ],
                                            ];
                                            return MyDataTable(
                                              columns: widget.columns,
                                              rows: this.docDatas,
                                            );
                                          //todo: Liste des clients les plus endettés
                                          case 'getDettesClients':
                                            this.docDatas = [
                                              for (var client in snapshot.data!)
                                                [
                                                  client.nom,
                                                  client.contact,
                                                  client.adresse,
                                                  client.chiffreAffaire
                                                      .toString(),
                                                ],
                                            ];
                                            return MyDataTable(
                                              columns: widget.columns,
                                              rows: this.docDatas,
                                            );
                                          default:
                                            return ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: screenSize[0],
                                                maxHeight: screenSize[1],
                                              ),
                                              child: Center(
                                                child: ErrorLayout(
                                                  message:
                                                      "Aucune donnée à afficher.",
                                                ),
                                              ),
                                            );
                                        }
                                      }
                                      //todo: Loading indicator
                                      return ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: screenSize[0],
                                        ),
                                        child: LinearProgressIndicator(
                                          color:
                                              Color.fromRGBO(60, 141, 188, 1),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> getList() async {
    // init API instance
    Api api = Api();
    // call API method getdynamics
    List<dynamic> list = [];
    // ? Switch with the listName to call adequate function
    switch (widget.listName) {
      //todo: Articles en voie de péremption
      case 'getArticlesPeremption':
        list = await api.getArticlesPeremption(context);
        break;
      //todo: Articles en voie de rupture
      case 'getArticlesRupture':
        list = await api.getArticlesRupture(context);
        break;
      //todo: Liste des meilleurs clients
      case 'getBestClients':
        list = await api.getBestClients(context);
        break;
      //todo: Liste des clients les moins rentables
      case 'getWorstRentabilityClients':
        list = await api.getWorstRentabilityClients(context);
        break;
      //todo: Articles les plus rentables
      case 'getBestArticles':
        list = await api.getBestArticles(context);
        break;
      //todo: Articles les moins rentables
      case 'getWorstArticles':
        list = await api.getWorstArticles(context);
        break;
      //todo: Liste des clients les plus endettés
      case 'getDettesClients':
        list = await api.getDettesClients(context);
        break;
      //todo: Liste des commandes
      case 'getCommandes':
        list = await api.getCommandes(context);
        break;
      //todo: In all other cases
      default:
        list = [];
        break;
    }
    // return results
    return list;
  }
}
