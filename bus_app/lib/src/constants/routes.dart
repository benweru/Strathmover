import 'package:get/get.dart';
import 'package:bus_app/src/features/core/screens/dashboard/home.dart';
import 'package:bus_app/src/features/core/screens/dashboard/widgets/route_details.dart';
import 'package:bus_app/src/features/authentication/models/route_model.dart';

class AppRoutes {
  static const String home = '/';
  static const String routeDetails = '/routeDetails';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(
      name: routeDetails,
      page: () {
        final args = Get.arguments as RouteModel;
        return RouteDetails(route: args);
      },
    ),
    // Add more routes as needed
  ];
}
