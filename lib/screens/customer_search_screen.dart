import 'package:flutter/material.dart';

import '../config/search_config.dart';
import '../widgets/dynamic_field.dart';

import 'package:provider/provider.dart';

import 'customer_results_screen.dart';
import '../state/customer_search_state.dart';

class CustomerSearchScreen extends StatefulWidget {
  const CustomerSearchScreen({super.key});

  @override
  State<CustomerSearchScreen> createState() => _CustomerSearchScreenState();
}

class _CustomerSearchScreenState extends State<CustomerSearchScreen> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (final field in searchConfig) {
      _controllers[field.key] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sortedFields = [...searchConfig]
      ..sort((a, b) => a.renderOrder.compareTo(b.renderOrder));

    return Scaffold(
      appBar: AppBar(title: const Text('Customer Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (final field in sortedFields)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: DynamicField(
                  config: field,
                  controller: _controllers[field.key]!,
                ),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final criteria = <String, String>{};
                      for (final entry in _controllers.entries) {
                        criteria[entry.key] = entry.value.text;
                      }

                      final state = context.read<CustomerSearchState>();
                      state.search(criteria);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomerResultsScreen(),
                        ),
                      );
                    },
                    child: const Text('Search'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      final criteria = <String, String>{};
                      for (final entry in _controllers.entries) {
                        criteria[entry.key] = entry.value.text;
                      }

                      final state = context.read<CustomerSearchState>();
                      state.search(criteria);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomerResultsScreen(),
                        ),
                      );
                    },
                    child: const Text('Clear'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
