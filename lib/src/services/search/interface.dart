import 'package:explore_flutter_with_dart_3/src/models/post.dart';
import 'package:explore_flutter_with_dart_3/src/services/search/search_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final searchServiceProvider = Provider<Search>((ref) {
  return Search();
});

abstract class Search {
  factory Search() => SearchImpl();

  Stream<List<PostModel>> searchPosts(String query);
}