import 'package:bus_app/src/features/core/screens/dashboard/home.dart';
import 'package:bus_app/src/features/core/screens/dashboard/widgets/route_details.dart';
import 'package:get/get.dart';


class AppRoutes {
  static const String home = '/';
  static const String routeDetails = '/routeDetails';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: routeDetails, page: () => const RouteDetails()),
    // Add more routes here
  ];
}
