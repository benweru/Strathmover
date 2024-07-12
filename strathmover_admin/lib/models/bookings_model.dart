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
    final data = snapshot.data();
    if (data == null) {
      throw StateError('Missing data for BookingId: ${snapshot.id}');
    }

    final dateString = data['date'] as String?;
    if (dateString == null) {
      throw StateError('Missing date for BookingId: ${snapshot.id}');
    }

    // Handle date format with potential missing leading zeros
    final parts = dateString.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);
    final parsedDate = DateTime(year, month, day);

    return Booking(
      busId: data['busId'] as String? ?? 'Unknown BusId',
      date: parsedDate,
      departureTime: data['departureTime'] as String? ?? 'Unknown DepartureTime',
      route: data['route'] as String? ?? 'Unknown Route',
      seat: data['seat'] as String? ?? 'Unknown Seat',
      tripId: data['tripId'] as String? ?? 'Unknown TripId',
      userId: data['userId'] as String? ?? 'Unknown UserId',
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
