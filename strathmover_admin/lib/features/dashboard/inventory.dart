import 'package:cloud_firestore/cloud_firestore.dart';

class Inventory {
  final String email;
  final String fullName;
  final String password;
  final String phone;

  Inventory({
    required this.email,
    required this.fullName,
    required this.password,
    required this.phone,
  });

  static const itemCount = 4;

  factory Inventory.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Inventory(
      email: data['email'] is String ? data['email'] as String : '',
      fullName: data['fullName'] is String ? data['fullName'] as String : '',
      password: data['password'] is String ? data['password'] as String : '',
      phone: data['phone'] is String ? data['phone'] as String : '',
    );
  }
}
