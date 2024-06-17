const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.addProfilePictureFieldToUsers = functions.https.onRequest(async (req, res) => {
  const usersRef = admin.firestore().collection('Users');
  const snapshot = await usersRef.get();
  const batch = admin.firestore().batch();

  snapshot.forEach(doc => {
    if (!doc.data().hasOwnProperty('ProfilePicture')) {
      batch.update(doc.ref, { ProfilePicture: '' });
    }
  });

  await batch.commit();
  res.send('Profile picture field added to all users');
});
