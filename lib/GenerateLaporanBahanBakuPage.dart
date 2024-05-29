import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share/share.dart';
import 'package:atma_kitchen/entity/BahanBaku.dart';
import 'package:atma_kitchen/client/BahanBakuClient.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PdfReportPage(),
    );
  }
}

class PdfReportPage extends StatefulWidget {
  @override
  _PdfReportPageState createState() => _PdfReportPageState();
}

class _PdfReportPageState extends State<PdfReportPage> {
  bool _isLoading = false;
  String? _pdfPath;

  Future<void> generatePdfReport() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final pdf = pw.Document();
      final List<BahanBaku> bahanBakuList = await BahanBakuClient.fetch();
      final date = DateTime.now();
      final formattedDate = "${date.day}-${date.month}-${date.year}";

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Atma Kitchen', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Text('Jl. Centralpark No. 10 Yogyakarta', style: pw.TextStyle(fontSize: 12)),
                pw.SizedBox(height: 20),
                pw.Text('LAPORAN Stok Bahan Baku', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.Text('Tanggal cetak: $formattedDate', style: pw.TextStyle(fontSize: 12)),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  headers: ['Nama Bahan', 'Satuan', 'Stok'],
                  data: bahanBakuList.map((bahanBaku) {
                    return [
                      bahanBaku.nama_bahan_baku,
                      bahanBaku.satuan_bahan_baku,
                      bahanBaku.stok_bahan_baku.toString(),
                    ];
                  }).toList(),
                ),
              ],
            );
          },
        ),
      );

      final output = await getTemporaryDirectory();
      final file = File("${output.path}/stok_bahan_baku.pdf");
      await file.writeAsBytes(await pdf.save());

      setState(() {
        _pdfPath = file.path;
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PdfViewerPage(pdfPath: _pdfPath!)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate PDF: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Report'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: generatePdfReport,
                child: Text('Generate PDF'),
              ),
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;

  const PdfViewerPage({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View PDF'),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
