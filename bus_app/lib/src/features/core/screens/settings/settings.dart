import 'package:bus_app/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/features/core/utils/appbar.dart';
import 'package:bus_app/src/features/core/utils/primary_header_container.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            tPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: tWhiteColor))),
                  const SizedBox(height: spaceBtwSections),
                  
                ],
              )
              )
          ],
        ),
        
      )
    );
  }
}