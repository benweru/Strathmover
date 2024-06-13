import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/text_strings.dart';
import 'package:bus_app/src/features/core/utils/appbar.dart';
import 'package:bus_app/src/features/core/utils/cart_menu_icon.dart';
import 'package:flutter/material.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(title: Column(
      children: [
        Text(thomeAppBarTitle, style: Theme.of(context).textTheme.bodyMedium?.apply(color: tWhiteColor)),
        Text(thomeAppBarSubTitle, style: Theme.of(context).textTheme.bodyMedium?.apply(color: tWhiteColor)),
      ],
      ),
      actions: [
        TCartCounterIcon(onPressed: () {}, iconColor: tWhiteColor,)
      ],
    );
  }
}

