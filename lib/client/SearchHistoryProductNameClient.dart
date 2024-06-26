import 'package:atma_kitchen/entity/History.dart';
import 'dart:convert';
import 'package:http/http.dart';

class SearchHistoryProductNameClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/detailPesanan/search';

  static Future<List<History>> searchHistory(int? id, String nama) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id/$nama'));

      if (response.statusCode != 200) {
        throw Exception('Failed to load history: ${response.reasonPhrase}');
      }

      List<dynamic> list = json.decode(response.body)['data'];
      return list.map((e) => History.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
