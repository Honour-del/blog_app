import 'dart:io';
import 'dart:typed_data';
import 'package:explore_flutter_with_dart_3/src/models/post.dart';
import 'package:explore_flutter_with_dart_3/src/services/post/posts_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createpostServiceProvider = Provider((ref) {
  return CreatePost();
});

abstract class CreatePost {

  factory CreatePost()=> CreatePostImpl();

  // var uuid = const Uuid();
  /*
  All these class id's are commented out because
  the decision is to be made  by backend engineer if
  each class id's are to be generated on the backend
  or from the frontend!!!!!.

  Because if the id's are randomly generated from the backend
  i wont need to post id toJson it will/can only be returned fromJson
  */

  Future<void> uploadTextPost({
    required String uid,
    required String caption,
    required String username,
    required String avatarUrl,
    required String title,
    required String category,
});

  Future<void> uploadPost({
    required String uid,
    required String caption,
    required Uint8List url,
    required String username,
    required String avatarUrl,
    required String title,
    required String category,
    // required int width,
    // required int height,
  });


  Future<void> updatePost({
    required String uid,
    required String caption,
    required Uint8List url,
    required String username,
    required String avatarUrl,
    required String title,
    required String category,
    // required int width,
    // required int height,
  });


  Future<dynamic> uploadImage({required Uint8List file, directoryName, uid, fileName});

  Future<bool> deletePost({
    required String postId});

  Future<List<PostModel>> fetchPostByCategory({String? category});
  Future<PostModel> fetchPostById({String? id});

  Future<List<PostModel>> fetchPosts();
}