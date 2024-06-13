import 'package:bus_app/src/constants/colours.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class tCircularContainer extends StatelessWidget {
  const tCircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.backgroundColor = tWhiteColor, required this.padding,
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(400),
        color: tPrimaryColor.withOpacity(0.1),
      ),
      child: child,
    );
  }
}