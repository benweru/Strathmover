import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_app/src/features/authentication/models/trip_model.dart';
import 'package:flutter/material.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();

  var currentStep = 0.obs;
  var trips = <TripModel>[].obs;
  var availableSeats = <String>[].obs;
  var selectedTrip = Rx<TripModel?>(null);
  var selectedSeat = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkAndCreateTrips();
  }

  void nextStep() {
    if (currentStep.value < 4) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < 5) {
      currentStep.value = step;
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

    // If trips are not created for today, create them
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

      // Initialize bus seats
      final busRef =
          FirebaseFirestore.instance.collection('buses').doc(trip['busId']);
      batch.update(busRef, {
        'availableSeats': trip['busId'] == 'bus2'
            ? List.generate(54, (index) => '${index + 1}')
            : List.generate(44, (index) => '${index + 1}'),
        'bookedSeats': [],
      });
    }

    // Update the trip status document
    batch.set(tripStatusDoc, {
      'lastUpdated': today,
    });

    await batch.commit();

    fetchTrips();
  }

  void fetchTrips() async {
    try {
      final date = DateTime.now();
      final today = '${date.year}-${date.month}-${date.day}';
      print("Fetching trips for date: $today");

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('trips')
          .where('date', isEqualTo: today)
          .get();

      print("Trips fetched: ${snapshot.docs.length}");

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

  void selectTrip(TripModel trip) async {
    selectedTrip.value = trip;
    await fetchAvailableSeats(trip.busId);
  }

  Future<void> fetchAvailableSeats(String busId) async {
    try {
      DocumentSnapshot busSnapshot =
          await FirebaseFirestore.instance.collection('buses').doc(busId).get();
      if (busSnapshot.exists) {
        Map<String, dynamic>? data =
            busSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          availableSeats.value = List<String>.from(data['availableSeats']);
        }
      }
    } catch (e) {
      showFetchError();
      print("Error fetching available seats: $e");
    }
  }

  void selectSeat(String seat) {
    selectedSeat.value = seat;
  }

  Future<void> bookSeat() async {
    if (selectedTrip.value == null || selectedSeat.isEmpty) return;

    try {
      final busDoc = FirebaseFirestore.instance
          .collection('buses')
          .doc(selectedTrip.value!.busId);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot busSnapshot = await transaction.get(busDoc);
        if (busSnapshot.exists) {
          List<String> available =
              List<String>.from(busSnapshot['availableSeats']);
          List<String> booked = List<String>.from(busSnapshot['bookedSeats']);
          if (available.contains(selectedSeat.value)) {
            available.remove(selectedSeat.value);
            booked.add(selectedSeat.value);
            transaction.update(busDoc, {
              'availableSeats': available,
              'bookedSeats': booked,
            });
          } else {
            throw Exception('Seat is not available');
          }
        }
      });
      nextStep();
    } catch (e) {
      showFetchError();
      print("Error booking seat: $e");
    }
  }

  void showFetchError() {
    Get.snackbar(
      "Error",
      "Failed to fetch trips or seats.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
