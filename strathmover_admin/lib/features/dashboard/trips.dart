import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/models/trip_model.dart';
import 'package:flutter_admin_dashboard_template/router.dart';
import 'package:go_router/go_router.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('trips').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No trips found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final trip = TripModel.fromSnapshot(snapshot.data!.docs[index] as DocumentSnapshot<Map<String, dynamic>>);
                return ListTile(
                  title: Text(trip.route),
                  subtitle: Text('Date: ${trip.date}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      context.push(
                        EditTripRoute(tripId: trip.id!).location,
                        extra: trip,
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
