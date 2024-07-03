import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/models/route_model.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RoutesPage extends StatelessWidget {
  const RoutesPage({Key? key}) : super(key: key);

  Future<List<RouteModel>> fetchRoutes() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('routes').get();
    final routes = snapshot.docs.map((doc) => RouteModel.fromSnapshot(doc)).toList();
    print("Fetched ${routes.length} routes");
    return routes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Routes')),
      body: FutureBuilder<List<RouteModel>>(
        future: fetchRoutes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No routes available'));
          }

          final routes = snapshot.data!;
          return ListView.builder(
            itemCount: routes.length,
            itemBuilder: (context, index) {
              final route = routes[index];
              return ListTile(
                title: Text(route.name),
                onTap: () {
                  context.go('/routes/${route.id}/edit', extra: route);
                },
              );
            },
          );
        },
      ),
    );
  }
}
