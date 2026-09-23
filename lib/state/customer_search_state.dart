import 'package:flutter/foundation.dart';

import '../models/customer.dart';
import '../data/customer_api.dart';

enum SearchStatus { initial, loading, success, empty, error }

class CustomerSearchState extends ChangeNotifier {
  final CustomerApi _api = CustomerApi();

  SearchStatus status = SearchStatus.initial;
  List<Customer> results = [];
  String errorMessage = '';
  Map<String, String> _lastCriteria = {};

  Future<void> search(Map<String, String> criteria) async {
    _lastCriteria = criteria;
    status = SearchStatus.loading;
    notifyListeners();

    try {
      final customers = await _api.fetchCustomers(criteria);

      if (customers.isEmpty) {
        status = SearchStatus.empty;
      } else {
        results = customers;
        status = SearchStatus.success;
      }
    } catch (e) {
      results = [];
      errorMessage = 'Something went wrong. Please try again.';
      status = SearchStatus.error;
    }

    notifyListeners();
  }

  Future<void> retry() async {
    await search(_lastCriteria);
  }
}
