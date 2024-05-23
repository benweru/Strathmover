import 'package:bus_app/src/constants/images_strings.dart';
import 'package:bus_app/src/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colours.dart';
import '../../../../constants/sizes.dart';
import '../../controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.put(SplashScreenController());


  @override
  Widget build(BuildContext context) {
    SplashScreenController.find.startAnimation();


    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: splashController.animate.value ? 0 : -30,
              left: splashController.animate.value ? 0 : -30,
              child: const SizedBox(
                  width: 300, 
                  height: 100, 
                  child: Image(image: AssetImage(tSplashTopIcon)),
                ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              top: 80,
              left: splashController.animate.value ? tDefaultSize : -80,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                opacity: splashController.animate.value ? 1 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tAppName, style: Theme.of(context).textTheme.headlineSmall),
                    Text(tAppTagLine, style: Theme.of(context).textTheme.headlineMedium)
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 2400),
              bottom: splashController.animate.value ? 100 : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                opacity: splashController.animate.value ? 1 : 0,
                child: const SizedBox(
                  width: 300, // Set the desired width
                  height: 300, // Set the desired height
                  child: Image(image: AssetImage(tSplashImage)),
                ),
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 2400),
              bottom: splashController.animate.value ? 60 : 0,
              right: tDefaultSize,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                opacity: splashController.animate.value ? 1 : 0,
                child: Container(
                  width: tSplashContainerSize,
                  height: tSplashContainerSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: tPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}