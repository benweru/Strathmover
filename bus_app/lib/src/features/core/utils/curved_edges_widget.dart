import 'package:bus_app/src/features/core/utils/curved_edges.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class tCurvedEdgeWidget extends StatelessWidget {
  const tCurvedEdgeWidget({
    super.key, this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: tCustomCurvedEdges(),
      child: child,
    );
  }
}