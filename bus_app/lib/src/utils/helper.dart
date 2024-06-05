import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helper {
//validate email
  static String? validateEmail(String? value, [String? emailInUseError]) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }

  // Regular expression for email validation
  final emailRegExp = RegExp(r'[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

  if (!emailRegExp.hasMatch(value)) {
    return 'Invalid Email Address';
  }
  
   if (emailInUseError != null) {
    return 'Email is already in use';}
  
  return null;
}

//validate password
  static String? validatePassword(String? value, [String? username]) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8 || value.length > 16) {
    return 'Password must be 8 to 16 characters in length';
  }
  if (value.contains(' ')) {
    return 'Password cannot contain spaces';
  }
  
  if (username != null && value.contains(username)) {
    return 'Password cannot include your username';
  }
  if (value.toLowerCase() == 'password' || value == '12345678') {
    return 'Password cannot be a commonly used word or sequence of numbers';
  }
  final specialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  if (!specialChars.hasMatch(value)) {
    return 'Password must contain at least one special character';
  }
  return null;
}

//validate phoneNumber
  static String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }
  final phoneRegExp = RegExp(r'^\+254\d{8}$');

  if (!phoneRegExp.hasMatch(value)) {
    return 'Invalid phone number';
  }
  return null;
}
// Usage Example
void main() {
  // Example email addresses
  List<String> emails = [
    'test@example.com', // Valid
    'invalid_email',    // Invalid
    'invalid.com',      // Invalid
    '123@invalid.com',  // Invalid
  ];

  // Validate each email address
  emails.forEach((email) {
    print('Email: $email');
    final validationError = validateEmail(email,null);
    if (validationError != null) {
      print('Validation Error: $validationError');
    } else {
      print('Email is valid.');
    }
    print('---------------------------');
  });
}

// confirmpassword
  static String? validateConfirmPassword(String? value, [String? password]) {
  if (value == null || value.isEmpty) {
    return 'Confirm password is required';
  }
  if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}



  static void errorSnackBar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
