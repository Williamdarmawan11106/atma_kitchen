import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:atma_kitchen/client/PemasukanPengeluaranBulananClient.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GeneratePengeluaranPemasukanBulanan(),
    );
  }
}

class GeneratePengeluaranPemasukanBulanan extends StatefulWidget {
  @override
  _GeneratePengeluaranPemasukanBulananState createState() =>
      _GeneratePengeluaranPemasukanBulananState();
}

class _GeneratePengeluaranPemasukanBulananState
    extends State<GeneratePengeluaranPemasukanBulanan> {
  bool _isLoading = false;
  String? _pdfPath;
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  Future<Map<String, dynamic>> fetchData(int bulan, int tahun) async {
    return await PemasukanPengeluaranClient.fetch(bulan, tahun);
  }

  Future<void> generatePdfReport(int selectedMonth, int selectedYear) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final pdf = pw.Document();
      final Map<String, dynamic> data =
          await fetchData(selectedMonth, selectedYear);
      final date = DateTime.now();
      final formattedDate = "${date.day}-${date.month}-${date.year}";

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return buildPdfContent(data, selectedMonth, selectedYear, formattedDate);
          },
        ),
      );

      final output = await getTemporaryDirectory();
      final file = File("${output.path}/laporan_pemasukan_pengeluaran.pdf");
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

  pw.Widget buildPdfContent(Map<String, dynamic> data, int selectedMonth, int selectedYear, String formattedDate) {
    final monthName = DateFormat('MMMM').format(DateTime(selectedYear, selectedMonth));

    List<pw.TableRow> tableRows = [];

    // Header Row
    tableRows.add(pw.TableRow(
      children: [
        pw.Text('Pemasukan', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text('Nominal', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    ));

    // Pemasukan Rows
    tableRows.add(pw.TableRow(
      children: [
        pw.Text('Total Tip', style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
        pw.Text(data['pemasukan']['totalTip'].toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
      ],
    ));
    tableRows.add(pw.TableRow(
      children: [
        pw.Text('Total Penjualan', style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
        pw.Text(data['pemasukan']['totalPenjualan'].toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
      ],
    ));
    tableRows.add(pw.TableRow(
      children: [
        pw.Text('Total Pemasukan', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(data['pemasukan']['totalPemasukan'].toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    ));

    // Empty Row for Separation
    tableRows.add(pw.TableRow(
      children: [
        pw.SizedBox(height: 10),
        pw.SizedBox(height: 10),
      ],
    ));

    // Pengeluaran Header Row
    tableRows.add(pw.TableRow(
      children: [
        pw.Text('Pengeluaran', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text('Nominal', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    ));

    // Pengeluaran Rows
    data['pengeluaran']['pengeluaranLainnya'].forEach((item) {
      tableRows.add(pw.TableRow(
        children: [
          pw.Text(item['nama_pengeluaran'], style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
          pw.Text(item['biaya'].toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
        ],
      ));
    });
    tableRows.add(pw.TableRow(
      children: [
        pw.Text('Total Pengeluaran Lainnya', style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
        pw.Text(data['pengeluaran']['totalPengeluaranLainnya'].toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
      ],
    ));
    tableRows.add(pw.TableRow(
      children: [
        pw.Text('Total Gaji', style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
        pw.Text(data['pengeluaran']['totalGaji'].toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
      ],
    ));
    tableRows.add(pw.TableRow(
      children: [
        pw.Text('Pembelian Bahan Baku', style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
        pw.Text(data['pengeluaran']['pembelianBahanBaku'].toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
      ],
    ));
    tableRows.add(pw.TableRow(
      children: [
        pw.Text('Grand Total Penitip', style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
        pw.Text(data['pengeluaran']['grandTotalPenitip'].toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
      ],
    ));
    tableRows.add(pw.TableRow(
      children: [
        pw.Text('Total Pengeluaran', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(data['pengeluaran']['totalPengeluaran'].toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    ));

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Atma Kitchen', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.Text('Jl. Centralpark No. 10 Yogyakarta', style: pw.TextStyle(fontSize: 12)),
        pw.SizedBox(height: 20),
        pw.Text('LAPORAN PEMASUKAN DAN PENGELUARAN', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Text('Bulan: $monthName', style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
        pw.Text('Tahun: $selectedYear', style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
        pw.Text('Tanggal cetak: $formattedDate', style: pw.TextStyle(fontSize: 12)),
        pw.SizedBox(height: 20),
        pw.Table(
          border: pw.TableBorder.all(),
          children: tableRows,
        ),
      ],
    );
  }

  void _showMonthPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Month and Year'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<int>(
                value: _selectedMonth,
                onChanged: (value) {
                  setState(() {
                    _selectedMonth = value!;
                  });
                },
                items: List.generate(12, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text('${DateFormat('MMMM').format(DateTime(0, index + 1))}'),
                  );
                }),
              ),
              SizedBox(height: 10),
              DropdownButton<int>(
                value: _selectedYear,
                onChanged: (value) {
                  setState(() {
                    _selectedYear = value!;
                  });
                },
                items: List.generate(10, (index) {
                  return DropdownMenuItem<int>(
                    value: DateTime.now().year - 5 + index,
                    child: Text('${DateTime.now().year - 5 + index}'),
                  );
                }),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                generatePdfReport(_selectedMonth, _selectedYear);
                Navigator.pop(context);
              },
              child: Text('Generate'),
            ),
          ],
        );
      },
    );
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
                onPressed: _showMonthPicker,
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
      body: Container(
        child: PDFView(
          filePath: pdfPath,
        ),
      ),
    );
  }
}
