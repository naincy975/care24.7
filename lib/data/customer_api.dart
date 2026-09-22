import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/customer.dart';

class CustomerApi {
  static const String baseUrl = 'http://localhost:3001';

  Future<List<Customer>> fetchCustomers() async {
    final response = await http.get(Uri.parse('$baseUrl/customers'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList
          .map((item) => Customer.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }
}
