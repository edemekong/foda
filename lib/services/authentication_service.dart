// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenicationService {
  AuthenicationService._();

  static AuthenicationService? _instance;

  static AuthenicationService get instance {
    _instance ??= AuthenicationService._();
    return _instance!;
  }

  final auth = FirebaseAuth.instance;

  bool get isGoogleProvider {
    if (auth.currentUser!.providerData.isNotEmpty) {
      return auth.currentUser?.providerData.first.providerId == "google.com";
    }
    return false;
  }

  Future<bool> isEmailInUse(String email) async {
    if (!email.contains("@") || email.split(".").length < 2) {
      print("Invalid Email");
      return false;
    }

    try {
      List<String> users = await auth.fetchSignInMethodsForEmail(email.trim());
      if (users.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<User?> logIn(String email, String password) async {
    try {
      final UserCredential authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        return authResult.user;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        return authResult.user;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserCredential?> _signInUserWithCredential(GoogleAuthProvider googleAuthProvider) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> googleSignIn() async {
    try {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      final userCredential = await _signInUserWithCredential(authProvider);
      if (userCredential?.user != null) {
        return userCredential?.user;
      }
    } on FirebaseException catch (e) {
      print(e);
    }
    return null;
  }

  Stream<User?> authStates() {
    return auth.authStateChanges();
  }
}
