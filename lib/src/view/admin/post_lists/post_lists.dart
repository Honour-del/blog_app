import 'package:explore_flutter_with_dart_3/src/controllers/feeds.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/helper/responsive.dart';
import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:explore_flutter_with_dart_3/src/services/post/interface.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/add_post/add_post.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/cards.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;



class PostList extends ConsumerStatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  ConsumerState<PostList> createState() => _PostListState();
}

class _PostListState extends ConsumerState<PostList> {
  @override
  Widget build(BuildContext context) {
    final fullList = ref.watch(newFeedProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 50,
              bottom: 40
          ),
          child: Column(
            children: [
              Text(
                'Post\'s List',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: Responsive.isMobile(context) ? getFontSize(20) : getFontSize(13),
                ),
              ),

              const SizedBox(height: 30,),
              fullList.when(
                  data: (posts){
                    if(Responsive.isMobile(context)) {
                      return ListView.builder(
                        itemCount: posts.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return GestureDetector(
                            onLongPress: (){
                              showDialog<void>(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertBox(
                                      del: (){
                                        // Todo
                                        final del = ref.read(createpostServiceProvider);
                                        del.deletePost(postId: post.postId);
                                        pop(context);
                                      },
                                      edit: (){
                                        push(context, AddPost(initialPostId: post.postId,));
                                      },
                                    );
                                  });
                            },
                            child: PostCard(
                              title: post.title,
                              authorName: post.authorName,
                              dateTime: timeago.format(post.createdAt.toDate()),
                              post_image_url: post.postImageUrl,
                            ),
                          );
                        }
                      );
                    }
                    // if(Responsive.isTablet(context) || Responsive.isDesktop(context))
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: posts.length,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 2,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 25,
                        ),
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return GestureDetector(
                            onLongPress: (){
                              showDialog<void>(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertBox(
                                      del: (){
                                        // Todo
                                        final del = ref.read(createpostServiceProvider);
                                        del.deletePost(postId: post.postId);
                                        pop(context);
                                      },
                                      edit: (){
                                        push(context, AddPost(initialPostId: post.postId,));
                                      },
                                    );
                                  });
                            },
                            child: PostCard(
                              title: post.title,
                              authorName: post.authorName,
                              dateTime: timeago.format(post.createdAt.toDate()),
                              post_image_url: post.postImageUrl,
                            ),
                          );
                        }
                    );
                  },
                  error: (e,_)=> throw e,
                  loading: () => kProgressIndicator,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
