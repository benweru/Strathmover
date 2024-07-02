import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_app/src/features/authentication/models/booking_model.dart';
// import 'package:intl/intl.dart';

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
            print("Document fetched: ${doc.data()}"); // Debug print
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

  // void filterByDateRange(DateTime startDate, DateTime endDate) {
  //   final filteredBookings = bookings.where((booking) {
  //     final bookingDate = DateFormat('yyyy-MM-dd').parse(booking.date);
  //     return bookingDate.isAfter(startDate) && bookingDate.isBefore(endDate);
  //   }).toList();
  //   bookings.value = filteredBookings;
  // }

  void filterByDepartureTime(String departureTime) {
    final filteredBookings = bookings.where((booking) {
      return booking.departureTime == departureTime;
    }).toList();
    bookings.value = filteredBookings;
  }
}
