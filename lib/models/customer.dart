import 'address.dart';
import 'phone.dart';
import 'email.dart';

class Customer {
  final String id;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String maritalStatus;
  final String secureId;
  final List<Address> addresses;
  final List<Phone> phones;
  final List<Email> emails;

  const Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.maritalStatus,
    required this.secureId,
    required this.addresses,
    required this.phones,
    required this.emails,
  });
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      maritalStatus: json['maritalStatus'] as String,
      secureId: json['secureId'] as String,
      addresses: (json['addresses'] as List)
          .map((item) => Address.fromJson(item as Map<String, dynamic>))
          .toList(),
      phones: (json['phones'] as List)
          .map((item) => Phone.fromJson(item as Map<String, dynamic>))
          .toList(),
      emails: (json['emails'] as List)
          .map((item) => Email.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
