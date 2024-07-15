import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_app/src/constants/sizes.dart';
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
          color: const Color.fromARGB(255, 122, 232, 236),
          child: Row(
            children: [
              // Left side icon
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                color: Color.fromARGB(
                    255, 122, 232, 236), // Background color for the icon
                child: const Icon(
                  Icons.route,
                  color: Colors.white,
                  size: 40, // Adjust icon size
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: tDashboardCardPadding,
                      vertical: tDashboardCardPadding * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Centering the text more
                      Center(
                        child: Text(
                          route.name,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20, // Increase font size
                          ),
                          textAlign: TextAlign.center, // Center align the text
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
