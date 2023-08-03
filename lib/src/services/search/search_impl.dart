import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/models/post.dart';
import 'package:explore_flutter_with_dart_3/src/services/search/interface.dart';
import 'package:flutter/material.dart';


class SearchImpl implements Search{
  @override

  Stream<List<PostModel>> searchPosts(String query) {
    return postsRef.where('title', isGreaterThanOrEqualTo: query)
    .where('title', isLessThan: '${query}z') // TODO: to filter the users based on 'query'
        .snapshots().map((event) {
      List<PostModel> users = [];
      for(var user in event.docs){
        users.add(PostModel.fromJson(user.data()));
        debugPrint("Does the user exists?: {_user.exists}");
      }
      return users;
    });
  }
}