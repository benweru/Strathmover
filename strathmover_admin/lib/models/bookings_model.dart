import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String busId;
  final DateTime date;
  final String departureTime;
  final String route;
  final String seat;
  final String tripId;
  final String userId;

  Booking({
    required this.busId,
    required this.date,
    required this.departureTime,
    required this.route,
    required this.seat,
    required this.tripId,
    required this.userId,
  });

  factory Booking.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    final dateString = data['date'] as String;

    // Handle date format with potential missing leading zeros
    final parts = dateString.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);
    final parsedDate = DateTime(year, month, day);

    return Booking(
      busId: data['busId'] as String,
      date: parsedDate,
      departureTime: data['departureTime'] as String,
      route: data['route'] as String,
      seat: data['seat'] as String,
      tripId: data['tripId'] as String,
      userId: data['userId'] as String,
    );
  }
}

Future<List<Booking>> fetchBookings() async {
  final QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('bookings').get();
  return snapshot.docs.map((doc) => Booking.fromSnapshot(doc)).toList();
}

Map<String, int> processBookingsData(List<Booking> bookings) {
  final routeCounts = <String, int>{};
  for (var booking in bookings) {
    routeCounts.update(booking.route, (value) => value + 1, ifAbsent: () => 1);
  }
  return routeCounts;
}

