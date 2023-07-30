// ignore_for_file: depend_on_referenced_packages

import 'package:explore_flutter_with_dart_3/src/controllers/feeds.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/helper/responsive.dart';
import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:explore_flutter_with_dart_3/src/models/post.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/homepage/component/comment_and_subscribe.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/cards.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/footer.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostView extends ConsumerStatefulWidget {
  const PostView({Key? key,
  this.post,
  }) : super(key: key);

  final PostModel? post;

  @override
  ConsumerState<PostView> createState() => _PostViewState();
}

TextEditingController _comment = TextEditingController();
TextEditingController _name = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _email1 = TextEditingController();

class _PostViewState extends ConsumerState<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Responsive(
          mobile: _mobile(),
          desktop: _desktop(),
        ),
      ),
    );
  }


  //
  Widget _mobile() {
    final category = ref.watch(newFeedProvider).value?.where((element) => element.category == widget.post!.category);
    return Padding(
      padding: padding.padding,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(30),),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Tuition Hike: Naus Threatens Mass Protest',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w800,
                fontSize: getFontSize(15),
              ),
            ),
          ),

          SizedBox(height: getProportionateScreenHeight(15),),

          Row(
          children: socials(context, ref).toList(),
          ),

          SizedBox(height: getProportionateScreenHeight(20),),

          Center(
            child: Text(
              body,
              // textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: getFontSize(15),
              ),
            ),
          ),

          SizedBox(height: getProportionateScreenHeight(35),),

          CommentAndSubscribe(
              i: _comment,
              ii: _name,
              iii: _email,
              iv: _email1,
            postId: widget.post!.postId,
          ),

          SizedBox(height: getProportionateScreenHeight(20),),

          if(category!.isNotEmpty)
            _categoryHeader(title: "More on ${category.first.category.toString()}"),
          ...category.map((e) => GestureDetector(
            onTap: (){
              push(context, const PostView());
            },
            child: PostCard(
              authorName: e.authorName,
              dateTime: timeago.format(e.createdAt.toDate()),
              post_image_url: e.postImageUrl,
            ),
          )),


          SizedBox(height: getProportionateScreenHeight(20),),
          const Footer(),
        ],
      ),
    );
  }


  Widget _categoryHeader({String? title}) => Padding(
    padding: const EdgeInsets.only(
        top: 20,
        bottom: 10
    ),
    child: Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        title ?? 'LATEST NEWS',
        style: TextStyle(
            decoration: TextDecoration.underline,
            color: Theme.of(context).primaryColor,
            fontSize: getFontSize(17),
            fontWeight: FontWeight.w700
        ),
      ),
    ),
  );

  Widget _desktop() {
    final category = ref.watch(newFeedProvider).value?.where((element) => element.category == widget.post!.category);
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
          top: getProportionateScreenHeight(70),
          bottom: getProportionateScreenHeight(60)  //70
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(30),),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Tuition Hike: Naus Threatens Mass Protest',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: getFontSize(15),
                        ),
                      ),
                    ),

                    SizedBox(height: getProportionateScreenHeight(15),),

                    Row(
                      children: socials(context, ref).toList(),
                    ),

                    SizedBox(height: getProportionateScreenHeight(20),),

                    Center(
                      child: Text(
                        body,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: getFontSize(10),
                        ),
                      ),
                    ),

                    // SizedBox(height: getProportionateScreenHeight(35),),


                    SizedBox(height: getProportionateScreenHeight(20),),

                    if(category!.isNotEmpty)
                      _categoryHeader(title: "More on ${category.first.category.toString()}"),
                    ...category.map((e) => Expanded(
                      flex: 3,
                      child: GridView.builder(
                          shrinkWrap: true,
                          // itemCount: data.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2,
                            crossAxisSpacing: 25,
                            mainAxisSpacing: 25,
                          ),
                          itemBuilder: (context, index) {
                            // final post = data[index];
                            return GestureDetector(
                              onTap: (){
                                push(context, PostView(
                                  post: e,
                                ));
                              },
                              child: PostCard(
                                title: e.title,
                                authorName: e.authorName,
                                dateTime: timeago.format(e.createdAt.toDate()),
                                post_image_url: e.postImageUrl,
                              ),
                            );
                          }
                      ),
                    ),),

                    // const Spacer()
                  ],
                ),
              ),

              const SizedBox(width: 20,),

              Expanded(
                child: CommentAndSubscribe(
                    i: _comment,
                    ii: _name,
                    iii: _email,
                    iv: _email1,
                  postId: widget.post!.postId,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24,),
          const Footer()
        ],
      ),
    );
  }
}
