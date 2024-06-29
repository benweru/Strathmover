import 'package:bus_app/src/features/authentication/models/route_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RouteController extends GetxController {
  var routes = <RouteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRoutes();
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
}
