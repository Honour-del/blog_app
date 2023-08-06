import 'package:explore_flutter_with_dart_3/src/controllers/search.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/helper/responsive.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/post_details_screen/post_view.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:timeago/timeago.dart' as timeago;

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key,
    this.search,
  }) : super(key: key);
  final String? search;
  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  //bool isShowResults = false;
  // String _search = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          toolbarHeight: 70,////80
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                // top: 30,
                  left: 0,
                  right: 12
              ),
              child: Text(
                'Post Lists',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor
                ),
              ),
            ),
          ),
        ),
        body:  Padding(
          padding: padding.padding,
          child: ref.watch(searchProvider2(widget.search!)).when(data: (data){
            if(data.isEmpty) {
              Center(child: Text('${widget.search} does not exist',
                style: Theme.of(context).textTheme.displayMedium,
              ),);
            }
            if(Responsive.isMobile(context)){
              return ListView.builder(
                  itemCount: data.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                    final post = data[index];
                    return GestureDetector(
                      onTap: (){
                        push(context, PostView(post: post));
                      },
                      child: PostCard(
                        title: post.title,
                        authorName: post.authorName,
                        dateTime: timeago.format(post.createdAt.toDate()),
                        postImageUrl: post.postImageUrl,
                      ),
                    );
                  }
              );
            }
            return GridView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                ),
                itemBuilder: (context, index){
                  final post = data[index];
                  return GestureDetector(
                    onTap: (){
                      push(context, PostView(post: post));
                    },
                    child: PostCard(
                      title: post.title,
                      authorName: post.authorName,
                      dateTime: timeago.format(post.createdAt.toDate()),
                      postImageUrl: post.postImageUrl,
                    ),
                  );
                }
            );
          },error: (error,_) => throw error, loading: ()=> kProgressIndicator,),
        ),
      ),
    );
  }
}




/*
Padding(
                    padding: EdgeInsets.only(left: getProportionateScreenWidth(20), right: getProportionateScreenWidth(20), top: 28),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(12, 13, 12, 11),
                      margin:
                      EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.15),
                              blurRadius: 5,
                            ),
                          ]),
                      child: Row(
                        children: [
                          CircleAvatar(backgroundImage: NetworkImage(users[index].avatarUrl),),
                          SizedBox(width: 2,),
                          Column(
                            children: [
                              Text(
                                users[index].name,
                                style: TextStyle( // Theme.of(context).textTheme.labelMedium
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[900],
                                ),
                              ),
                              SizedBox(height: 2.5,),
                              Text(
                                users[index].username,
                                style: TextStyle(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  )
* */