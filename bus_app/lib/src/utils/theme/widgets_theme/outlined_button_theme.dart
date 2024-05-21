import "package:bus_app/src/constants/colours.dart";
import "package:bus_app/src/constants/sizes.dart";
import "package:flutter/material.dart";

/* -- Light & Dark Outlined Button Themes -- */
class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); //To avoid creating instances
/* -- Light ThemeI -- */
static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    shape: const RoundedRectangleBorder(),
    foregroundColor: tSecondaryColor,
    side: const BorderSide(color: tSecondaryColor),
    padding: const EdgeInsets. symmetric(vertical: tButtonHeight),
  ),
); // OutlinedButtonThemeData
/* -- Dark Theme -- */
static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
style: OutlinedButton.styleFrom(
  shape: const RoundedRectangleBorder(),
  foregroundColor: tWhiteColor,
  side: const BorderSide(color: tWhiteColor),
  padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
)
);
}