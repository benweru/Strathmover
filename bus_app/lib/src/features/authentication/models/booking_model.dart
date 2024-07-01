import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_app/src/features/authentication/models/trip_model.dart';

class BookingModel {
  final String? id;
  final String userId;
  final String tripId;
  final String date;
  final String departureTime;
  final String busId;
  final String route;

  BookingModel({
    this.id,
    required this.userId,
    required this.tripId,
    required this.date,
    required this.departureTime,
    required this.busId,
    required this.route,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "tripId": tripId,
      "date": date,
      "departureTime": departureTime,
      "busId": busId,
      "route": route,
    };
  }

  factory BookingModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return BookingModel(
      id: document.id,
      userId: data['userId'] ?? '',
      tripId: data['tripId'] ?? '',
      date: data['date'] ?? '',
      departureTime: data['departureTime'] ?? '',
      busId: data['busId'] ?? '',
      route: data['route'] ?? '',
    );
  }

  TripModel toTripModel() {
    return TripModel(
      tripId: tripId,
      date: date,
      departureTime: departureTime,
      busId: busId,
      route: route,
      id: userId,
    );
  }

  BookingModel copyWith({
    String? id,
    String? userId,
    String? tripId,
    String? date,
    String? departureTime,
    String? busId,
    String? route,
  }) {
    return BookingModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tripId: tripId ?? this.tripId,
      date: date ?? this.date,
      departureTime: departureTime ?? this.departureTime,
      busId: busId ?? this.busId,
      route: route ?? this.route,
    );
  }
}
