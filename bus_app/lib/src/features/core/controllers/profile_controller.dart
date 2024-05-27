import 'package:bus_app/src/features/authentication/models/user_model.dart';
import 'package:bus_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:bus_app/src/repository/user_repository/user_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  // Controllers
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  // Repositories
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  /// Get User Email and pass to UserRepository to fetch user record.
  Future<UserModel?> getUserData() async {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return await _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
      return null;
    }
  }

  Future<List<UserModel>> getAllUser() async {
    return await _userRepo.allUsers();
  }
}
