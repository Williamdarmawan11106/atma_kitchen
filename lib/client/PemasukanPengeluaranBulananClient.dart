import 'package:http/http.dart' as http;
import 'dart:convert';

class PemasukanPengeluaranClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/laporan-pemasukan-pengeluaran';

  static Future<Map<String, dynamic>> fetch(int bulan, int tahun) async {
    try {
      var response = await http.get(Uri.http(url, endpoint, {'bulan': '$bulan', 'tahun': '$tahun'}));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      var jsonData = json.decode(response.body);
      print(jsonData);  // Debugging: Print the full response

      Map<String, dynamic> pemasukan = Map<String, dynamic>.from(jsonData['pemasukan']);
      Map<String, dynamic> pengeluaran = Map<String, dynamic>.from(jsonData['pengeluaran']);

      return {
        'pemasukan': pemasukan,
        'pengeluaran': pengeluaran,
      };
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
