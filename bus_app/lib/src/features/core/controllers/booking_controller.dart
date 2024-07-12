import 'package:bus_app/src/features/authentication/models/booking_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bus_app/src/features/authentication/models/trip_model.dart';
import 'package:flutter/material.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();

  var currentStep = 0.obs;
  var trips = <TripModel>[].obs;
  var selectedTrip = Rx<TripModel?>(null);
  var availableSeats = <String>[].obs;
  var selectedSeat = ''.obs;
  var userBooking = Rx<TripModel?>(null);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    checkAndCreateTrips();
    fetchUserBooking();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < 3) {
      currentStep.value = step;
    }
  }

  void fetchTrips() async {
    try {
      final date = DateTime.now();
      final today = '${date.year}-${date.month}-${date.day}';

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('trips')
          .where('date', isEqualTo: today)
          .get();

      if (snapshot.docs.isEmpty) {
        trips.clear();
      } else {
        List<TripModel> fetchedTrips = snapshot.docs
            .map((doc) => TripModel.fromSnapshot(
                doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList();

        trips.value = fetchedTrips;
      }
    } catch (e) {
      showFetchError();
      print("Error fetching trips: $e");
    }
  }

  void checkAndCreateTrips() async {
    final date = DateTime.now();
    final today = '${date.year}-${date.month}-${date.day}';

    final tripStatusDoc =
        FirebaseFirestore.instance.collection('system').doc('dailyTripStatus');

    final tripStatusSnapshot = await tripStatusDoc.get();

    if (tripStatusSnapshot.exists) {
      final data = tripStatusSnapshot.data();
      if (data != null && data['lastUpdated'] == today) {
        fetchTrips();
        return;
      }
    }

    await createTripsForToday(today, tripStatusDoc);
  }

  Future<void> createTripsForToday(
      String today, DocumentReference tripStatusDoc) async {
    final tripsData = [
      {'departureTime': '07:30', 'busId': 'bus1', 'route': 'CBD -> Madaraka'},
      {'departureTime': '16:30', 'busId': 'bus2', 'route': 'Madaraka -> CBD'},
      {'departureTime': '19:30', 'busId': 'bus3', 'route': 'Madaraka -> CBD'}
    ];

    final batch = FirebaseFirestore.instance.batch();

    for (var trip in tripsData) {
      final tripRef = FirebaseFirestore.instance.collection('trips').doc();
      batch.set(tripRef, {
        ...trip,
        'date': today,
      });

      final busRef =
          FirebaseFirestore.instance.collection('buses').doc(trip['busId']);
      batch.update(busRef, {
        'availableSeats': trip['busId'] == 'bus2'
            ? List.generate(54, (index) => '${index + 1}')
            : List.generate(44, (index) => '${index + 1}'),
        'bookedSeats': [],
      });
    }

    batch.set(tripStatusDoc, {
      'lastUpdated': today,
    });

    await batch.commit();
    fetchTrips();
  }

  void selectTrip(TripModel trip) {
    selectedTrip.value = trip;
    fetchAvailableSeats(trip.busId);
  }

  void selectSeat(String seat) {
    selectedSeat.value = seat;
  }

  void showFetchError() {
    Get.snackbar(
      "Failed to book seat",
      "You already booked a seat on this bus",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.black,
    );
  }

  void fetchAvailableSeats(String busId) async {
    try {
      DocumentSnapshot busSnapshot =
          await FirebaseFirestore.instance.collection('buses').doc(busId).get();

      if (busSnapshot.exists) {
        Map<String, dynamic>? data =
            busSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          List<String> seats = List<String>.from(data['availableSeats']);
          availableSeats.value = seats;
        }
      }
    } catch (e) {
      showFetchError();
      print("Error fetching available seats: $e");
    }
  }

  void fetchUserBooking() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final date = DateTime.now();
    final today = '${date.year}-${date.month}-${date.day}';

    QuerySnapshot userBookingSnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('userId', isEqualTo: user.uid)
        .where('date', isEqualTo: today)
        .orderBy('departureTime')
        .get();

    if (userBookingSnapshot.docs.isNotEmpty) {
      List<TripModel> userBookings = userBookingSnapshot.docs
          .map((doc) => BookingModel.fromSnapshot(
                  doc as DocumentSnapshot<Map<String, dynamic>>)
              .toTripModel())
          .toList();

      userBooking.value = userBookings.firstWhere((booking) {
        final departureTime =
            DateTime.parse('${today}T${booking.departureTime}');
        return departureTime.isAfter(DateTime.now());
      }, orElse: () => userBookings.first);
    } else {
      userBooking.value = null;
    }
  }

  void confirmBooking() async {
    final trip = selectedTrip.value;
    final seat = selectedSeat.value;
    final user = _auth.currentUser;

    if (trip != null && seat.isNotEmpty && user != null) {
      try {
        final busDoc =
            FirebaseFirestore.instance.collection('buses').doc(trip.busId);

        final bookingDoc =
            FirebaseFirestore.instance.collection('bookings').doc();

        await FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentSnapshot busSnapshot = await transaction.get(busDoc);

          if (!busSnapshot.exists) {
            throw Exception("Bus does not exist!");
          }

          List<String> availableSeats =
              List<String>.from(busSnapshot['availableSeats']);
          List<String> bookedSeats =
              List<String>.from(busSnapshot['bookedSeats']);

          if (!availableSeats.contains(seat)) {
            throw Exception("Seat is not available");
          }

          QuerySnapshot userBookingSnapshot = await FirebaseFirestore.instance
              .collection('bookings')
              .where('tripId', isEqualTo: trip.tripId)
              .where('userId', isEqualTo: user.uid)
              .where('departureTime', isEqualTo: trip.departureTime)
              .where('busId', isEqualTo: trip.busId)
              .get();

          if (userBookingSnapshot.docs.isNotEmpty) {
            throw Exception("User has already booked a seat on this trip");
          }

          availableSeats.remove(seat);
          bookedSeats.add(seat);

          transaction.update(busDoc, {
            'availableSeats': availableSeats,
            'bookedSeats': bookedSeats,
          });

          transaction.set(bookingDoc, {
            'tripId': trip.tripId,
            'userId': user.uid,
            'seat': seat,
            'date': trip.date,
            'departureTime': trip.departureTime,
            'route': trip.route,
            'busId': trip.busId,
          });
        });

        Get.snackbar(
          "Success",
          "Booking confirmed!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        fetchUserBooking();
      } catch (e) {
        showFetchError();
        print("Error confirming booking: $e");
      }
    }
  }
}
