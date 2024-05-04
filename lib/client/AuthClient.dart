import 'package:atma_kitchen/entity/Employee.dart';
import 'package:atma_kitchen/entity/Customer.dart';
import 'dart:convert';
import 'package:http/http.dart';

class AuthClient {
  static final String url = '10.0.2.2:8000';

  // static Future<dynamic> login(String nama, String password) async {
  //   final String url = '10.0.2.2:8000';
  //   final String endpoint = '/api/login';

  //   // static final String url = '192.168.245.167';
  //   // static final String endpoint = '/AtmaKitchen_API/public/api/customer';
  //   try {
  //     var response = await post(Uri.http(url, endpoint));

  //     if (response.statusCode != 200) throw Exception(response.reasonPhrase);

  //     var jsonData = json.decode(response.body)['data'];
  //     print(jsonData['message'].toString());

  //     if (jsonData['message'].toString() == 'Selamat Datang Customer') {
  //       return Customer.fromJson(jsonData);
  //     } else if (jsonData['message'].toString() == 'Selamat Datang MO') {
  //       return Employee.fromJson(jsonData);
  //     } else {
  //       throw Exception('Invalid response from server');
  //     }
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  static Future<Customer> loginCust(String nama, String password) async {
    // static final String url = '192.168.245.167';
    // static final String endpoint = '/AtmaKitchen_API/public/api/customer';
    try {
      var response = await post(Uri.http(url, "/api/loginCus"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"Nama_Customer": nama, "Password": password}));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      var jsonData = json.decode(response.body)['data'];
      return Customer.fromJson(jsonData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<dynamic> loginEmp(String nama, String password) async {
    // static final String url = '192.168.245.167';
    // static final String endpoint = '/AtmaKitchen_API/public/api/customer';
    try {
      var response = await post(Uri.http(url, "/api/loginEmp"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"Nama_Employee": nama, "Password": password}));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      var jsonData = json.decode(response.body)['data'];
      return Employee.fromJson(jsonData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
