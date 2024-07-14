import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/features/crud/edit_user_dialog.dart';
import 'package:flutter_admin_dashboard_template/models/user_model.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final user = UserModel.fromSnapshot(
                  snapshot.data!.docs[index] as DocumentSnapshot<Map<String, dynamic>>,
                );
                return ListTile(
                  title: Text(user.fullName),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => EditUserDialog(user: user),
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
