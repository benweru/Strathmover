import 'package:bus_app/src/features/authentication/models/trip_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TripService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TripModel>> fetchTodaysTrips(String routeId) async {
    try {
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);

      final querySnapshot = await _firestore
          .collection('trips')
          .where('date', isEqualTo: formattedDate)
          .where('route', isEqualTo: routeId)
          .get();

      return querySnapshot.docs
          .map((doc) => TripModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      print('Error fetching today\'s trips: $e');
      return [];
    }
  }
}
