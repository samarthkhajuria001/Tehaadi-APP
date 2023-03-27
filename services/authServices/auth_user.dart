import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final String email;
  final String uid;

  AuthUser({required this.email, required this.uid});

  factory AuthUser.fromFirebase(User user) {
    return AuthUser(email: user.email!, uid: user.uid);
  }
}
