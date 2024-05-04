import 'package:atma_kitchen/entity/Employee.dart';
import 'dart:convert';
import 'package:http/http.dart';

class CustomerClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/employee';

  // static final String url = '192.168.245.167';
  // static final String endpoint = '/AtmaKitchen_API/public/api/customer';

  static Future<Employee> fetch(String nama) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$nama'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      var jsonData = json.decode(response.body)['data'];
      return Employee.fromJson(jsonData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
