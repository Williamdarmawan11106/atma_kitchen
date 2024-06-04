import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:atma_kitchen/entity/BahanBaku.dart';
import 'package:atma_kitchen/client/PenggunaanBahanBakuClient.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PdfReportPagePengunaanBahanBaku(),
    );
  }
}

class PdfReportPagePengunaanBahanBaku extends StatefulWidget {
  @override
  _PdfReportPageState createState() => _PdfReportPageState();
}

class _PdfReportPageState extends State<PdfReportPagePengunaanBahanBaku> {
  bool _isLoading = false;
  String? _pdfPath;
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  Future<void> generatePdfReport() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final pdf = pw.Document();
      final date = DateTime.now();
      final formattedDate = "${date.day}-${date.month}-${date.year}";

      final data = await PenggunaanBahanBakuClient.fetch(
        _startDateController.text,
        _endDateController.text,
      );

      final List<BahanBaku> bahanBakuList = data['bahanBakus'];
      final Map<String, int> bahanBakuUsage = data['bahanBakuUsage'];

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Atma Kitchen', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Text('Jl. Centralpark No. 10 Yogyakarta', style: pw.TextStyle(fontSize: 12)),
                pw.SizedBox(height: 20),
                pw.Text('LAPORAN Penggunaan Bahan Baku', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.Text('Tanggal cetak: $formattedDate', style: pw.TextStyle(fontSize: 12)),
                pw.Text('Periode: ${_startDateController.text} - ${_endDateController.text}', style: pw.TextStyle(fontSize: 12)),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  headers: ['Nama Bahan', 'Satuan', 'Jumlah Digunakan'],
                  data: bahanBakuList.map((bahanBaku) {
                    return [
                      bahanBaku.nama_bahan_baku,
                      bahanBaku.satuan_bahan_baku,
                      bahanBakuUsage[bahanBaku.id.toString()]?.toString() ?? '0',
                    ];
                  }).toList(),
                ),
              ],
            );
          },
        ),
      );

      final output = await getTemporaryDirectory();
      final file = File("${output.path}/penggunaan_bahan_baku.pdf");
      await file.writeAsBytes(await pdf.save());

      setState(() {
        _pdfPath = file.path;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF generated successfully')),
      );
    } catch (e) {
      print('Error: $e'); 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate PDF: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _downloadPdf(String pdfPath) async {
    if (await Permission.storage.request().isGranted) {
      try {
        final downloadPath = Directory('/storage/emulated/0/Download');
        final pdfFile = File(pdfPath);
        final newFile = await pdfFile.copy('${downloadPath.path}/laporan_penggunaan_bahanbaku.pdf');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF downloaded successfully to Downloads')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download PDF: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required to download the PDF')),
      );
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
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _startDateController,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Mulai (YYYY-MM-DD)',
                    ),
                  ),
                  TextField(
                    controller: _endDateController,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Selesai (YYYY-MM-DD)',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: generatePdfReport,
                    child: Text('Generate PDF'),
                  ),
                  SizedBox(height: 20),
                  _pdfPath != null
                      ? Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfViewerPage(pdfPath: _pdfPath!),
                                  ),
                                );
                              },
                              child: Text('View PDF'),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async => _downloadPdf(_pdfPath!),
                              child: Text('Download PDF'),
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
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
