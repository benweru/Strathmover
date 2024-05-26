import 'package:bus_app/src/features/authentication/models/user_model.dart';
import 'package:bus_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:bus_app/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
}

final _authRepo = Get.put(AuthenticationRepository());
final _userRepo = Get.put(UserRepository());

//  Get User Email and pass to UserRepository to fetch user record.
Future<UserModel?> getUserData() async {
  final email = _authRepo.firebaseUser.value?.email;
  if (email != null) {
    try {
      UserModel userModel = await _userRepo.getUserDetails(email);
      return userModel;
    } catch (e) {
      Get.snackbar("Error", "Failed to get user details: $e");
      return null;
    }
  } else {
    Get.snackbar("Error", "Login to continue");
    return null;
  }
}

Future<List<UserModel>> getAllUser() async {
  return await _userRepo.allUser();
}
