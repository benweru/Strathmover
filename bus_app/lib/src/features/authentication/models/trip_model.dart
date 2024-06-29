import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  String tripId;
  String date;
  String departureTime;
  String busId;
  String route;

  TripModel({
    required this.tripId,
    required this.date,
    required this.departureTime,
    required this.busId,
    required this.route,
  });

  factory TripModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return TripModel(
      tripId: snapshot.id, // use snapshot.id to get the document ID
      date: data['date'] ?? '',
      departureTime: data['departureTime'] ?? '',
      busId: data['busId'] ?? '',
      route: data['route'] ?? '',
    );
  }
}
