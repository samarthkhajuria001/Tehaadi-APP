import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tehaadi/models/user.dart';
import 'package:tehaadi/models/task.dart';
import 'package:tehaadi/services/CRUDServices/cloud_services_provider.dart';
import 'package:tehaadi/services/CRUDServices/crud_exceptions.dart';
import 'package:tehaadi/services/authServices/auth_exceptions.dart';
import 'package:tehaadi/services/authServices/auth_serviced.dart';
import 'package:tehaadi/services/authServices/auth_user.dart';
import 'package:tehaadi/models/task.dart' as modelsTask;
import 'package:tehaadi/models/user.dart' as modelsUser;
import 'package:uuid/uuid.dart';

import '../../constants/constats.dart';

class CloudFirestoreServices extends CloudServicesProvider {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final AuthServices _authServices = AuthServices.firebase();

  @override
  Future<void> addNewOrEditTask(
      {required Task task, required String userId}) async {
    try {
      //  DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _firebaseFirestore.collection('users').doc(userId).collection('tasks').doc(task.taskId).get();
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(task.taskId)
          .set(task.toJson);
    } catch (err) {
      print(err.toString());
      throw UnableToCreateTaskException();
    }
  }

  @override
  Future<modelsUser.User?> createUserDB() async {
    AuthUser? currentUser = _authServices.currentUser;
    modelsUser.User? newDbUser;
    try {
      if (currentUser != null) {
        modelsUser.User dbUser = User(
          username: currentUser.email,
          profileUrl: defualtImageUrl,
          connections: [],
          uid: currentUser.uid,
          email: currentUser.email,
        );

        await _firebaseFirestore
            .collection('users')
            .doc(currentUser.uid)
            .set(dbUser.toJson);
      }
    } catch (err) {
      throw UnableToCreateUserInDBException();
    }
    final dataSnapshot = await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    final snapData = dataSnapshot.data();
    if (snapData != null) {
      newDbUser = modelsUser.User.fromFirebase(snapData);
    }

    return newDbUser;
  }

  @override
  Future<void> deleteTask(
      {required String taskId, required String userId}) async {
    try {
      if (userId != _authServices.currentUser!.uid) {
        throw UserDidNotMatchException();
      }
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .delete();
    } catch (err) {
      throw UnableToDeleteTaskException();
    }
  }

  @override
  Future<void> doneToggle(
      {required String taskId,
      required String userId,
      required bool value}) async {
    try {
      if (userId != _authServices.currentUser!.uid) {
        throw UserDidNotMatchException();
      }
      final taskSnapshot = await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .update({'isDone': value});
    } catch (err) {
      throw UnableToUpdateTaskException();
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> get allTasksStream {
    if (_authServices.currentUser == null) {
      throw UserNotLoggedInAuthException();
    }

    return _firebaseFirestore
        .collection('users')
        .doc(_authServices.currentUser!.uid)
        .collection('tasks')
        .snapshots();
  }
}
