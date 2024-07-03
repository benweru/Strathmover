import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String? id;
  final String date;
  final String departureTime;
  final String busId;
  final String route;

  TripModel({
    this.id,
    required this.date,
    required this.departureTime,
    required this.busId,
    required this.route,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'departureTime': departureTime,
      'busId': busId,
      'route': route,
    };
  }

  factory TripModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TripModel(
      id: document.id,
      date: data['date'] as String,
      departureTime: data['departureTime'] as String,
      busId: data['busId'] as String,
      route: data['route'] as String,
    );
  }

  TripModel copyWith({
    String? id,
    String? date,
    String? departureTime,
    String? busId,
    String? route,
  }) {
    return TripModel(
      id: id ?? this.id,
      date: date ?? this.date,
      departureTime: departureTime ?? this.departureTime,
      busId: busId ?? this.busId,
      route: route ?? this.route,
    );
  }
}
