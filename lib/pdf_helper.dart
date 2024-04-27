import 'dart:io';

import 'package:customer_management/modeel.dart';
import 'package:customer_management/pdf_api.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class PdfHelper_generate {
  static Future<File> generate(InvoiceModel mdlss, double due) async {
    final pdf = pw.Document();
    final fonts = await rootBundle.load("assets/arial.ttf");
    final ttfbold = pw.Font.ttf(fonts);
    final imageByteData =
        (await rootBundle.load('assets/logo.jpg')).buffer.asUint8List();

    final image = pw.MemoryImage(imageByteData);
    List<pw.Widget> widgets = [];
    widgets.add(
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Container(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Image(image, height: 60),
                    pw.Container(
                        child: pw.Text(" Invoice No #${mdlss.invoicenumber}",
                            style: pw.TextStyle(
                                fontSize: 14,
                                font: ttfbold,
                                color: PdfColors.black)))
                  ],
                ),
              ),
            ],
          ),
          pw.Container(
            margin: pw.EdgeInsets.only(top: 20),
            child: pw.Text(
                "189 Whitechapel Road, Unit - B1,\nLondon, England, E1 1DN",
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                    fontSize: 10, font: ttfbold, color: PdfColors.black)),
          ),
        ],
      ),
    );

    widgets.add(
      pw.SizedBox(height: 35),
    );

    widgets.add(
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                child: pw.Text("Travellers",
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 12, font: ttfbold, color: PdfColors.blue400)),
              ),
              pw.SizedBox(height: 10),
              for (var traveller in mdlss.travellers)
                pw.Container(
                  child: pw.Text(
                      traveller['name'],
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                          fontSize: 12, font: ttfbold, color: PdfColors.black)),
                ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                child: pw.Text("Ticket Number",
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 12, font: ttfbold, color: PdfColors.blue400)),
              ),
              pw.SizedBox(height: 10),
              for (var traveller in mdlss.travellers)
                pw.Container(
                  child: pw.Text(
                      traveller['ticketnumber'],
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                          fontSize: 12, font: ttfbold, color: PdfColors.blue400)),
                ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                child: pw.Text("Ticket Price",
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 12, font: ttfbold, color: PdfColors.blue400)),
              ),
              pw.SizedBox(height: 10),
              for (var traveller in mdlss.travellers)
                pw.Container(
                  child: pw.Text(
                      traveller['price'],
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                          fontSize: 12, font: ttfbold, color: PdfColors.blue400)),
                ),
            ],
          ),
          pw.SizedBox(width: 25),
        ],
      ),
    );
    widgets.add(
      pw.SizedBox(height: 10),
    );
    widgets.add(
        pw.Container(height: 1, width: double.infinity, color: PdfColors.grey));

    widgets.add(
      pw.SizedBox(height: 25),
    );

    widgets.add(pw.Container(
      child: pw.Text("Your flight itinerary",
          textAlign: pw.TextAlign.right,
          style: pw.TextStyle(
              fontSize: 12, font: ttfbold, color: PdfColors.blue400)),
    ));
    widgets.add(
      pw.SizedBox(height: 5),
    );
    widgets.add(
      pw.Container(
        child: pw.Text("${mdlss.departure} - ${mdlss.arrival}",
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
                fontSize: 10, font: ttfbold, color: PdfColors.blue400)),
      ),
    );
    widgets.add(
      pw.SizedBox(height: 5),
    );
    widgets.add(
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                child: pw.Text(mdlss.airlinename,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 9, font: ttfbold, color: PdfColors.black)),
              ),
              pw.SizedBox(height: 2),
              pw.Container(
                child: pw.Text(mdlss.flightnum,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 9, font: ttfbold, color: PdfColors.black)),
              ),
              pw.SizedBox(height: 2),
            ],
          ),
          pw.Container(width: 1, height: 80, color: PdfColors.grey),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                child: pw.Text(mdlss.departure,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 10, font: ttfbold, color: PdfColors.black)),
              ),
              pw.SizedBox(height: 2),
              pw.Container(
                child: pw.Text(mdlss.departureterminal,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 9, font: ttfbold, color: PdfColors.black)),
              ),
              pw.SizedBox(height: 2),
              pw.Container(
                child: pw.Text(mdlss.departuretime,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 9, font: ttfbold, color: PdfColors.black)),
              ),
              pw.SizedBox(height: 2),
              pw.Container(
                child: pw.Text(mdlss.departuredate,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 9, font: ttfbold, color: PdfColors.black)),
              ),
            ],
          ),
          pw.Container(width: 30, height: 1, color: PdfColors.grey),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                child: pw.Text(mdlss.arrival,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 10, font: ttfbold, color: PdfColors.black)),
              ),
              pw.SizedBox(height: 2),
              pw.Container(
                child: pw.Text(mdlss.arrivalterminal,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 9, font: ttfbold, color: PdfColors.black)),
              ),
              pw.SizedBox(height: 2),
              pw.Container(
                child: pw.Text(mdlss.arrivaltime,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 9, font: ttfbold, color: PdfColors.black)),
              ),
              pw.SizedBox(height: 2),
              pw.Container(
                child: pw.Text(mdlss.arrivaldate,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 9, font: ttfbold, color: PdfColors.black)),
              ),
            ],
          ),
          pw.SizedBox(width: 70),
        ],
      ),
    );
    widgets.add(
      pw.SizedBox(height: 10),
    );
    widgets.add(
        pw.Container(height: 1, width: double.infinity, color: PdfColors.grey));

    widgets.add(
      pw.SizedBox(height: 30),
    );

    widgets.add(pw.Container(
      child: pw.Text("Your trip receipt",
          textAlign: pw.TextAlign.right,
          style: pw.TextStyle(
              fontSize: 12, font: ttfbold, color: PdfColors.green400)),
    ));
    widgets.add(
      pw.SizedBox(height: 5),
    );
    widgets.add(
      pw.Container(
        child: pw.Text(mdlss.selectedCustomer,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
                fontSize: 10, font: ttfbold, color: PdfColors.green400)),
      ),
    );

    widgets.add(
      pw.SizedBox(height: 5),
    );

    widgets.add(
      pw.Container(
          margin: const pw.EdgeInsets.only(right: 170),
          child: pw.Column(children: [
            pw.Row(children: [
              pw.Text("    Air Fare",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontSize: 10, font: ttfbold, color: PdfColors.black)),
              pw.Expanded(child: pw.SizedBox()),
              pw.Text("\$${mdlss.basefare}",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontSize: 10, font: ttfbold, color: PdfColors.black)),
              pw.SizedBox(width: 50),
            ]),
            pw.SizedBox(height: 2),
            pw.Row(children: [
              pw.Text("    Due",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontSize: 10, font: ttfbold, color: PdfColors.black)),
              pw.Expanded(child: pw.SizedBox()),
              pw.Text("\$${due}",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontSize: 10, font: ttfbold, color: PdfColors.black)),
              pw.SizedBox(width: 50),
            ]),
            pw.SizedBox(height: 2),
            pw.Container(
              padding: pw.EdgeInsets.symmetric(vertical: 2),
              decoration: pw.BoxDecoration(
                  color: PdfColors.green400,
                  borderRadius: pw.BorderRadius.circular(3)),
              child: pw.Row(children: [
                pw.Text("    Total",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 10, font: ttfbold, color: PdfColors.white)),
                pw.Expanded(child: pw.SizedBox()),
                pw.Text("\$${mdlss.basefare}",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 10, font: ttfbold, color: PdfColors.white)),
                pw.SizedBox(width: 50),
              ]),
            )
          ])),
    );
    widgets.add(
      pw.SizedBox(height: 25),
    );
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => widgets,
    ));

    return PdfApi.saveDocument(
        "File${DateFormat('dd-MMM-yyyy-jms').format(DateTime.now())}.pdf", pdf);
  }
}
