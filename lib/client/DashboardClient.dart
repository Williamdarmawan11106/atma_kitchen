import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:atma_kitchen/entity/Dashboard.dart';

class DashboardClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/dashboard';

  static Future<Dashboard> fetch() async {
    try {
      var response = await http.get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      var jsonData = json.decode(response.body);
      return Dashboard.fromJson(jsonData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
