import 'package:flutter/material.dart';

import '../models/customer.dart';

class CustomerDetailScreen extends StatelessWidget {
  final Customer customer;

  const CustomerDetailScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${customer.firstName} ${customer.lastName}')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _SectionTitle('Basic Information'),
          _InfoRow('First Name', customer.firstName),
          _InfoRow('Last Name', customer.lastName),
          _InfoRow('Date of Birth', customer.dateOfBirth),
          _InfoRow('Marital Status', customer.maritalStatus),
          _InfoRow('Secure ID', customer.secureId),

          const SizedBox(height: 24),
          _SectionTitle('Addresses'),
          for (final address in customer.addresses)
            Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.type,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(address.street),
                    Text(
                      '${address.city}, ${address.state} ${address.zipCode}',
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 24),
          _SectionTitle('Phones'),
          for (final phone in customer.phones)
            ListTile(
              title: Text(phone.number),
              subtitle: Text(phone.type),
              trailing: phone.isPrimary
                  ? const Chip(label: Text('Primary'))
                  : null,
            ),

          const SizedBox(height: 24),
          _SectionTitle('Emails'),
          for (final email in customer.emails)
            ListTile(
              title: Text(email.address),
              subtitle: Text(email.type),
              trailing: email.isPrimary
                  ? const Chip(label: Text('Primary'))
                  : null,
            ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
