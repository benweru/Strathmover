import 'package:cloud_firestore/cloud_firestore.dart';

void updateExistingUsers() async {
  final firestore = FirebaseFirestore.instance;
  final usersCollection = firestore.collection('users');
  final usersSnapshot = await usersCollection.get();

  for (var userDoc in usersSnapshot.docs) {
    final userData = userDoc.data();
    if (!userData.containsKey('ProfilePicture')) {
      await usersCollection.doc(userDoc.id).update({
        'ProfilePicture': '',
      });
    }
  }
}
