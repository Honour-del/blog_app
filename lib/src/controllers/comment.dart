import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_with_dart_3/src/models/comment.dart';
import 'package:explore_flutter_with_dart_3/src/services/comment/comment_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentProvider =
StateNotifierProvider<CommentController, AsyncValue<List<CommentModel>>>(
        (ref) => CommentController(ref));


final getCommentProvider =
StreamProvider.family(
        (ref, String id) {
      return ref.watch(commentProvider.notifier).getComments(id);
    });

class CommentController extends StateNotifier<AsyncValue<List<CommentModel>>>{
  final Ref? _ref;
  // final String? postId;
  CommentController([this._ref]) : super(const AsyncValue.data([]));

  Future<void> addComment({
    // required String userId,
    required String postId,
    required String comment,
    required String userName,
  }) async {
    try {
      // final notified = await _ref!.read(notificationServiceProviderK);
      // UserModel? owner = await _ref!.watch(getProfile(postOwner)).value;
      // UserModel? commenter = await _ref!.watch(getProfile(commenterUserId)).value;
      final comments = await _ref!.read(commentServiceProvider).addComment(
        postId: postId,
          comment: comment,
          userName: userName,);
      debugPrint('About to send notification');
      /* Sending 'fcm' notification with the receiver token so that the notification will be received authorized user only */
      return comments;
    } on FirebaseException catch (e, _) {
      state = AsyncValue.error([e], _);
    }
  }


  Stream<List<CommentModel>> getComments(postId)  {
    try {
      final comments =
      _ref?.read(commentServiceProvider).getComments(postId: postId);
      return comments!;
    } on FirebaseException catch (e, _) {
      throw e.message!;
    }
  }

  Future<void> deleteComments({
    required String userId,
    required String commentId,
  }) async {
    try {
      await _ref?.read(commentServiceProvider).deleteComments(userId: userId, commentId: commentId);
    } on FirebaseException catch (e, _) {
      rethrow;
    }
  }
}
