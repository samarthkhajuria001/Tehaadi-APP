import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tehaadi/models/task.dart' as TaskModel;
import 'package:tehaadi/models/user.dart' as UserModel;

abstract class CloudServicesProvider {
  Future<UserModel.User?> createUserDB();

  Future<void> addNewOrEditTask(
      {required TaskModel.Task task, required String userId});
  Future<void> deleteTask({required String taskId, required String userId});
  Future<void> doneToggle(
      {required String taskId, required String userId, required bool value});
  Stream<QuerySnapshot<Map<String, dynamic>>> get allTasksStream;
}
