import 'package:flutter/foundation.dart';

class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// register exceptions

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class GoogleSignInException implements Exception {}

// generic exception

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
