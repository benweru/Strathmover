import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/routes.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteCard extends StatelessWidget {
  const RouteCard({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: tDashboardCardPadding, vertical: tDashboardCardPadding),
      height: tDashboardPadding * 7.5,
      child: GestureDetector(
        child: Card(
          elevation: buttonElevation,
          color: tAccentColor,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.33,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: tDashboardCardPadding, vertical: tDashboardCardPadding * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Route1',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Stops 1-5',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.star_border, color: Colors.yellow, size: fontSizeMd),
                          const Spacer(flex: 1),
                          Text(
                            '4.5',
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
        onTap: () {
          Get.toNamed(AppRoutes.routeDetails);
        },
      ),
    );
  }
}
