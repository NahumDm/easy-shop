// Reusable authentication form widget
import 'package:easy_shop/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register with email and password
  Future<UserCredential?> registerWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      print('Attempting to register user with email: $email');
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      print('User registered successfully, updating display name');
      // Update user profile with full name
      await userCredential.user?.updateDisplayName(fullName);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(
        'Firebase Auth Exception during registration: ${e.code} - ${e.message}',
      );
      rethrow;
    } catch (e) {
      print('Unexpected error during registration: $e');
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      print('Attempting to sign out user');
      await _auth.signOut();
      print('User signed out successfully');
    } catch (e) {
      print('Error during sign out: $e');
      rethrow;
    }
  }
}
