import 'package:flutter_test/flutter_test.dart';
import 'package:care247/models/customer.dart';

void main() {
  test('Customer.fromJson parses valid JSON correctly', () {
    final json = {
      'id': 'cust-001',
      'firstName': 'John',
      'lastName': 'Smith',
      'dateOfBirth': '1985-03-15',
      'maritalStatus': 'Married',
      'secureId': '123-45-6789',
      'addresses': [
        {
          'id': 'addr-001',
          'type': 'Home',
          'street': '123 Oak Street',
          'city': 'San Francisco',
          'state': 'CA',
          'zipCode': '94102',
        },
      ],
      'phones': [
        {
          'id': 'phone-001',
          'type': 'Mobile',
          'number': '+1-415-555-0123',
          'isPrimary': true,
        },
      ],
      'emails': [
        {
          'id': 'email-001',
          'type': 'Personal',
          'address': 'john.smith@email.com',
          'isPrimary': true,
        },
      ],
    };

    final customer = Customer.fromJson(json);

    expect(customer.firstName, 'John');
    expect(customer.lastName, 'Smith');
    expect(customer.addresses.length, 1);
    expect(customer.addresses.first.city, 'San Francisco');
    expect(customer.phones.first.isPrimary, true);
    expect(customer.emails.first.address, 'john.smith@email.com');
  });
}
