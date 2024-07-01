import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
            return BookingModel.fromSnapshot(
                doc as DocumentSnapshot<Map<String, dynamic>>);
          }).toList();
        } else {
          bookings.clear();
        }
      } catch (e) {
        print("Error fetching bookings: $e");
      }
    }
    isLoading.value = false;
  }
}
