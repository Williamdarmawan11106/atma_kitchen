import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:atma_kitchen/entity/BahanBaku.dart';

class BahanBakuClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/bahanbaku';

  static Future<List<BahanBaku>> fetch() async {
    try {
      var response = await http.get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      var jsonData = json.decode(response.body);
      List<BahanBaku> bahanBakuList = (jsonData['data'] as List)
          .map((item) => BahanBaku.fromJson(item))
          .toList();
      return bahanBakuList;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
