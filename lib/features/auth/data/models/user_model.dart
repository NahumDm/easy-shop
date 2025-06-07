// User model for Firebase authentication

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  UserModel({this.uid, this.email, this.displayName, this.photoURL});

  factory UserModel.fromFirebaseUser(User? user) {
    if (user == null) return UserModel();
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }
}
