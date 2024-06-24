import 'package:bus_app/src/constants/routes.dart';
import 'package:bus_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bus_app/firebase_options.dart';
import 'package:bus_app/src/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'src/features/authentication/screens/splash_screen/splash_screen.dart';

//Initialize Firebase and Auth repo
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthenticationRepository());
  //await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      getPages: AppRoutes.routes,
      home: SplashScreen(),
    );
  }
}
