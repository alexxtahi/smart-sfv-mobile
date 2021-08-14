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
  GlobalKey scaffold = GlobalKey();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime now = DateTime.now();
  List<List<String>> docDatas = [];

  @override
  Widget build(BuildContext context) {
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
          // ? Showing loading message
          functions.showMessageToSnackbar(
            context: context,
            message: "Génération du document PDF",
            icon: CircularProgressIndicator(
              color: Color.fromRGBO(60, 141, 188, 1),
              backgroundColor: Colors.white.withOpacity(0.1),
              strokeWidth: 5,
            ),
          );
          // ? Call generate PDF method
          pdf.generatePDF(widget.title, widget.columns, this.docDatas);
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

  //todo: Method to print a PDF document
  Future<void> printPDF() async {
    try {
      // PDF instance
      // ? Get assets fonts for the document
      final Map<String, pw.TtfFont> montserrat = {
        'regular': await fontFromAssetBundle(
            'assets/fonts/Montserrat/Montserrat-Regular.ttf'),
        'semibold': await fontFromAssetBundle(
            'assets/fonts/Montserrat/Montserrat-SemiBold.ttf'),
        'bold': await fontFromAssetBundle(
            'assets/fonts/Montserrat/Montserrat-Bold.ttf'),
        'extrabold': await fontFromAssetBundle(
            'assets/fonts/Montserrat/Montserrat-ExtraBold.ttf'),
      };

      // ? Create the pdf document with the actual datas
      final pdf = pw.Document(title: widget.title + " - SMART-SFV");
      // ? Adding page
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context pdfContext) {
            return pw.Column(
              children: <pw.Widget>[
                //todo: App name
                pw.Row(
                  children: [
                    pw.Text(
                      "SMART-",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        color: PdfColor(0.5, 0.5, 0.5),
                        font: montserrat['regular'],
                        fontSize: 18,
                      ),
                    ),
                    pw.Text(
                      "SFV",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        color: PdfColor(0.5, 0.5, 0.5),
                        font: montserrat['bold'],
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                //todo: Doc title
                pw.Text(
                  widget.title,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      color: PdfColor(0, 0, 0),
                      font: montserrat['regular'],
                      fontSize: 24,
                      decoration: pw.TextDecoration.underline),
                ),
                pw.SizedBox(height: 10),
                //todo: Table
                pw.Table(
                  defaultVerticalAlignment:
                      pw.TableCellVerticalAlignment.middle,
                  border: pw.TableBorder(
                    //todo: Outside borders
                    top: pw.BorderSide(
                      width: 2,
                      color: PdfColor(0, 0, 0),
                    ),
                    left: pw.BorderSide(
                      width: 2,
                      color: PdfColor(0, 0, 0),
                    ),
                    right: pw.BorderSide(
                      width: 2,
                      color: PdfColor(0, 0, 0),
                    ),
                    bottom: pw.BorderSide(
                      width: 2,
                      color: PdfColor(0, 0, 0),
                    ),
                    //todo: Inside borders
                    horizontalInside: pw.BorderSide(
                      width: 2,
                      color: PdfColor(0, 0, 0),
                    ),
                    verticalInside: pw.BorderSide(
                      width: 2,
                      color: PdfColor(0, 0, 0),
                    ),
                  ),
                  children: <pw.TableRow>[
                    //todo: Table head
                    pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      children: <pw.Widget>[
                        for (var headText in widget.columns)
                          pw.Text(
                            headText,
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              color: PdfColor(0, 0, 0),
                              font: montserrat['bold'],
                              fontSize: 20,
                            ),
                          ),
                      ],
                    ),
                    //todo: Content
                    pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      children: <pw.Widget>[
                        for (var headText in widget.columns)
                          pw.Text(
                            headText,
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              color: PdfColor(0, 0, 0),
                              font: montserrat['bold'],
                              fontSize: 20,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
      // ? Launch request to save the document
      bool isDocSaved = await Printing.layoutPdf(
        name: widget.title + " - SMART-SFV",
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
      // ? Check if the user has been save the doc or not
      if (isDocSaved) {
        print("PDF created and saved successfuly !");
        functions.successSnackbar(
          context: context,
          message: "Document PDF Enregistré",
        );
      } else {
        print("PDF Cancel save...");
        functions.showMessageToSnackbar(
          context: context,
          message: "Enregistrement du document annulé",
          icon: Icon(
            Icons.save_alt_rounded,
            color: Colors.red,
          ),
        );
      }
    } catch (error) {
      print("PDF Error -> $error");
      functions.errorSnackbar(
        context: context,
        message: "Echec de génération du PDF",
      );
    }
  }
}
