
import 'package:atma_kitchen/entity/User.dart';
import 'dart:convert';
import 'package:http/http.dart';

class CustomerClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/customer';

  // static final String url = '192.168.245.167';
  // static final String endpoint = '/AtmaKitchen_API/public/api/customer';

  static Future<User> fetch(int? id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      var jsonData = json.decode(response.body)['data'];
      return User.fromJson(jsonData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

//   static Future<Response> update(Customer customer) async {
//     try {
//       var response = await put(
//           Uri.http(url, '$endpoint/${customer.ID_Customer}'),
//           headers: {"Content-Type": "application/json"},
//           body: customer.toRawJson());

//       if (response.statusCode != 200) throw Exception(response.reasonPhrase);
//       return response;
//     } catch (e) {
//       return Future.error(e.toString());
//     }
//   }
}
