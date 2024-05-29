import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:atma_kitchen/entity/PenarikanSaldo.dart';

class PenarikanSaldoClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/penarikansaldo';

  static Future<List<PenarikanSaldo>> fetchAll(int id) async {
    try {
      var response = await http.get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      }

      List<dynamic> list = json.decode(response.body)['data'];
      return list.map((e) => PenarikanSaldo.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<PenarikanSaldo>> fetchByDate(int id, String tanggal) async {
    try {
      var response = await http.get(Uri.http(url, '$endpoint/$id/$tanggal'));

      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      }

      List<dynamic> list = json.decode(response.body)['data'];
      return list.map((e) => PenarikanSaldo.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<PenarikanSaldo> createPenarikanSaldo(PenarikanSaldo penarikanSaldo) async {
    try {
      var response = await http.post(
        Uri.http(url, '$endpoint/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(penarikanSaldo.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to create');
      }

      return PenarikanSaldo.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
