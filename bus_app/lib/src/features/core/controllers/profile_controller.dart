import 'package:bus_app/src/features/authentication/models/user_model.dart';
import 'package:bus_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:bus_app/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  Rx<UserModel> user = UserModel(
    id: '',
    email: '',
    password: '',
    fullName: '',
    phoneNo: '',
    profilePicture: '',
  ).obs;

  final imageUploading = false.obs;

  // Controllers
  RxBool showPassword = false.obs;
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

  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
  }

// Upload User Profile Picture
  Future<void> uploadUserProfilePicture(UserModel value) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (image != null) {
      imageUploading.value = true;
      final String? imageUrl =
          await _userRepo.uploadImage('Users/Images/Profile/', image);

      if (imageUrl != null) {
        // Update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await _userRepo.updateSingleField(user.value.id!, json);

        // Update the observable user model
        user.update((val) {
          user.value = user.value.copyWith(profilePicture: imageUrl);
        });
        Get.snackbar(
          "Success",
          "Profile picture updated successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to upload image. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    }
    imageUploading.value = false;
  }
}
