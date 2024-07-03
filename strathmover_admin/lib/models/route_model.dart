import 'package:cloud_firestore/cloud_firestore.dart';

class RouteModel {
  final String? id;
  final String name;
  final List<RoutePoint> points;

  RouteModel({
    this.id,
    required this.name,
    required this.points,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'points': points.map((point) => point.toMap()).toList(),
    };
  }

  factory RouteModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    final pointsData = data['points'] as List<dynamic>;
    final points = pointsData.map((point) => RoutePoint.fromMap(point as Map<String, dynamic>)).toList();

    return RouteModel(
      id: document.id,
      name: data['name'] as String,
      points: points,
    );
  }

  RouteModel copyWith({
    String? id,
    String? name,
    List<RoutePoint>? points,
  }) {
    return RouteModel(
      id: id ?? this.id,
      name: name ?? this.name,
      points: points ?? this.points,
    );
  }
}

class RoutePoint {
  final String name;
  final GeoPoint location;

  RoutePoint({
    required this.name,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
    };
  }

  factory RoutePoint.fromMap(Map<String, dynamic> map) {
    return RoutePoint(
      name: map['name'] as String,
      location: map['location'] != null ? map['location'] as GeoPoint : const GeoPoint(0, 0),
    );
  }
}
