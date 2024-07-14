import 'package:bus_app/src/features/core/screens/routes/route_point.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RouteModel {
  final String id;
  final String name;
  final List<RoutePoint> points;

  RouteModel({
    required this.id,
    required this.name,
    required this.points,
  });

  factory RouteModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final pointsData = data['points'] as List<dynamic>;
    final points =
        pointsData.map((point) => RoutePoint.fromMap(point)).toList();

    return RouteModel(
      id: doc.id,
      name: data['name'],
      points: points,
    );
  }
}
