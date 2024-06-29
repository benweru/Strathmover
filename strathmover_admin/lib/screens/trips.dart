import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strathmover_admin/services/firestore_service.dart';

class TripsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Trips'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('trips').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No trips found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final trip = snapshot.data!.docs[index];
                return ListTile(
                  title: Text(trip['destination']),
                  subtitle: Text('Date: ${trip['date']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Add functionality to edit trip details
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
