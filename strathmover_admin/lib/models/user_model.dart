// models/user_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String profilePicture;

  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNo,
    required this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "ProfilePicture": profilePicture,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data['Email'] as String? ?? '',
      password: data['Password'] as String? ?? '',
      fullName: data['FullName'] as String? ?? '',
      phoneNo: data['Phone'] as String? ?? '',
      profilePicture: data['ProfilePicture'] as String? ?? '',

    );
  }
  

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNo,
    String? password,
    String? profilePicture,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phoneNo: phoneNo ?? this.phoneNo,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
