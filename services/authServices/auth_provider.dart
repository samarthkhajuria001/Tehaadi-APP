import 'package:tehaadi/services/authServices/auth_user.dart';

abstract class AuthProvider {
  const AuthProvider();
  AuthUser? get currentUser;
  Future<String> signInwithGoogle();
  Future<void> initialize();
  Future<String> logoutUser();
  Future<String> signUpUser();
  Future<String> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<String> signUpWithEmailAndPassword(
      {required String email, required String password});
  Future<String> sendEmailVerification();
  Stream get userChanges;
}
