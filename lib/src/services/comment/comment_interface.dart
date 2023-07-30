


// import 'package:dio/dio.dart';
import 'package:explore_flutter_with_dart_3/src/models/comment.dart';
import 'package:explore_flutter_with_dart_3/src/services/comment/comment_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final commentServiceProvider = Provider<CommentsRepo>((ref) {
  return CommentsRepo();
});


/// [Comment type]

abstract class CommentsRepo {
factory CommentsRepo () => CommentsRepoImpl();

  /*
  All these class id's are commented out because
  the decision is to be made  by backend engineer if
  each class id's are to be generated on the backend
  or from the frontend!!!!!.

  Because if the id's are randomly generated from the backend
  i wont need to post id toJson it will/can only be returned fromJson
  */

  Future<void> addComment({
    required String postId,
    required String comment,
    required String userName,
  });

  Stream<List<CommentModel>> getComments({postId});

  Future<bool> deleteComments({required String userId, required String commentId});
}

