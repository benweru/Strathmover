import 'package:bus_app/src/features/core/screens/routes/route_point.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RouteModel {
  String id;
  String name;
  String description;
  List<RoutePoint> points;

  RouteModel({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'points': points.map((point) => point.toMap()).toList(),
    };
  }

  static RouteModel fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return RouteModel(
      id: snapshot.id,
      name: data['name'],
      description: data['description'],
      points: List<RoutePoint>.from(
        data['points'].map((item) => RoutePoint.fromMap(item)),
      ),
    );
  }
}
