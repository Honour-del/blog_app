

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/models/post.dart';
import 'package:explore_flutter_with_dart_3/src/services/post/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



// final userDetailProvider = FutureProvider<PostModel?>((ref) async{
//   String? uid = ref.watch(authProviderK).value?.uid;
//   // final uid = FirebaseAuth.instance.currentUser?.uid;
//   // this was returning type 'Null'  is not subtype of Map<String, dynamic>
//   final data = await usersRef.doc(uid!).get();
//   // if(data.exists)
//   print('getting user details from the backend');
//   // data.data();
//   print('User details is parsed into json');
//   UserModel userData = UserModel.fromJson(data.data()!);
//   print('____${userData.username}____');
//   return userData;
// });



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

final fetchByIdProviderController = FutureProvider.family<PostModel, String>(
        (ref, text) {
      return ref.read(fetchByIdProvider(text).notifier).fetchPostById();
    });
// final fetchProviderController = FutureProvider.family((ref, String category) {
//   return ref.read(fetchProvider(category).notifier).fetchPostByCategory();
// });

final fetchByIdProvider = StateNotifierProvider.family<FetchPostById, AsyncValue<PostModel>, String>((ref, id) {
  return FetchPostById(ref: ref, id: id);
});

final fetchProvider = StateNotifierProvider.family<FetchPostController, AsyncValue<List<PostModel>>, String>((ref, category) {
  return FetchPostController(ref: ref, category: category);
});

final justFetchProviderController = StateNotifierProvider<FetchPostController, AsyncValue<List<PostModel>>>((ref) {
  return FetchPostController(ref: ref);
});





class FetchPostById extends StateNotifier<AsyncValue<PostModel>>{
  final Ref? ref;
  final String? id;
  FetchPostById({this.ref, this.id,}) : super(const AsyncLoading());

  Future<PostModel> fetchPostById() async{
    try{
      final ids = await ref?.read(createpostServiceProvider).fetchPostById(id: id);
      state = AsyncValue.data(ids!);
      return ids;
    } on FirebaseException catch (e, _) {
      debugPrint(e.message);
      state = AsyncValue.error([e], _);
      rethrow;
    }
  }

}


class FetchPostController extends StateNotifier<AsyncValue<List<PostModel>>>{
  final Ref? ref;
  final String? category;
  // final String? id;
  FetchPostController({this.ref, this.category,}) : super(const AsyncData([]));

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