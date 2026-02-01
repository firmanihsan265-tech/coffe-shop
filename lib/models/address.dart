// models/address.dart
class Address {
  final String id;
  final String name;
  final String street;
  final String city;
  final String postalCode;
  final String phone;
  final bool isDefault;

  Address({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.postalCode,
    required this.phone,
    this.isDefault = false,
  });

  String get fullAddress {
    return '$street, $city, $postalCode';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'street': street,
      'city': city,
      'postalCode': postalCode,
      'phone': phone,
      'isDefault': isDefault,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      street: json['street'],
      city: json['city'],
      postalCode: json['postalCode'],
      phone: json['phone'],
      isDefault: json['isDefault'] ?? false,
    );
  }
}