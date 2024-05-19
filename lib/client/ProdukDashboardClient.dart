import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:atma_kitchen/entity/ProdukDashboard.dart';

class ProdukDashboardClient {
  static final String baseUrl = '10.0.2.2:8000';
  static final String endpoint = '/api/produkdashboard';

  static Future<ProdukDashboard> fetch() async {
    try {
      var response = await http.get(Uri.http(baseUrl, endpoint));

      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      }

      var jsonData = json.decode(response.body);
      return ProdukDashboard.fromJson(jsonData);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
