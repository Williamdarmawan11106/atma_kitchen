import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:atma_kitchen/entity/BahanBaku.dart';

class PenggunaanBahanBakuClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/bahanbaku/penggunaan-bahan-baku';

  static Future<Map<String, dynamic>> fetch(String tanggalMulai, String tanggalSelesai) async {
    try {
      var response = await http.get(Uri.http(url, '$endpoint/$tanggalMulai/$tanggalSelesai'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      var jsonData = json.decode(response.body);
      List<BahanBaku> bahanBakuList = (jsonData['data']['bahanBakus'] as List)
          .map((item) => BahanBaku.fromJson(item))
          .toList();
      Map<String, int> bahanBakuUsage = Map<String, int>.from(jsonData['data']['bahanBakuUsage']);

      return {
        'bahanBakus': bahanBakuList,
        'bahanBakuUsage': bahanBakuUsage,
      };
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
