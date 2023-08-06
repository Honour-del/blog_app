import 'package:explore_flutter_with_dart_3/src/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/search/interface.dart';


final searchProvider2 = StreamProvider.family<List<PostModel>, String>(
        (ref, text) {
      return ref.read(searchProvider.notifier).searchUsers(text);
    });
final searchProvider = StateNotifierProvider<SearchController, AsyncValue<List<PostModel>>>(
        (ref) => SearchController(ref));

/////changes needs to be made to filter the categories accordingly

class SearchController extends StateNotifier<AsyncValue<List<PostModel>>>{
  final Ref? _ref;
  SearchController([this._ref,]) : super(const AsyncValue.data([]));


  Stream<List<PostModel>> searchUsers(String query){
    return _ref!.read(searchServiceProvider).searchPosts(query);
  }


  // Future<void> getAllUsersList(searchedText) async {
  //   try {
  //     final trending = await _ref?.read(searchServiceProvider).getAllUsers(searchedText!);
  //     state = AsyncValue.data(trending!);
  //   } on FirebaseException catch (e, _) {
  //     state = AsyncValue.error([e], _);
  //   }
  // }
}
