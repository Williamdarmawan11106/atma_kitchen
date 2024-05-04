import 'package:atma_kitchen/entity/History.dart';
import 'dart:convert';
import 'package:http/http.dart';

class HistoryClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/pemesanan';

  // static final String url = '192.168.245.167';
  // static final String endpoint = '/AtmaKitchen_API/public/api/pemesanan';

  static Future<List<History>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => History.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
