import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_with_dart_3/src/models/comment.dart';

class PostModel {
  PostModel({
    required this.postId,
    required this.postImageUrl,
    required this.caption,
    // required this.comments,
    this.commentCounts,
    required this.createdAt,
    required this.likesCount,
    this.authorName,
    this.title,
    this.avatarUrl,
    this.userId,
    this.category,
  });
  late final String postId;
  late final String postImageUrl;
  late final String caption;
  late final String? userId;
  late final Timestamp createdAt;
  late final List<dynamic> likesCount; /* Just changed it to lIst dynamic */
  late List<CommentModel>? comments;
  late final dynamic commentCounts;
  late String? authorName;
  late String? title;
  late String? category;
  late String? avatarUrl;



  /* The initial error was because of 'late' initializer error  */
  PostModel.fromJson(json) {
    postId = json['post_id'] ?? '';
    postImageUrl = json['post_image_url'] ?? '';
    caption = json['body'] ?? '';
    userId = json['user_id'] ?? '';
    createdAt = json['posted_at'] ?? Timestamp.now();
    likesCount = json['likes'] ?? [];
    comments =  [];
    commentCounts = json['commentCounts'] ?? [];
    authorName = json['authorName'] ?? '';
    title = json['title'] ?? '';
    category = json['category'] ?? '';
    avatarUrl = json['avatar_url'] ?? '';
  }

}