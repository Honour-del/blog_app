import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/models/admin.dart';
import 'package:explore_flutter_with_dart_3/src/services/auth/interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final authProviderK = StreamProvider<User?>((ref) {
  final AuthServiceImpl _serviceImpl = AuthServiceImpl();
  return _serviceImpl.authStateChange;
});
// final authProviderK = FutureProvider<User?>((ref) async{
//   return FirebaseAuth.instance.authStateChanges().first;
// });

/* This returns the every details of the user from firebase */
final userDetailProvider = StreamProvider<AdminModel?>((ref) {
  String? uid = ref.watch(authProviderK).value?.uid;
  final data = usersRef.doc(uid!).snapshots().map((event) => AdminModel.fromJson(event.data() as Map<String, dynamic>));
  debugPrint('getting user details from the backend');
  return data;
});



// final userDetailProvider = FutureProvider<AdminModel?>((ref) async{
//   String? uid = ref.watch(authProviderK).value?.uid;
//   final data = await usersRef.doc(uid!).get();
//   debugPrint('getting user details from the backend');
//   debugPrint('User details is parsed into json');
//   AdminModel userData = AdminModel.fromJson(data.data()!);
//   debugPrint('____${userData.username}____');
//   return userData;
// });

class AuthServiceImpl implements AuthService {
   final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId ='';
  String? userId;

  Stream<User?> get authStateChange => _auth.authStateChanges();
  User? currentUser;

  // dynamic my;
  @override
  Future register({required String email, required String password,}) async{
    // TODO: implement register
    try{
       // final creator =
       await _auth.createUserWithEmailAndPassword(email: email, password: password);
       currentUser = _auth.currentUser;
      /* Save user info after a new user is created */
      final data = await _saveUser(currentUser?.uid, email);
      return data;
    } catch (e){
      throw e;
    }
  }


  /* Save user info as soon as they successfully registered */
  Future _saveUser(uid, email) async{
    try{
      if(currentUser == null) return null;
      Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['id'] = currentUser!.uid;
        data['username'] = "Admin";
        data['email'] = email;
        data['bio'] = 'Edit profile to update your bio';
        data['avatar_url'] = avatar;
        data['posts_count'] = [];
        data['created_at'] = dateTime;
        data['fcm_token'] = '';
        return data;
      }
      /* [uid] of the reference is the id of the registered user */
      await usersRef.doc(uid).set(
        toJson()
      );
    } catch (e){
      throw e;
    }
  }


  /* get User data from backend after login */
  @override
  Future getUserInfo(String email) async{
    QuerySnapshot snap = await usersRef.where('email', isEqualTo: email).get();
    return snap;
  }

  @override
  Future attemptLogIn(String email, String password) async{
    // TODO: implement attemptLogIn
    try{
      final logins =  await _auth.signInWithEmailAndPassword(email: email, password: password);
      // currentUser = logins.user;
      return Right(logins);
    }catch (e){
      throw e;
    }
  }


  /* Logout and delete uid/token from local preferences */
  @override
  Future<bool?> logout() async{
    // TODO: implement logout
    await _auth.signOut();
    return true;
  }
}
