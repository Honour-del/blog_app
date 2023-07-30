import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  CommentModel({
    this.postId,
    this.comment,
    this.commentCreatedAt,
    required this.commentId,
    this.username,
  });
  late String? postId;
  late String? comment;
  late Timestamp? commentCreatedAt;
  late final String commentId;
  late String? username;

  CommentModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    comment = json['comment'];
    commentCreatedAt = json['comment_created_at'];
    commentId = json['comment_id'];
    username = json['username'];
  }

}
