import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String id;
  final String departureTime;
  final String busId;
  final String date;
  final String route;

  TripModel({
    required this.id,
    required this.departureTime,
    required this.busId,
    required this.date,
    required this.route,
  });

  factory TripModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return TripModel(
      id: snapshot.id,
      departureTime: data['departureTime'] ?? '',
      busId: data['busId'] ?? '',
      date: data['date'] ?? '',
      route: data['route'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departureTime': departureTime,
      'busId': busId,
      'date': date,
      'route': route,
    };
  }
}
