import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/features/core/utils/circular_container.dart';
import 'package:bus_app/src/features/core/utils/curved_edges_widget.dart';
import 'package:flutter/material.dart';

class tPrimaryHeaderContainer extends StatelessWidget {
  const tPrimaryHeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return tCurvedEdgeWidget(
      child:Container(
        color: tPrimaryColor,
    
      child: Stack(
          children: [
            Positioned(top: -150, right: -250, child: tCircularContainer(backgroundColor: tWhiteColor.withOpacity(0.1), padding: tDashboardCardPadding,)),
              Positioned(top: 100, right: -300, child: tCircularContainer(backgroundColor: tWhiteColor.withOpacity(0.1), padding: tDashboardCardPadding,)),
              child,
    
                ],
              ),
            ),
          );
  }
}
