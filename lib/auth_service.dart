import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    try{
      await _auth.signOut();
    }
    catch(e){
      log("Something went wrong");
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try{
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final cred = GoogleAuthProvider.credential(idToken: googleAuth?.idToken,accessToken: googleAuth?.accessToken);

      return await _auth.signInWithCredential(cred);
    }
    catch(e){
      log("Something went wrong");
      return null;
    }
  }

}