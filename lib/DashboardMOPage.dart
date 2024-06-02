import 'package:flutter/material.dart';
import 'package:atma_kitchen/PresensiPage.dart';
import 'package:atma_kitchen/GenerateLaporanBahanBakuPage.dart';
import 'package:atma_kitchen/GenerateLaporanPemasukanPengeluaranBulananPage.dart';
import 'package:atma_kitchen/GenerateLaporanPenggunaanBahanBaku.dart';

class DashboardMOPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PdfReportPage()),
                );
              },
              child: Text('Generate Laporan Bahan Baku'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PdfReportPagePengunaanBahanBaku()),
                );
              },
              child: Text('Generate Laporan Penggunaan Bahan Baku'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GeneratePengeluaranPemasukanBulanan()),
                );
              },
              child: Text('Generate Laporan Pengeluaran Pemasukan Bulanan'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PresensiList()),
                );
              },
              child: Text('Presensi'),
            ),
          ],
        ),
      ),
    );
  }
}
