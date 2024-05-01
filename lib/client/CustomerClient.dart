import 'package:atma_kitchen/entity/Customer.dart';
import 'dart:convert';
import 'package:http/http.dart';

class CustomerClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/customer';

  static Future<Customer> fetch(String id) async {
    try {
      var response = await get(
        Uri.http(url, '$endpoint/$id'));

        if(response.statusCode != 200) throw Exception(response.reasonPhrase);

        var jsonData = json.decode(response.body)['data'];
        return Customer.fromJson(jsonData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Customer customer) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${customer.ID_Customer}'),
      headers: {"Content-Type": "application/json"},
      body: customer.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

}