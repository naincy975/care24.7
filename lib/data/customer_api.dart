import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/customer.dart';

class CustomerApi {
  static const String baseUrl = 'http://localhost:3001';

  Future<List<Customer>> fetchCustomers(Map<String, String> criteria) async {
    final queryParams = <String, String>{};
    criteria.forEach((key, value) {
      if (value.trim().isNotEmpty) {
        queryParams[key] = value.trim();
      }
    });

    final uri = Uri.parse('$baseUrl/customers')
        .replace(queryParameters: queryParams);
    final response = await http
        .get(uri)
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            throw Exception('Request timed out. Please check your connection.');
          },
        );

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
