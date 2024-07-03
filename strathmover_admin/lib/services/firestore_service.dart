import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_admin_dashboard_template/models/route_model.dart';
import 'package:flutter_admin_dashboard_template/models/trip_model.dart';
import 'package:flutter_admin_dashboard_template/models/user_model.dart';


class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<UserModel>> getUsers() {
    return _db.collection('users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList());
  }

  Stream<List<TripModel>> getTrips() {
    return _db.collection('trips').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => TripModel.fromSnapshot(doc)).toList());
  }

  Stream<List<RouteModel>> getRoutes() {
    return _db.collection('routes').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => RouteModel.fromSnapshot(doc)).toList());
  }

  Future<void> addUser(UserModel user) {
    return _db.collection('users').add(user.toJson());
  }

  Future<void> updateUser(UserModel user) {
    return _db.collection('users').doc(user.id).update(user.toJson());
  }

  Future<void> deleteUser(String userId) {
    return _db.collection('users').doc(userId).delete();
  }

  Future<void> addTrip(TripModel trip) {
    return _db.collection('trips').add(trip.toJson());
  }

  Future<void> updateTrip(TripModel trip) {
    return _db.collection('trips').doc(trip.id).update(trip.toJson());
  }

  Future<void> deleteTrip(String tripId) {
    return _db.collection('trips').doc(tripId).delete();
  }

  Future<void> addRoute(RouteModel route) {
    return _db.collection('routes').add(route.toJson());
  }

  Future<void> updateRoute(RouteModel route) {
    return _db.collection('routes').doc(route.id).update(route.toJson());
  }

  Future<void> deleteRoute(String routeId) {
    return _db.collection('routes').doc(routeId).delete();
  }
}
