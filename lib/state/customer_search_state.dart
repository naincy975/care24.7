import 'package:flutter/foundation.dart';

import '../models/customer.dart';
import '../data/customer_api.dart';

enum SearchStatus { initial, loading, success, empty, error }

class CustomerSearchState extends ChangeNotifier {
  final CustomerApi _api = CustomerApi();
  SearchStatus status = SearchStatus.initial;

  List<Customer> results = [];
  String errMsg = '';

  Future<void> search() async {
    status = SearchStatus.loading;
    notifyListeners();

    try {
      final customers = await _api.fetchCustomers();
      if (customers.isEmpty) {
        status = SearchStatus.empty;
      } else {
        results = customers;
        status = SearchStatus.success;
      }
    } catch (e) {
      results = [];
      errMsg = 'Something went wrong. Please try again.';
      status = SearchStatus.error;
      print('SEARCH ERROR: $e');
    }
    notifyListeners();
  }
}
