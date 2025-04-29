import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;
import '../controllers/question_controller.dart';

class ReportScreen extends StatelessWidget {
  final QuestionController questionController = Get.find();

  final boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 10,
        offset: Offset(0, 3),
      ),
    ],
  );

  Widget buildCard(String title, String content, Color titleColor) {
    return SizedBox(
      height: 200,
      width: 300,
      child: Container(
        decoration: boxDecoration,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: titleColor,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  content,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(String title, String content) {
    return SizedBox(
      width: 632,
      child: Container(
        width: double.infinity,
        decoration: boxDecoration,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
            ),
          ],
        ),
      ),
    );
  }
Future<void> generateAndDownloadPDF() async {
    final pdf = pw.Document();

    final bgColor = PdfColor.fromInt(0xFFEFF5FD); // Your light blue

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build:
            (pw.Context context) => [
              pw.Container(
                color: bgColor,
                padding: pw.EdgeInsets.all(20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'Your Ikigai Report',
                      style: pw.TextStyle(
                        fontSize: 26,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        buildPdfCard(
                          "Passion",
                          questionController.passion.value,
                          PdfColors.deepPurple,
                        ),
                        pw.SizedBox(width: 20),
                        buildPdfCard(
                          "Mission",
                          questionController.mission.value,
                          PdfColors.teal,
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 32),
                    buildPdfInfoCard(
                      "Ikigai Statement",
                      questionController.ikigaiStatement.value,
                    ),
                    pw.SizedBox(height: 32),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        buildPdfCard(
                          "Vocation",
                          questionController.vocation.value,
                          PdfColors.deepPurple,
                        ),
                        pw.SizedBox(width: 20),
                        buildPdfCard(
                          "Profession",
                          questionController.profession.value,
                          PdfColors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
      ),
    );

    Uint8List bytes = await pdf.save();

    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor =
        html.AnchorElement(href: url)
          ..setAttribute("download", "ikigai_report.pdf")
          ..click();
    html.Url.revokeObjectUrl(url);
  }
pw.Widget buildPdfCard(String title, String content, PdfColor titleColor) {
    return pw.Container(
      width: 200,
      padding: pw.EdgeInsets.all(12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
              color: titleColor,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            content,
            style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
          ),
        ],
      ),
    );
  }

  pw.Widget buildPdfInfoCard(String title, String content) {
    return pw.Container(
      width: double.infinity,
      padding: pw.EdgeInsets.all(16),
      margin: pw.EdgeInsets.symmetric(vertical: 10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 22,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.indigo,
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Text(
            content,
            style: pw.TextStyle(fontSize: 14, color: PdfColors.grey800),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF5FD), // Light blue background
      body: Obx(
        () => SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 60,
              ),
              child: Column(
                children: [
                  Text(
                    'Your Ikigai Report',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCard(
                        "Passion",
                        questionController.passion.value,
                        Colors.deepPurple,
                      ),
                      SizedBox(width: 32),
                      buildCard(
                        "Mission",
                        questionController.mission.value,
                        Colors.teal,
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  buildInfoCard(
                    "Ikigai Statement",
                    questionController.ikigaiStatement.value,
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCard(
                        "Vocation",
                        questionController.vocation.value,
                        Colors.deepPurple,
                      ),
                      SizedBox(width: 32),
                      buildCard(
                        "Profession",
                        questionController.profession.value,
                        Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      generateAndDownloadPDF();
                    },
                    child: Text('Download My Ikigai Report'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3D5AFE),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
