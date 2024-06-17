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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.amber,  // Change the background color to cream
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 18),
                      primary: Colors.blueAccent,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PdfReportPage()),
                      );
                    },
                    icon: Icon(Icons.description),
                    label: Text('Generate Laporan Bahan Baku'),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 18),
                      primary: Colors.blueAccent,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PdfReportPagePengunaanBahanBaku()), 
                      );
                    },
                    icon: Icon(Icons.description),
                    label: Text('Generate Laporan Penggunaan Bahan Baku'),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 18),
                      primary: Colors.blueAccent,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GeneratePengeluaranPemasukanBulanan()),
                      );
                    },
                    icon: Icon(Icons.description),
                    label: Text('Generate Laporan Pengeluaran Pemasukan Bulanan'),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 18),
                      primary: Colors.green,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PresensiList()),
                      );
                    },
                    icon: Icon(Icons.access_time),
                    label: Text('Presensi'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
