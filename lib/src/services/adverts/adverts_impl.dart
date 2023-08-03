import 'dart:io';
import 'dart:typed_data';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/models/advert.dart';
import 'package:explore_flutter_with_dart_3/src/services/adverts/interface.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class CreateAdvertImpl implements CreateAdvert{

  /* Can upload both images and videos */
  @override
  Future<String> uploadImage({required file, //String? postId,
    directoryName, uid, fileName
  }) async{
    try{
      // convert uint*
      html.Blob imageBlob = html.Blob([file]);


      final String imageFileName = '$directoryName/$uid/${DateTime.now().microsecondsSinceEpoch}_$fileName';
      // final uint = await convertUint8List(file, imageFileName);
      // final file0 = await compressImage(uint);
      debugPrint(r'$file is successfully compressed');
      html.File imageFile = html.File([imageBlob], '$imageFileName.png',
      {'type': 'image/png'});
      // final String imageFileName = '$directoryName/$uid/${DateTime.now().microsecondsSinceEpoch}_$fileName';
      final storage = storageRef.child(imageFileName);

      UploadTask uploadTask = storage.putBlob(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      String download = await taskSnapshot.ref.getDownloadURL();

      return download;
    } catch (e){
      throw e;
    }
  }


  @override
  Future<void> uploadAdvert({
  required String uid,
  required String caption,
  required Uint8List url,
    required String category,
    // List<CommentModel>? comments
}) async{
    // TODO: implement uploadPost
    try{
      var advertId = uuid.v1();
      String download = await uploadImage(file: url, uid: uid, directoryName: 'adverts',);
      Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['advertId'] = advertId;
        data['advertImageUrl'] = download;
        data['caption'] = caption;
        data['posted_at'] = dateTime;
        data['category'] = category;
        return data;
      }
      await advertsRef.doc(advertId).set(toJson());
    } on FirebaseException catch (e){
      throw e;
    }
  }




  /* delete a specific post */
  @override
  Future<bool> deleteAdvert({required String advertId}) async{
    // TODO: implement deletePost
    try{
      await advertsRef.doc(advertId).delete();
      return true;
    } catch (e){
      throw e;
    }
  }

  @override
  Stream<List<AdvertModel>> fetchAdverts(){
    return advertsRef.orderBy('posted_at', descending: true).snapshots()
        .map((event) => event.docs.map((e) => AdvertModel.fromJson(e.data())
    ).toList());
  }
}