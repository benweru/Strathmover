import 'package:bus_app/src/features/authentication/models/route_model.dart';
import 'package:bus_app/src/features/core/screens/routes/routes_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('routes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final routes = snapshot.data!.docs
              .map((doc) => RouteModel.fromSnapshot(doc))
              .toList();
          return ListView.builder(
            itemCount: routes.length,
            itemBuilder: (context, index) {
              final route = routes[index];
              return ListTile(
                title: Text(route.name),
                subtitle: Text('${route.points.length} points'),
                onTap: () => Get.to(() => RouteDetailScreen(route: route)),
              );
            },
          );
        },
      ),
    );
  }
}
