

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/models/post.dart';
import 'package:explore_flutter_with_dart_3/src/services/post/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';





final newFeedProvider = StreamProvider<List<PostModel>>((ref) {
  _listenToFeeds();
  ref.onDispose(_cancelFeedSubscription);
  return getFeedsK();
});

final StreamController<List<PostModel>> _feedsController = StreamController<List<PostModel>>.broadcast();
Stream<List<PostModel>> getFeedsK (){
  return _feedsController.stream;
}
// TODO
void _listenToFeeds(){
  postsRef.snapshots().listen((querySnapshot) {
    final feeds = querySnapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
    _feedsController.add(feeds);
  });
}

void _cancelFeedSubscription(){
  _feedsController.close();
}

final fetchProviderController = FutureProvider.family<List<PostModel>, String>(
        (ref, text) {
      return ref.read(fetchProvider(text).notifier).fetchPostByCategory();
    });
// final fetchProviderController = FutureProvider.family((ref, String category) {
//   return ref.read(fetchProvider(category).notifier).fetchPostByCategory();
// });

final fetchProvider = StateNotifierProvider.family<FetchPostController, AsyncValue<List<PostModel>>, String>((ref, category) {
  return FetchPostController(ref: ref, category: category);
});

final justFetchProviderController = StateNotifierProvider((ref) {
  return FetchPostController(ref: ref);
});


class FetchPostController extends StateNotifier<AsyncValue<List<PostModel>>>{
  final Ref? ref;
  final String? category;
  FetchPostController({this.ref, this.category}) : super(const AsyncData([]));

  Future<List<PostModel>> fetchPostByCategory() async{
    try{
      final categories = await ref?.read(createpostServiceProvider).fetchPostByCategory(category: category);
      state = AsyncValue.data(categories!);
      return categories;
    } on FirebaseException catch (e, _) {
      debugPrint(e.message);
      state = AsyncValue.error([e], _);
      rethrow;
    }
  }

  Future<List<PostModel>> fetchPosts() async{
    try{
      final categories = await ref?.read(createpostServiceProvider).fetchPosts();
      state = AsyncValue.data(categories!);
      return categories;
    } on FirebaseException catch (e, _) {
      debugPrint(e.message);
      state = AsyncValue.error([e], _);
      rethrow;
    }
  }
}