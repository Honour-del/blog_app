import 'dart:io';
import 'package:explore_flutter_with_dart_3/src/services/auth/auths_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

abstract class AuthService {

  factory AuthService ()=> AuthServiceImpl();

  Future register(
      {required String email,
        required String password,
      });

  ////to check if the data already exist then login
  Future attemptLogIn(
      String email, String password);

  /// logout and refresh the token
  Future<bool?> logout();

  Future getUserInfo(String email);

}
