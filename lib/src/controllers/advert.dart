import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/models/advert.dart';
import 'package:explore_flutter_with_dart_3/src/services/adverts/interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




final fetchAdvertController = StreamProvider<List<AdvertModel>>((ref) {
  _listenToFeeds();
  ref.onDispose(_cancelFeedSubscription);
  return getAdvertsK();
});

final StreamController<List<AdvertModel>> _advertsController = StreamController<List<AdvertModel>>.broadcast();
Stream<List<AdvertModel>> getAdvertsK (){
  return _advertsController.stream;
}
// TODO
void _listenToFeeds(){
  advertsRef.snapshots().listen((querySnapshot) {
    final adverts = querySnapshot.docs.map((e) => AdvertModel.fromJson(e.data())).toList();
    _advertsController.add(adverts);
  });
}

void _cancelFeedSubscription(){
  _advertsController.close();
}





final createAdvertControllerProvider =
StateNotifierProvider<CreateAdvertController, AsyncValue<List<AdvertModel>>>(
        (ref) => CreateAdvertController(ref: ref));


class CreateAdvertController extends StateNotifier<AsyncValue<List<AdvertModel>>>{
  final Ref? ref;
  CreateAdvertController({
    required this.ref
  }) : super(const AsyncValue.data([]));
  // {
  //  fetchAdverts();
  // }

  Future<void> uploadAdvert({
    required String uid,
    required String caption,
    required Uint8List url,
    required String category,
  }) async {
    try {
      await ref?.read(createAdvertServiceProvider).uploadAdvert(uid: uid, caption: caption, url: url, category: category,);
    } on FirebaseException catch (e, _) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<void> uploadImage({
    required Uint8List file
  }) async {
    try {
      await ref?.read(createAdvertServiceProvider).uploadImage(file: file);
    } on FirebaseException catch (e, _) {
      rethrow;
    }
  }


  Stream<List<AdvertModel>> fetchAdverts(){
    try{
      final categories = ref?.read(createAdvertServiceProvider).fetchAdverts();
      // state = AsyncValue.data(categories!);
      return categories!;
    } on FirebaseException catch (e, _) {
      debugPrint(e.message);
      state = AsyncValue.error([e], _);
      rethrow;
    }
  }
}