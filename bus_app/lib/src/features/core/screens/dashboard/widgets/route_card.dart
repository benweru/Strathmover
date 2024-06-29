import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_app/src/features/authentication/models/route_model.dart';
import 'package:bus_app/src/features/core/screens/dashboard/widgets/route_details.dart';

class RouteCard extends StatelessWidget {
  final RouteModel route;

  const RouteCard({required this.route, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Get.to(() => RouteDetails(route: route));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: tDashboardCardPadding, vertical: tDashboardCardPadding),
        height: tDashboardPadding * 7.5,
        child: Card(
          elevation: buttonElevation,
          color: tAccentColor.withOpacity(0.5),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.33,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: tDashboardCardPadding,
                      vertical: tDashboardCardPadding * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        route.name,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.star_border,
                              color: Colors.yellow, size: fontSizeMd),
                          const Spacer(flex: 1),
                          Text(
                            '4.5', // Replace with actual rating logic
                            style: textTheme.bodySmall,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
