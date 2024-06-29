import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strathmover_admin/services/firestore_service.dart';

class RoutesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Routes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('routes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No routes found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final route = snapshot.data!.docs[index];
                return ListTile(
                  title: Text(route['routeName']),
                  subtitle: Text('Stops: ${route['stops']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Add functionality to edit route details
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
