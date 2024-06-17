import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:atma_kitchen/entity/Presensi.dart';

class PresensiClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/presensi';

  static Future<List<Presensi>> fetchAll() async {
    try {
      var response = await http.get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Presensi.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Presensi>> searchByEmployeeName(String namaKaryawan) async {
    try {
      var response = await http.get(Uri.http(url, '$endpoint/$namaKaryawan'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Presensi.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<http.Response> create(Presensi presensi) async {
    try {
      var response = await http.post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: presensi.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<http.Response> update(Presensi presensi) async {
    try {
      var response = await http.put(
          Uri.http(url, '$endpoint/${presensi.id}'), 
          headers: {"Content-Type": "application/json"},
          body: json.encode(presensi.toJson())); 

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> generatePresensi() async {
      try {
        var response = await http.post(
          Uri.http(url, '$endpoint/generate-presensi'),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 200) {
          print('Presensi berhasil di-generate!');
        } else {
          print('Response status code: ${response.statusCode}');
          print('Response body: ${response.body}');
          throw Exception('Failed to generate presensi: ${response.reasonPhrase}');
        }
      } catch (e) {
        print("Terjadi kesalahan saat memanggil generate presensi: $e");
      }
  }

}
