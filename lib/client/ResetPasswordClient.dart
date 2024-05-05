// import 'package:atma_kitchen/entity/Employee.dart';
// import 'package:atma_kitchen/entity/Customer.dart';
// import 'dart:convert';
import 'package:http/http.dart';

class Resetpasswordclient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/sendEmailLink';

  // static final String url = '192.168.245.167';
  // static final String endpoint = '/AtmaKitchen_API/public/api/customer';

  static Future<Response> sendEmail(String? nama) async {
    try {
      print('1');
      var response = await get(Uri.http(url, '$endpoint/$nama'));

      print('2');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      print('3');
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
