import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strathmover_admin/models/user_model.dart';
import 'package:strathmover_admin/services/firestore_service.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: firestoreService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user.fullName),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Add functionality to edit user details
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
