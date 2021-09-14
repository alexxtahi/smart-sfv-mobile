// PDF packages
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:smartsfv/views/layouts/ErrorLayout.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

//todo: create pdf file from datas
Future<String> generatePDF(
    String titre, List<String> columns, List<List<String>> tableData) async {
  try {
    final pw.PageTheme pageTheme = await myPageTheme(PdfPageFormat.a4);
    final header = await pdfHeader(titre);
    final pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        maxPages: 500,
        pageTheme: pageTheme,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context pdfContext) {
          if (pdfContext.pageNumber == 1) {
            return pw.Container();
          }
          return pw.Container();
        },
        footer: (pw.Context pdfContext) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: pw.Text(
              'Page ${pdfContext.pageNumber} / ${pdfContext.pagesCount}',
            ),
          );
        },
        build: (pw.Context pdfContext) => <pw.Widget>[
          pw.Header(
            level: 0,
            child: header,
          ),
          pw.Align(
            alignment: pw.Alignment.topCenter,
            child: pw.Table.fromTextArray(
              context: pdfContext,
              border: null,
              headerAlignment: pw.Alignment.centerLeft,
              cellAlignment: pw.Alignment.centerLeft,
              headerDecoration: pw.BoxDecoration(),
              headerHeight: 25,
              cellHeight: 30,
              headerStyle: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
              cellStyle: const pw.TextStyle(
                fontSize: 10,
              ),
              rowDecoration: pw.BoxDecoration(),
              headers: List<String>.generate(
                columns.length,
                (col) {
                  return columns[col];
                },
              ),
              data: List<List<String>>.generate(
                tableData.length,
                (row) => List<String>.generate(
                  columns.length,
                  (col) {
                    return tableData[row][col];
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // ? Show preview of the document
    bool isDocSaved = await Printing.layoutPdf(
      name: titre + " - SMART-SFV",
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
    // ? Check if the user has saved the document or not
    if (isDocSaved) {
      return "Document enregistré";
    } else {
      return "Enregistrement annulé";
    }
  } catch (error) {
    print("PDF Error -> $error");
    return "Erreur";
  }
}

//pdf document theme
Future<pw.PageTheme> myPageTheme(PdfPageFormat format) async {
  return pw.PageTheme(
    pageFormat: format.applyMargin(
        left: 2.0 * PdfPageFormat.cm,
        top: 4.0 * PdfPageFormat.cm,
        right: 2.0 * PdfPageFormat.cm,
        bottom: 2.0 * PdfPageFormat.cm),
    theme: pw.ThemeData.withFont(
      base: pw.Font.ttf(
        await rootBundle.load('assets/fonts/Montserrat/Montserrat-Regular.ttf'),
      ),
      bold: pw.Font.ttf(
        await rootBundle.load('assets/fonts/Montserrat/Montserrat-Bold.ttf'),
      ),
    ),
    buildBackground: (pw.Context pdfContext) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.CustomPaint(
          size: PdfPoint(format.width, format.height),
          painter: (PdfGraphics canvas, PdfPoint size) {
            pdfContext.canvas
              ..setColor(PdfColor.fromHex("#3C8DBC"))
              ..moveTo(0, size.y)
              ..lineTo(0, size.y - 230)
              ..lineTo(60, size.y)
              ..fillPath()
              ..setColor(PdfColor.fromHex("#011B7A"))
              ..moveTo(0, size.y)
              ..lineTo(0, size.y - 100)
              ..lineTo(100, size.y)
              ..fillPath()
              ..setColor(PdfColor.fromHex("#3C8DBC"))
              ..moveTo(30, size.y)
              ..lineTo(110, size.y - 50)
              ..lineTo(150, size.y)
              ..fillPath()
              ..moveTo(size.x, 0)
              ..lineTo(size.x, 230)
              ..lineTo(size.x - 60, 0)
              ..fillPath()
              ..setColor(PdfColor.fromHex("#011B7A"))
              ..moveTo(size.x, 0)
              ..lineTo(size.x, 100)
              ..lineTo(size.x - 100, 0)
              ..fillPath()
              ..setColor(PdfColor.fromHex("#3C8DBC"))
              ..moveTo(size.x - 30, 0)
              ..lineTo(size.x - 110, 50)
              ..lineTo(size.x - 150, 0)
              ..fillPath();
          },
        ),
      );
    },
  );
}

//pdf header body
Future<pw.Container> pdfHeader(String docTitle) async {
  Map<String, pw.TtfFont> montserrat = await getFont();
  return pw.Container(
    decoration: pw.BoxDecoration(
      color: PdfColors.white,
      borderRadius: pw.BorderRadius.circular(10),
    ),
    margin: const pw.EdgeInsets.only(bottom: 8, top: 8),
    padding: const pw.EdgeInsets.fromLTRB(10, 7, 10, 4),
    child: pw.Column(
      children: [
        //todo: App name
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
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
        //todo: Country
        pw.Text(
          "Afrique, Côte d'Ivoire",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
        ),
        //todo: Copyrights
        pw.Text(
          "© All rights reserved. Group Smarty",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
        ),
        //todo: Divider
        pw.Divider(color: PdfColor.fromHex("#3C8DBC")),
        //todo: Doc title
        pw.Text(
          docTitle,
          style: pw.TextStyle(
              fontSize: 14,
              color: PdfColors.black,
              decoration: pw.TextDecoration.underline),
        ),
      ],
    ),
  );
}

Future<Map<String, pw.TtfFont>> getFont() async {
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
  // ? Return that
  return montserrat;
}

//todo: create pdf file from json datas
Widget generateFromJson(Map<String, dynamic> json) {
  try {
    // ? Load encoded document
    //File doc = File.fromRawPath(base64.decode(json['data']));
    return SfPdfViewer.memory(
      base64.decode(json['data']),
      canShowScrollHead: true,
      canShowPaginationDialog: true,
      controller: PdfViewerController(),
    );
  } catch (error) {
    print("PDF Error -> $error");
    return ErrorLayout(
      message: "L'aperçu n'est pas disponible pour le moment.",
    );
  }
}
