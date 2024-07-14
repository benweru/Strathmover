import 'package:bus_app/src/features/core/screens/routes/trips_service.dart';
import 'package:flutter/material.dart';
import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/features/authentication/models/route_model.dart';
import 'package:bus_app/src/features/authentication/models/trip_model.dart';
import 'package:bus_app/src/features/core/screens/dashboard/widgets/custom_appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RouteDetails extends StatefulWidget {
  final RouteModel route;

  const RouteDetails({required this.route, Key? key}) : super(key: key);

  @override
  State<RouteDetails> createState() => _RouteDetailsState();
}

class _RouteDetailsState extends State<RouteDetails> {
  bool isFav = false;
  List<TripModel> trips = [];
  final TripService _tripService = TripService();

  @override
  void initState() {
    super.initState();
    fetchTrips();
  }

  Future<void> fetchTrips() async {
    try {
      final fetchedTrips = await _tripService.fetchTodaysTrips(widget.route.id);
      print('Fetched trips: ${fetchedTrips.length}'); // Debugging statement
      setState(() {
        trips = fetchedTrips;
      });
    } catch (e) {
      print('Error fetching trips: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppbar(
        appTitle: 'Route Details',
        icon: FaIcon(Icons.arrow_back_rounded, color: colorScheme.onPrimary),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: tAccentColor,
            ),
          ),
        ],
        onBackPressed: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            children: <Widget>[
              BusesHandlingRoute(trips: trips),
              AboutRoute(route: widget.route),
              SizedBox(height: tDefaultSize),
              RoutePointsList(route: widget.route),
            ],
          ),
        ),
      ),
    );
  }
}

class BusesHandlingRoute extends StatelessWidget {
  final List<TripModel> trips;

  const BusesHandlingRoute({required this.trips, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return Container();
    }

    var textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(tDashboardPadding),
      margin: const EdgeInsets.only(bottom: tDashboardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Buses handling this route for today:',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          for (var trip in trips)
            ListTile(
              leading: Icon(Icons.directions_bus),
              title: Text(
                'Bus ID: ${trip.busId}',
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Departure Time: ${trip.departureTime}',
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AboutRoute extends StatelessWidget {
  final RouteModel route;

  const AboutRoute({required this.route, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(height: spaceBtwItems),
          Text(
            route.name,
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class RoutePointsList extends StatelessWidget {
  final RouteModel route;

  const RoutePointsList({required this.route, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(tDashboardPadding),
      margin: const EdgeInsets.only(bottom: tDashboardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (var point in route.points)
            ListTile(
              leading: Icon(
                point.isBusStop ? Icons.directions_bus : Icons.directions,
              ),
              title: Text(
                point.name,
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                point.description ?? '',
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
