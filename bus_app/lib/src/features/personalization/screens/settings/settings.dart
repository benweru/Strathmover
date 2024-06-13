import 'package:bus_app/src/common_widgets/list_tiles/setting_menu_tile.dart';
import 'package:bus_app/src/common_widgets/list_tiles/user_profile_tile.dart';
import 'package:bus_app/src/features/core/utils/appbar.dart';
import 'package:bus_app/src/features/core/utils/primary_header_container.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            tPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                      title: Text('Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: Colors.white))),

                  //User Profile Card
                  const TUserProfile(),
          
                  const SizedBox(height: Tsizes.spaceBtwSections),
                ],
              ),
            ),

            /// -- Body
             Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
               children: [
              // Account Settings
              TSectionHeading(title:'Account Settings',showActionButton: false),
              SizedBox(height: TSizes.spaceBtwItems),

              TSettingsMenuTile(icon: Iconsax.safe_home, title:' My destination', subTitle: 'Set destination', onTap: (){},), 
         ],
        ),
      ),
      ]),
    ),
    );
  }
}


