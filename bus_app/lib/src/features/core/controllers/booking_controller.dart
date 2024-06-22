import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_app/src/features/authentication/models/trip_model.dart';
import 'package:flutter/material.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();

  var currentStep = 0.obs;
  var trips = <TripModel>[].obs;

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
    final today = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    final tripStatusDoc = FirebaseFirestore.instance
        .collection('system')
        .doc('dailyTripStatus');

    final tripStatusSnapshot = await tripStatusDoc.get();

    if (tripStatusSnapshot.exists) {
      final data = tripStatusSnapshot.data();
      if (data != null && data['lastUpdated'] == today) {
        print("Trips already created for today: $today");
        fetchTrips();
        return;
      }
    }

    // If trips are not created for today, create them
    await createTripsForToday(today, tripStatusDoc);
  }

  Future<void> createTripsForToday(String today, DocumentReference tripStatusDoc) async {
    final tripsData = [
      { 'departureTime': '07:30', 'busId': 'bus1' },
      { 'departureTime': '16:30', 'busId': 'bus2' },
      { 'departureTime': '19:30', 'busId': 'bus3' }
    ];

    final batch = FirebaseFirestore.instance.batch();

    tripsData.forEach((trip) {
      final tripRef = FirebaseFirestore.instance.collection('trips').doc();
      batch.set(tripRef, {
        ...trip,
        'date': today,
      });
    });

    // Update the trip status document
    batch.set(tripStatusDoc, {
      'lastUpdated': today,
    });

    await batch.commit();

    print("Trips created for today: $today");

    fetchTrips();
  }

  void fetchTrips() async {
    try {
      final today = DateTime.now().toIso8601String().split('T')[0];
      print("Fetching trips for today: $today");

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('trips')
          .where('date', isEqualTo: today)
          .get();

      if (snapshot.docs.isEmpty) {
        print("No trips found for today.");
      } else {
        print("Trips found for today: ${snapshot.docs.length}");
      }

      List<TripModel> fetchedTrips = snapshot.docs
          .map((doc) => TripModel.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();

      trips.value = fetchedTrips;
    } catch (e) {
      showFetchError();
      print("Error fetching trips: $e");
    }
  }

  void showFetchError() {
    Get.snackbar(
      "Error",
      "Failed to fetch trips.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
