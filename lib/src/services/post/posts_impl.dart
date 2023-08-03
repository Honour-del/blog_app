import 'dart:typed_data';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/models/post.dart';
import 'package:explore_flutter_with_dart_3/src/services/post/interface.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class CreatePostImpl implements CreatePost{

  /* Can upload both images and videos */
  @override
  Future<String> uploadImage({required file, //String? postId,
    directoryName, uid, fileName
  }) async{
    try{
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
  Future<void> uploadPost({
  required String uid,
  required String caption,
  required Uint8List url,
  required String username,
  required String avatarUrl,
    required String title, required String category,
    // List<CommentModel>? comments
}) async{
    // TODO: implement uploadPost
    try{
      var postId = uuid.v1();
      String download = await uploadImage(file: url, uid: uid, directoryName: 'posts',);
      Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['post_id'] = postId;
        data['post_image_url'] = download;
        data['caption'] = caption;
        data['user_id'] = uid;
        data['posted_at'] = dateTime;
        data['comments'] = [];
        data['likes'] = [];
        data['authorName'] = username;
        data['title'] = title;
        data['category'] = category;
        data['avatar_url'] = avatarUrl;
        return data;
      }
      await postsRef.doc(postId).set(toJson());
    } on FirebaseException catch (e){
      throw e;
    }
  }



  @override
  Future<void> updatePost({
    required String uid,
    required String caption,
    required Uint8List url,
    required String username,
    required String avatarUrl,
    required String title,
    required String category,
  }) async{
    // TODO: implement uploadPost
    try{
      var postId = uuid.v1();
      String download = await uploadImage(file: url, uid: uid, directoryName: 'posts',);
      Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['post_id'] = postId;
        data['post_image_url'] = download;
        data['body'] = caption;
        data['user_id'] = uid;
        data['posted_at'] = dateTime;
        data['comments'] = [];
        data['likes'] = [];
        data['authorName'] = username;
        data['title'] = title;
        data['category'] = category;
        data['avatar_url'] = avatarUrl;
        return data;
      }
      await postsRef.doc(postId).update(toJson());
    } on FirebaseException catch (e){
      throw e;
    }
  }


  /* delete a specific post */
  @override
  Future<bool> deletePost({required String postId}) async{
    // TODO: implement deletePost
    try{
      await postsRef.doc(postId).delete();
      return true;
    } catch (e){
      throw e;
    }
  }

  @override
  Future<void> uploadTextPost({required String uid, required String caption,
    required String title, required String category, required String username,
     required String avatarUrl}) async{
    // TODO: implement uploadTextPost
    var postId = uuid.v1();
    Map<String, dynamic> toJson() {
      final data = <String, dynamic>{};
      data['post_id'] = postId;
      data['caption'] = caption;
      data['user_id'] = uid;
      data['posted_at'] = dateTime;
      data['comments'] = [];
      data['likes'] = [];
      data['username'] = username;
      data['title'] = title;
      data['category'] = category;
      data['avatar_url'] = avatarUrl;
      return data;
    }
    await postsRef.doc(postId).set(toJson());
  }

  @override
  Future<List<PostModel>> fetchPostByCategory({String? category}) async{
    final querySnap = await postsRef.where('category', isEqualTo: category)
        .get();

    final posts = querySnap.docs.map((e) => PostModel.fromJson(e.data())).toList();
    return posts;
  }

  @override
  Future<List<PostModel>> fetchPosts() async{
    final fetchSnaps = await postsRef.get();
    final snaps = fetchSnaps.docs.map((e) => PostModel.fromJson(e.data())).toList();
    return snaps;
  }
}