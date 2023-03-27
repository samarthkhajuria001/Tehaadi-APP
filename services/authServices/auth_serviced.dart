import 'package:tehaadi/services/authServices/auth_provider.dart';
import 'package:tehaadi/services/authServices/auth_user.dart';
import 'package:tehaadi/services/authServices/firebaseAuth_provider.dart';

class AuthServices extends AuthProvider {
  final AuthProvider provider;

  const AuthServices(this.provider);
  factory AuthServices.firebase() => AuthServices(FirebaseProvider());

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<String> logoutUser() async {
    String res = await provider.logoutUser();
    return res;
  }

  @override
  Future<String> sendEmailVerification() {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }

  @override
  Future<String> signInWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signInwithGoogle() async {
    String res = await provider.signInwithGoogle();
    return res;
  }

  @override
  Future<String> signUpUser() {
    // TODO: implement signUpUser
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  // TODO: implement userChanges
  Stream get userChanges {
    return provider.userChanges;
  }
}
