import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_with_dart_3/src/models/comment.dart';

class AdvertModel {
  AdvertModel({
    required this.advertId,
    required this.caption,
    required this.advertImageUrl,
    required this.createdAt,
    this.category,
  });

  late final String advertId;
  late final String advertImageUrl;
  late final String caption;
  late final Timestamp createdAt;
  late String? category;

  /* The initial error was because of 'late' initializer error  */
  AdvertModel.fromJson(json) {
    advertId = json['advertId'] ?? '';
    advertImageUrl = json['advertImageUrl'] ?? '';
    caption = json['caption'] ?? '';
    createdAt = json['posted_at'] ?? Timestamp.now();
    category = json['category'] ?? '';
  }
}