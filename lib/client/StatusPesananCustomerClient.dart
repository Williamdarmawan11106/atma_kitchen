import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:atma_kitchen/entity/Pemesanan.dart';

class ApiClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api';

  Future<List<Pemesanan>> getAllStatuses(String customerId) async {
    final response = await http.get(Uri.http(url, '$endpoint/statuses/$customerId'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      print('Received data: $jsonResponse'); 
      return jsonResponse.map((data) => Pemesanan.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load statuses');
    }
  }

  Future<void> completeOrder(String orderId) async {
    final response = await http.put(Uri.http(url, '$endpoint/complete-order/$orderId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to complete order: ${response.body}');
    }
  }
}
