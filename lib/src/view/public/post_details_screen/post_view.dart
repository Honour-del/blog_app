// ignore_for_file: depend_on_referenced_packages
import 'package:explore_flutter_with_dart_3/src/controllers/comment.dart';
import 'package:explore_flutter_with_dart_3/src/controllers/feeds.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/helper/responsive.dart';
import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:explore_flutter_with_dart_3/src/models/post.dart';
import 'package:explore_flutter_with_dart_3/src/services/url_launcher/url_controller.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/homepage/component/comment_and_subscribe.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/cards.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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


  Widget _mobile() {
    final category = ref.watch(newFeedProvider).value?.where((element) => element.category == widget.post!.category);
    final comment = ref.watch(fetchCommentController).value?.where((element) => element.postId == widget.post!.postId);
    return Padding(
      padding: padding.padding,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(30),),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.post!.title!,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w800,
                fontSize: getFontSize(19.5),
              ),
            ),
          ),

          SizedBox(height: getProportionateScreenHeight(15),),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: (){
                    // final launcher = ref.read(urlControllerProvider.notifier);
                    String whatsapp = 'https://wa.me/+2349037806442'; //TODO
                    // launcher.launchUrl(whatsapp);
                    launchURL(whatsapp);
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.whatsapp, size: 30,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: (){
                    // final launcher = ref.read(urlControllerProvider.notifier);
                    String facebook = 'https://www.facebook.com/profile.php?.id=100074370350219'; //TODO
                    launchURL(facebook);
                    // launcher.launchUrl(facebook);
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.facebook, size: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: (){
                    // final launcher = ref.read(urlControllerProvider.notifier);
                    String telegram = 'https://instagram.com/campus_latestgister?igshid=YmMyMTA2M2Y='; //TODO
                    launchURL(telegram);
                    // launcher.launchUrl(telegram);
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.instagram, size: 30,
                  ),
                ),
              ),
            ],
          ),
          // Row(
          // children: socials(context, ref).toList(),
          // ),

          SizedBox(height: getProportionateScreenHeight(20),),
          if(widget.post!.postImageUrl.isNotEmpty)
            Image.network(widget.post!.postImageUrl),
          SizedBox(height: getProportionateScreenHeight(20),),
          Center(
            child: Text(
              widget.post!.caption,
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
              push(context, PostView(
                post: e,
              ));
            },
            child: PostCard(
              title: e.title,
              authorName: e.authorName,
              dateTime: timeago.format(e.createdAt.toDate()),
              postImageUrl: e.postImageUrl,
            ),
          )),

          SizedBox(height: getProportionateScreenHeight(20),),
          if(comment!.isNotEmpty)
            _categoryHeader(title: 'Comments'),
          ...comment.map((e) {
            return Padding(
                padding: EdgeInsets.only(left: getProportionateScreenWidth(20), right: getProportionateScreenWidth(20),
                  bottom: 20,
                ),
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
                  constraints: const BoxConstraints(
                    minWidth: 0.0,
                    minHeight: 0.0,
                    maxWidth: double.infinity,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.username!,
                            style: TextStyle(fontSize: 16.5, color: Colors.grey[900]),
                          ),
                          const SizedBox(height: 2.5,),
                          Text(
                            timeago.format(e.commentCreatedAt!.toDate()),
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 12.0, color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          e.comment!,
                          style: const TextStyle(fontWeight: FontWeight.w400,),
                        ),
                      ),
                    ],
                  ),
                ));
          },),

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
    final comment = ref.watch(fetchCommentController).value?.where((element) => element.postId == widget.post!.postId);
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
          top: getProportionateScreenHeight(70),
          bottom: getProportionateScreenHeight(60)  //70
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(30),),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.post!.title!,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: getFontSize(18.5),//todo 15
                        ),
                      ),
                    ),

                    SizedBox(height: getProportionateScreenHeight(15),),

                    // Row(
                    //   children: socials(context, ref).toList(),
                    // ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: (){
                              // final launcher = ref.read(urlControllerProvider.notifier);
                              String whatsapp = 'https://wa.me/+2349037806442'; //TODO
                              // launcher.launchUrl(whatsapp);
                              launchURL(whatsapp);
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.whatsapp, size: 30,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: (){
                              // final launcher = ref.read(urlControllerProvider.notifier);
                              String facebook = 'https://www.facebook.com/profile.php?.id=100074370350219'; //TODO
                              launchURL(facebook);
                              // launcher.launchUrl(facebook);
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.facebook, size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: (){
                              // final launcher = ref.read(urlControllerProvider.notifier);
                              String telegram = 'https://instagram.com/campus_latestgister?igshid=YmMyMTA2M2Y='; //TODO
                              launchURL(telegram);
                              // launcher.launchUrl(telegram);
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.instagram, size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(20),),
                    if(widget.post!.postImageUrl.isNotEmpty)
                      Container(
                        height: 600,
                        width: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.post!.postImageUrl,) 
                          ),
                        ),
                      ),
                    SizedBox(height: getProportionateScreenHeight(20),),

                    Center(
                      child: Text(
                        widget.post!.caption,
                        // textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: getFontSize(10),
                        ),
                      ),
                    ),


                    SizedBox(height: getProportionateScreenHeight(20),),

                    if(category!.isNotEmpty)
                      _categoryHeader(title: "More on ${category.first.category.toString()}"),
                    ...category.map((post) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: PostCard(
                        title: post.title,
                        authorName: post.authorName,
                        dateTime: timeago.format(post.createdAt.toDate()),
                        postImageUrl: post.postImageUrl,
                      ),
                    )),

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

          // Todo: comments
          const SizedBox(height: 24,),
        if(comment!.isNotEmpty)
          _categoryHeader(title: 'Comments'),
          ...comment.map((e) {
            return Padding(
                padding: EdgeInsets.only(left: getProportionateScreenWidth(20), right: getProportionateScreenWidth(20),
                  bottom: 20,
                ),
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
                  constraints: const BoxConstraints(
                    minWidth: 0.0,
                    minHeight: 0.0,
                    maxWidth: double.infinity,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.username!,
                            style: TextStyle(fontSize: 16.5, color: Colors.grey[900]),
                          ),
                          const SizedBox(height: 2.5,),
                          Text(
                            timeago.format(e.commentCreatedAt!.toDate()),
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 12.0, color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          e.comment!,
                          style: const TextStyle(fontWeight: FontWeight.w400,),
                        ),
                      ),
                    ],
                  ),
                ));
          },),

          const SizedBox(height: 24,),
          const Footer()
        ],
      ),
    );
  }
}
