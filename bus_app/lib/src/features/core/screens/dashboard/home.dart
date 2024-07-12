import 'package:bus_app/src/features/core/controllers/routes_controller.dart';
import 'package:bus_app/src/features/core/screens/dashboard/widgets/booking_card.dart';
// import 'package:bus_app/src/features/core/screens/dashboard/widgets/route_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/features/core/controllers/profile_controller.dart';
import 'package:bus_app/src/features/authentication/models/route_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  List<RouteModel> favoriteRoutes = []; // List to store favorite routes

  @override
  void initState() {
    super.initState();
    fetchFavoriteRoutes(); // Fetch favorite routes on initialization
    profileController.getUserData().then((user) {
      if (user != null) {
        profileController.user.value = user;
      }
    });
  }

  void fetchFavoriteRoutes() {
    // Replace with actual logic to fetch favorite routes from Firebase or any other source
    // For demonstration, assume some routes are fetched
    setState(() {
      favoriteRoutes = [
        RouteModel(name: 'Route A', points: []),
        RouteModel(name: 'Route B', points: []),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    final RouteController routeController = Get.put(RouteController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: tDefaultSize * 0.8,
          vertical: tDefaultSize * 1.2,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Obx(() {
                      return Text(
                        'Welcome, ${profileController.user.value.fullName.isNotEmpty ? profileController.user.value.fullName : 'User'}',
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      );
                    }),
                    SizedBox(
                      child: Obx(() {
                        return CircleAvatar(
                          radius: 30,
                          backgroundImage: profileController
                                  .user.value.profilePicture.isNotEmpty
                              ? NetworkImage(
                                  profileController.user.value.profilePicture)
                              : AssetImage(
                                      'assets/images/profile/profile-pic.jpg')
                                  as ImageProvider,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: tDashboardPadding),
                const BookingCard(),
                const SizedBox(height: tDashboardPadding),
                const Text('Booked Routes', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 10),
                Obx(() {
                  if (routeController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (routeController.bookedRoutes.isEmpty) {
                    return Text('No booked routes for today.');
                  }

                  return Column(
                    children: routeController.bookedRoutes
                        .map((route) => RouteCard(route: route))
                        .toList(),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RouteCard extends StatelessWidget {
  final String route;

  const RouteCard({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(
          255, 122, 232, 236), // Setting the background color of the card
      child: ListTile(
        title: Text(route),
        // onTap: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder:

        //       (context) => RouteDetails(route: route),
      ),
    );
  }
}
