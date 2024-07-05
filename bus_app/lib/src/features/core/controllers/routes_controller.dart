import 'package:bus_app/src/features/authentication/models/route_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RouteController extends GetxController {
  var routes = <RouteModel>[].obs;
  var bookedRoutes = <String>[].obs;
  var isLoading = true.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchRoutes();
    fetchBookedRoutes();
  }

  void fetchRoutes() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('routes').get();
      var fetchedRoutes =
          snapshot.docs.map((doc) => RouteModel.fromSnapshot(doc)).toList();
      routes.value = fetchedRoutes;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch routes');
      print('Error fetching routes: $e');
    }
  }
  Future<void> fetchBookedRoutes() async {
    try {
      isLoading.value = true;
      final user = _auth.currentUser;
      if (user == null) return;

      final date = DateTime.now();
      final today = '${date.year}-${date.month}-${date.day}';

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userId', isEqualTo: user.uid)
          .where('date', isEqualTo: today)
          .get();

      if (snapshot.docs.isNotEmpty) {
        List<String> routes = snapshot.docs
            .map((doc) => doc['route'] as String)
            .toSet()
            .toList();

        bookedRoutes.value = routes;
      } else {
        bookedRoutes.clear();
      }
    } catch (e) {
      print("Error fetching booked routes: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
