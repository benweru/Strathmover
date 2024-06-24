import 'package:bus_app/src/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppbar({
    this.appTitle,
    this.icon,
    this.onBackPressed,
    required this.actions,
    super.key,
  });

  final String? appTitle;
  final FaIcon? icon;
  final VoidCallback? onBackPressed;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: tWhiteColor,
      elevation: 0,
      title: Text(
        widget.appTitle ?? '',
        style: textTheme.headlineSmall?.copyWith(
          color: tDarkColor,
        ),
      ),
      leading: widget.icon != null
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: tPrimaryColor,
              ),
              child: IconButton(
                onPressed: widget.onBackPressed ?? Get.back,
                icon: widget.icon!,
                iconSize: 16,
                color: tWhiteColor,
              ),
            )
          : null,
      actions: widget.actions,
    );
  }
}
