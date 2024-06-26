import 'package:bus_app/src/features/authentication/models/route_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDetailScreen extends StatelessWidget {
  final RouteModel route;

  RouteDetailScreen({required this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(route.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(-1.286389, 36.817223),
                zoom: 12,
              ),
              markers: route.points.map((point) {
                return Marker(
                  markerId: MarkerId(point.name),
                  position: LatLng(
                    // Provide the actual lat/lng for each point
                    // Example coordinates
                    point.isBusStop ? -1.286389 : -1.287389,
                    point.isBusStop ? 36.817223 : 36.818223,
                  ),
                  infoWindow: InfoWindow(title: point.name),
                );
              }).toSet(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: route.points.length,
              itemBuilder: (context, index) {
                final point = route.points[index];
                return ListTile(
                  leading: Icon(
                    point.isBusStop ? Icons.directions_bus : Icons.directions,
                  ),
                  title: Text(point.name),
                  subtitle: Text(point.description),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
