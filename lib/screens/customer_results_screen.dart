import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/customer_search_state.dart';
import '../models/customer.dart';
import 'customer_detail_screen.dart';

class CustomerResultsScreen extends StatelessWidget {
  const CustomerResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustomerSearchState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Search Results')),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, CustomerSearchState state) {
    switch (state.status) {
      case SearchStatus.initial:
        return const Center(child: Text('Enter search criteria to begin.'));

      case SearchStatus.loading:
        return const Center(child: CircularProgressIndicator());

      case SearchStatus.empty:
        return const Center(child: Text('No customers found.'));

      case SearchStatus.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.errorMessage),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => state.retry(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );

      case SearchStatus.success:
        return RefreshIndicator(
          onRefresh: () => state.retry(),
          child: ListView.builder(
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              final customer = state.results[index];
              return _CustomerListItem(customer: customer);
            },
          ),
        );
    }
  }
}

class _CustomerListItem extends StatelessWidget {
  final Customer customer;

  const _CustomerListItem({required this.customer});

  @override
  Widget build(BuildContext context) {
    final primaryPhone = customer.phones.where((p) => p.isPrimary).firstOrNull;
    final primaryEmail = customer.emails.where((e) => e.isPrimary).firstOrNull;

    return ListTile(
      title: Text('${customer.firstName} ${customer.lastName}'),
      subtitle: Text(
        '${customer.dateOfBirth}\n'
        '${primaryPhone?.number ?? 'No phone'}\n'
        '${primaryEmail?.address ?? 'No email'}',
      ),
      isThreeLine: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerDetailScreen(customer: customer),
          ),
        );
      },
    );
  }
}
