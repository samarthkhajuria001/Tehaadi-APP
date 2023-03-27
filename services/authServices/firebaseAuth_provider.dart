import 'package:firebase_auth/firebase_auth.dart';
import 'package:tehaadi/services/authServices/auth_exceptions.dart';
import 'package:tehaadi/services/authServices/auth_provider.dart';
import 'package:tehaadi/services/authServices/auth_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../CRUDServices/cloud_firestore.dart';

class FirebaseProvider extends AuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<String> signInwithGoogle() async {
    String res = 'Some error occured';
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (currentUser != null) {
        await CloudFirestoreServices().createUserDB();
        res = 'success';
      }
    } on FirebaseException catch (err) {
      throw GoogleSignInException();
    } catch (err) {
      throw GenericAuthException();
    }
    return res;
  }

  @override
  Future<String> logoutUser() async {
    String res = 'some error occured';
    try {
      await _firebaseAuth.signOut();
      if (currentUser == null) {
        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  @override
  Future<String> signUpUser() {
    // TODO: implement signUpUser
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
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
  Future<String> signUpWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  // TODO: implement userChanges
  Stream get userChanges => _firebaseAuth.userChanges();
}
