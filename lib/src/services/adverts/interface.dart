import 'dart:typed_data';
import 'package:explore_flutter_with_dart_3/src/models/advert.dart';
import 'package:explore_flutter_with_dart_3/src/services/adverts/adverts_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createAdvertServiceProvider = Provider((ref) {
  return CreateAdvert();
});

abstract class CreateAdvert {

  factory CreateAdvert()=> CreateAdvertImpl();

  Future<void> uploadAdvert({
    required String uid,
    required String caption,
    required Uint8List url,
    required String category,
  });

  Future<dynamic> uploadImage({required Uint8List file, directoryName, uid, fileName});

  Future<bool> deleteAdvert({
    required String advertId});

  Stream<List<AdvertModel>> fetchAdverts();
}