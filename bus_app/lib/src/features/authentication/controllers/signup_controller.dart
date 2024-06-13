import 'package:bus_app/src/features/authentication/models/user_model.dart';
import 'package:bus_app/src/repository/user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final userRepo = Get.put(UserRepository());

  // Form key for signup form
  final signupFormKey = GlobalKey<FormState>();

  // Observable to manage loading state
  final isLoading = false.obs;
  var showPassword = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Call this Function from Design & it will do the rest
  void registerUser(String email, String password) {
    String? error = AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }

  // Create user into Firebase Database using either Email or Phone Number
  Future<void> createUser(UserModel user) async {
    try {
      isLoading.value = true;
      if (!(signupFormKey.currentState?.validate() ?? false)) {
        isLoading.value = false;
        return;
      }

      // Authenticate User First
      final auth = AuthenticationRepository.instance;
      await auth.createUserWithEmailAndPassword(user.email, user.password);
      await userRepo.createUser(user);
      auth.setInitialScreen(auth.firebaseUser.value);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }

  // Get phoneNo from user (Screen) and pass it to Auth Repository for Firebase Authentication
  Future<void> phoneAuthentication(String phoneNo) async {
    try {
      await AuthenticationRepository.instance.phoneAuthentication(phoneNo);
    } catch (e) {
      throw e.toString();
    }
  }

  // Google Sign-In logic
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        isLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      // Handle successful sign-in
      isLoading.value = false;
      Get.snackbar("Success", "Google Sign-In Successful",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Google sign-in failed: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    fullName.dispose();
    phoneNo.dispose();
    super.onClose();
  }
}
