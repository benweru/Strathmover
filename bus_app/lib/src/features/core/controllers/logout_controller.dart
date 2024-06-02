import 'package:get/get.dart';
import 'package:bus_app/src/repository/authentication_repository/authentication_repository.dart';

class LogoutController extends GetxController {
  static LogoutController get instance => Get.find();

  void logout() async {
    await AuthenticationRepository.instance.logout();
  }
}
