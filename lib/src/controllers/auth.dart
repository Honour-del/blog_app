import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth/interface.dart';



final authControllerProvider = StateNotifierProvider<AuthController, dynamic>(
      (ref) => AuthController(read: ref),/////
);

class AuthController extends StateNotifier{
  final Ref read;
  AuthController({
    required this.read
  }) : super(null);

  FutureOr<Either<String, dynamic>> register({
    required String email,
    required String password,
  }) async {
    try {
      dynamic status = await read.read(authServiceProvider).register(
        email: email,
        password: password,
      );
      return Right(status);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }

  }


  Future getUserInfo(String email) async{
    try{
      dynamic status = await read.read(authServiceProvider).getUserInfo(email);
      return Right(status);
    } on FirebaseException catch (e){
      return Left(e.message);
    }
  }


  FutureOr login(
      String email, String password) async {
    try {
      final response = await read.read(authServiceProvider).attemptLogIn(
        email,
        password,
      );
      return response;
    } on FirebaseException catch (e) {
      return Left(e.message);
    }
  }


  Future<bool?> logout() async {
    try {
      final bool? loggedOut = await read.read(authServiceProvider).logout();
      return loggedOut;
    } on FirebaseException {
      return false;
    }
  }
}

final filesProvider =
StateNotifierProvider<Files, List<File?>>((ref) => Files());

class Files extends StateNotifier<List<File?>> {
  Files() : super([]);

  addFile(File? file, int id) {
    if (id == 1) {
      state = [file, ...state].toList();
    } else {
      state = [...state, file].toList();
    }
  }
}
