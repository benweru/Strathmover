import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/features/core/utils/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    Key? key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.LeadingOnPressed,
    this.showBackArrow = true,
  }) : super(key: key);

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? LeadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Container(
        color: Colors.transparent, // Ensure the AppBar does not have its own background color
        padding: const EdgeInsets.symmetric(horizontal: tDashboardPadding),
        child: AppBar(
          automaticallyImplyLeading: true, // Use true to show a back button automatically if not specified
          leading: showBackArrow
              ? IconButton(
                  onPressed: LeadingOnPressed ?? () => Get.back(),
                  icon: const Icon(Icons.arrow_back),
                )
              : leadingIcon != null
                  ? IconButton(
                      onPressed: LeadingOnPressed ?? () => Get.back(),
                      icon: Icon(leadingIcon),
                    )
                  : null,
          title: title,
          actions: actions,
          elevation: 0, // Adjust elevation as needed
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
