import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      return await _auth.signInWithCredential(cred);
    } catch (e) {
      log("Something went wrong");
      return null;
    }
  }

  Future<void> saveUserData(User? user) async {
    if (user == null) return;

    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      DocumentReference userDoc = users.doc(user.uid);

      // Check if the user document already exists
      DocumentSnapshot docSnapshot = await userDoc.get();
      if (docSnapshot.exists) {
        // Update only the lastLogin field for returning users
        await userDoc.update({
          'lastLogin': FieldValue.serverTimestamp(),
        });
        log("Updated lastLogin for existing user.");
      } else {
        // Create a new user document
        await userDoc.set({
          'docId': user.uid,
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'photoURL': user.photoURL ?? '',
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
        });

        log("Created new user document.");
      }
    } catch (e) {
      log("Failed to save user data: $e");
    }
  }
}
