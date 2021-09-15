import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/pdf.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class PdfView extends StatefulWidget {
  final String title;
  final Map<String, dynamic> json;
  final BuildContext parentContext;
  PdfView({
    Key? key,
    this.title = 'Aperçu du document PDF',
    required this.parentContext,
    required this.json,
  }) : super(key: key);
  @override
  PdfViewState createState() => PdfViewState();
}

class PdfViewState extends State<PdfView> {
  //todo: Method called when the view is launching
  @override
  void initState() {
    super.initState();
    // ? Launching configs
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "PdfView";
      ScreenController.isChildView = true;
    }
  }

  //todo: Method called when the view is closing
  @override
  void dispose() {
    // ? Set actualView to "HomeView"
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "HomeView";
      ScreenController.isChildView = false;
    }
    super.dispose();
  }

  //The controller of sliding up panel
  GlobalKey scaffold = GlobalKey();
  // init API instance
  Api api = Api();
  Widget? pdfViewer;

  @override
  Widget build(BuildContext context) {
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
    // ? Load pdf from json
    this.pdfViewer = generateFromJson(widget.json);
    return Scaffold(
      key: scaffold,
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        elevation: 5,
        hoverElevation: 10,
        onPressed: () async {
          // ? Create a file and write decoded document in
          File doc = await functions.localFile(widget.json['title']);
          doc.writeAsBytes(base64.decode(widget.json['data']));
          print("Doc path -> " + doc.uri.toFilePath());
          // ? Show preview of the document
          bool isDocSaved = await Printing.layoutPdf(
            name: widget.json['title'],
            onLayout: (PdfPageFormat format) async =>
                base64.decode(widget.json['data']),
          );
          // ? Check if the user has saved the document or not
          if (isDocSaved) {
            functions.showSuccessDialog(
              context: context,
              message: 'Document enregistré avec succès !',
            );
          } else {
            functions.showWarningDialog(
              context: context,
              message: 'Enregistrement annulé',
            );
          }
        },
        backgroundColor: Color.fromRGBO(60, 141, 188, 1),
        child: Tooltip(
          message: 'Enregistrer',
          decoration: BoxDecoration(
            color: Color.fromRGBO(60, 141, 188, 1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: MyText(
          text: widget.title,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(child: this.pdfViewer!),
    );
  }
}
