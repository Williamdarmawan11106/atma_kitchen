import 'package:atma_kitchen/entity/User.dart';
import 'dart:convert';
import 'package:http/http.dart';

class AuthClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/searchCustomer';

  static Future<User> searchByEmail(String email) async {
    // static final String url = '192.168.245.167';
    // static final String endpoint = '/AtmaKitchen_API/public/api/customer';
    try {
      var response = await get(Uri.http(url, '$endpoint/$email'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      var jsonData = json.decode(response.body)['data'];
      return User.fromJson(jsonData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User> login(String email, String password) async {
    try {
      var response = await post(Uri.http(url, "/api/login"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"Email": email, "Password": password}));

      print('1');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('2');

      var jsonData = json.decode(response.body)['data'];

      print('3');

      return User.fromJson(jsonData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
