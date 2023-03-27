import 'package:tehaadi/models/task.dart';

class User {
  final String username;
  final String profileUrl;
  final List connections;
  final String uid;
  final String email;

  User({
    required this.username,
    required this.profileUrl,
    required this.connections,
    required this.uid,
    required this.email,
  });

  factory User.fromFirebase(Map<String, dynamic> user) {
    return User(
      username: user['username'],
      profileUrl: user['profileUrl'],
      connections: user['connections'],
      uid: user['uid'],
      email: user['email'],
    );
  }

  Map<String, dynamic> get toJson {
    return {
      'username': username,
      'profileUrl': profileUrl,
      'connections': connections,
      'uid': uid,
      'email': email,
    };
  }
}
