import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_with_dart_3/src/services/post/interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createPostProvider =
StateNotifierProvider<CreatePostController, dynamic>(
        (ref) => CreatePostController(ref: ref));


class CreatePostController extends StateNotifier{
  final Ref? ref;
  CreatePostController({
      required this.ref
  }) : super(null);

  // Posts without image
  Future<void> uploadTextPost({
    required String uid,
    required String caption,
    required String username,
    required String avatarUrl,
    required String title,
    required String category,
}) async{
    try {
      await ref?.read(createpostServiceProvider).uploadTextPost(uid: uid, caption: caption, username: username, avatarUrl: avatarUrl, title: title, category: category);
    } on FirebaseException catch (e, _) {
      print(e.message);
      throw e;
    }
  }


  Future<void> uploadPost({
    required String uid,
    required String caption,
    required String username,
    required Uint8List url,
    required String avatarUrl,
    required String title,
    required String category,
}) async {
    try {
      await ref?.read(createpostServiceProvider).uploadPost(uid: uid, caption: caption, url: url, username: username, avatarUrl: avatarUrl, title: title, category: category,);
    } on FirebaseException catch (e, _) {
      print(e.message);
      rethrow;
    }
  }

  Future<void> uploadImage({
    required Uint8List file
  }) async {
    try {
      await ref?.read(createpostServiceProvider).uploadImage(file: file);
    } on FirebaseException catch (e, _) {
      rethrow;
    }
  }
}
