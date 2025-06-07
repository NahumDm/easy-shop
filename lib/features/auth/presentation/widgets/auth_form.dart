// Reusable authentication form widget
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      debugPrint('Attempting to sign in user with email: $email');
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('User signed in successfully');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'Firebase Auth Exception during sign in: ${e.code} - ${e.message}',
      );
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error during sign in: $e');
      debugPrint('Stack trace:');
      debugPrintStack();
      rethrow;
    }
  }

  // Register with email and password
  Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      debugPrint('Attempting to register user with email: $email');
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('User registered successfully, updating display name');
      // Update user profile with full name
      await userCredential.user?.updateDisplayName(fullName);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'Firebase Auth Exception during registration: ${e.code} - ${e.message}',
      );
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error during registration: $e');
      debugPrint('Stack trace:');
      debugPrintStack();
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      debugPrint('Attempting to sign out user');
      await _auth.signOut();
      debugPrint('User signed out successfully');
    } catch (e) {
      debugPrint('Error during sign out: $e');
      debugPrint('Stack trace:');
      debugPrintStack();
      rethrow;
    }
  }
}
