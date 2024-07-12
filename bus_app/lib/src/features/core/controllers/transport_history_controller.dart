import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bus_app/src/features/authentication/models/booking_model.dart';

class TransportHistoryController extends GetxController {
  var bookings = <BookingModel>[].obs;
  var isLoading = true.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  void fetchBookings() async {
    isLoading.value = true;
    final user = _auth.currentUser;

    if (user != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('bookings')
            .where('userId', isEqualTo: user.uid)
            .orderBy('date', descending: true)
            .get();

        if (snapshot.docs.isNotEmpty) {
          bookings.value = snapshot.docs.map((doc) {
            print("Document fetched: ${doc.data()}");
            return BookingModel.fromSnapshot(
                doc as DocumentSnapshot<Map<String, dynamic>>);
          }).toList();
        } else {
          bookings.clear();
          print("No bookings found for user ${user.uid}");
        }
      } catch (e) {
        print("Error fetching bookings: $e");
      }
    } else {
      print("No user logged in");
    }
    isLoading.value = false;
  }

  void filterByDepartureTime(String departureTime) {
    final filtered = bookings.where((booking) {
      return booking.departureTime == departureTime;
    }).toList();
    bookings.value = filtered;
  }

  void filterByDateRange(DateTime startDate, DateTime endDate) {
    final filtered = bookings.where((booking) {
      final bookingDate = DateTime.parse(booking.date);
      return bookingDate.isAfter(startDate) && bookingDate.isBefore(endDate);
    }).toList();
    bookings.value = filtered;
  }

  void resetFilters() {
    fetchBookings();
  }
}
