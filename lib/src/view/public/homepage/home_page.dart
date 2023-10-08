// ignore: depend_on_referenced_packages
import 'package:explore_flutter_with_dart_3/src/controllers/feeds.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/helper/drawer.dart';
import 'package:explore_flutter_with_dart_3/src/helper/responsive.dart';
import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:explore_flutter_with_dart_3/src/helper/scroll_controller.dart';
import 'package:explore_flutter_with_dart_3/src/services/router.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/welcome/welcome_page.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/homepage/component/comment_and_subscribe.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/homepage/component/side_drawer.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/post_details_screen/post_view.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/searchlist/search_result.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/cards.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

TextEditingController _search = TextEditingController();
TextEditingController _comment = TextEditingController();
TextEditingController _name = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _email1 = TextEditingController();

// final ScrollController scrollController = ScrollController();

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    // final fullList = ref.watch(newFeedProvider);
    // final notifier = ref.watch(themeNotifierProvider);
    // final filteredList = ref.watch(fetchProviderController(category!));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Responsive.isMobile(context) ? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 80,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor
        ),
      ) : null,
      drawer: (Responsive.isMobile(context) || Responsive.isTablet(context))
          ? Drawer(
        child: CustomDrawer(
          // scrollController: scrollController,
          scrollController: ref.read(scrollNotifierProvider),
        ),
      )
          : null,
      // floatingActionButton: Responsive.isDesktop(context) ?
      // FloatingActionButton(
      //   // materialTapTargetSize: MaterialApp,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   onPressed: (){
      //     ref.read(themeNotifierProvider.notifier).changeTheme;        },
      //   child: SizedBox(
      //     height: 10,
      //     width: 10,
      //     child: ListTile(
      //       leading: Icon(Icons.sunny),
      //       trailing: Transform.scale(
      //         scale: 0.8,
      //         child: Switch(
      //           // value: notifier.darkTheme,
      //             value: notifier  == ThemeMode.system,
      //             onChanged: (onChanged){
      //               ref.read(themeNotifierProvider.notifier).changeTheme(onChanged);
      //             }),
      //       ),
      //     ),
      //   ),
      // ) : null,
      body: Responsive.isMobile(context) ? SingleChildScrollView(
        controller: ref.read(scrollNotifierProvider),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: padding.padding,
          child: _mobile(),
        ),
      ) : _desktop(),
    );
  }



  /* Mobile view of the homepage */
  Widget _mobile (){
    final fullList = ref.watch(newFeedProvider);
   return Padding(
     padding: const EdgeInsets.only(
       left: 2,
     ),
     child: fullList.when(data: (snapshot){
       final now = DateTime.now();
       final latestNews = snapshot.where((n) => now.difference(n.createdAt.toDate()).inHours <= 24).toList();
       final education = snapshot.where((element) => element.category == 'Education').toList();
       final lifeStyle = snapshot.where((element) => element.category == 'Relationship & Lifestyle').toList();
       final gists = snapshot.where((element) => element.category == 'Gist').toList();
       final sport = snapshot.where((element) => element.category == 'Sports').toList();
       return Column(
         children: [
           const SizedBox(height: 40,),

           Image.asset("assets/images/banner.jpg",),

           const SizedBox(height: 40,),
           Text(
             'Looking for something? Search below',
             style: TextStyle(
                 fontSize: getFontSize(20),
               color: Theme.of(context).primaryColor
             ),
           ),

           const SizedBox(height: 40,),

           Padding(
             padding: const EdgeInsets.only(top: 12),
             child: SizedBox(
               child: Column(
                 children: [
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: const Color.fromRGBO(14, 32, 51, 1),
                     ),
                     child: TextFormField(
                       decoration: InputDecoration(
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide: const BorderSide(
                             width: 0, color: Colors.transparent,
                           ),
                         ),
                         hintText: "Search articles....",
                         hintStyle: const TextStyle(
                             color: Color.fromRGBO(139, 139, 139, 1)
                         ),
                       ),
                       style: const TextStyle(color: Colors.white),
                       controller: _search,
                       keyboardType: TextInputType.text,
                     ),
                   ),

                   const SizedBox(height: 10,),

                   RectangularTextButton(
                     title: 'Search....',
                     bgColor: Theme.of(context).cardColor,
                     height: getProportionateScreenHeight(70),
                     width: getProportionateScreenWidth(200),
                     style: TextStyle(
                         fontSize: 15,
                         fontWeight: FontWeight.w600,
                         color: Theme.of(context).scaffoldBackgroundColor
                     ),
                     onTap: (){
                       push(context, SearchScreen(search: _search.text,));
                     },
                   ),

                 ],
               ),
             ),
           ),

           const SizedBox(height: 20,),
           if(snapshot.isEmpty)
             emptyWidget(context),
           _categoryHeader(),
           ...latestNews.map((e) => GestureDetector(
             onTap: (){
               print(e.postId);
               Application.router!.navigateTo(context, "/home/postView/${e.postId}");
               // push(context, PostView(
               //   postId: e.postId,
               // ));

             },
             child: PostCard(
               title: e.title,
               authorName: e.authorName,
               dateTime: timeago.format(e.createdAt.toDate()),
               postImageUrl: e.postImageUrl,
             ),
           )),

           if(gists.isNotEmpty)
             _categoryHeader(title: 'Gists'),
           ...gists.map((e) => GestureDetector(
             onTap: (){
               print(e.postId);
               Application.router!.navigateTo(context, "/home/postView/${e.postId}");
               // push(context, PostView(
               //   postId: e.postId,
               // ));
             },
             child: PostCard(
               authorName: e.authorName,
               dateTime: timeago.format(e.createdAt.toDate()),
               postImageUrl: e.postImageUrl,
               title: e.title,
             ),
           )),

           if(lifeStyle.isNotEmpty)
             _categoryHeader(title: "Relationship & Lifestyle"),
           ...lifeStyle.map((e) => GestureDetector(
             onTap: (){
               print(e.postId);
               Application.router!.navigateTo(context, "/home/postView/${e.postId}");
               // push(context, PostView(
               //   postId: e.postId,
               // ));
             },
             child: PostCard(
               authorName: e.authorName,
               title: e.title,
               dateTime: timeago.format(e.createdAt.toDate()),
               postImageUrl: e.postImageUrl,
             ),
           )),

           if(education.isNotEmpty)
             _categoryHeader(title: "Education"),
           ...education.map((e) => GestureDetector(
             onTap: (){
               print(e.postId);
               Application.router!.navigateTo(context, "/home/postView/${e.postId}");
               // push(context, PostView(
               //   postId: e.postId,
               // ));
             },
             child: PostCard(
               authorName: e.authorName,
               dateTime: timeago.format(e.createdAt.toDate()),
               postImageUrl: e.postImageUrl,
               title: e.title,
             ),
           )),

           if(sport.isNotEmpty)
             _categoryHeader(title: 'Sports'),
           ...sport.map((e) => GestureDetector(
             onTap: (){
               print(e.postId);
               Application.router!.navigateTo(context, "/home/postView/${e.postId}");
               // push(context, PostView(
               //   postId: e.postId,
               // ));
             },
             child: PostCard(
               title: e.title,
               authorName: e.authorName,
               dateTime: timeago.format(e.createdAt.toDate()),
               postImageUrl: e.postImageUrl,
             ),
           )),
           const SizedBox(height: 17,),

           CommentAndSubscribe(
             key: const Key('Sports'),
             i: _comment,
             ii: _name,
             iii: _email,
             iv: _email1,
           ),

           const SizedBox(height: 17,),
           const Footer()
         ],
       );
     },
       error: (e,_)=> throw e,
       loading: () => kProgressIndicator,
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


  Widget _desktop ()=> TabBarComponent(tabs: const ["ALL NEWS","GISTS","LIFESTYLE","EDUCATION","SPORTS","ADMIN"],
      tabViews: [
        const ContentAll(category: 'All News', title: 'All News',), // allNews todo
        Content(title: "Gists".toUpperCase(), category: 'Gist',),
        const Content(title: 'Relationship & Lifestyles', category: 'Relationship & Lifestyle',),
        Content(title: "Education".toUpperCase(), category: 'Education',),
        Content(title: 'Sports'.toUpperCase(), category: 'Sports',),
        const WelcomePage(),
      ]);
}



class Content extends ConsumerWidget {
  const Content({Key? key, this.title, this.category}) : super(key: key);
  final String? title;
  final String? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final filtered = ref.watch(newFeedProvider).value?.where((element) => element.category == category);
    final filteredList = ref.watch(fetchProviderController(category!));
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: padding.padding,
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Image.asset("assets/images/banner.jpg",),
            const SizedBox(height: 10,),
            Center(
              child: Text(
                'Looking for something? Search below',
                style: TextStyle(
                    fontSize: getFontSize(14)
                ),
              ),
            ),

            const SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromRGBO(14, 32, 51, 1),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                width: 0, color: Colors.transparent,
                              ),
                            ),
                            hintText: "Search articles....",
                            hintStyle: const TextStyle(
                                color: Color.fromRGBO(139, 139, 139, 1)
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),

                          controller: _search,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),

                    const SizedBox(width: 15,),

                    Expanded(
                      child: RectangularTextButton(
                        title: 'Search',
                        bgColor: Theme.of(context).cardColor,
                        height: getProportionateScreenHeight(75),
                        width: getProportionateScreenWidth(120),
                        style: TextStyle(
                            fontSize: getFontSize(10),
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).scaffoldBackgroundColor
                        ),
                        onTap: (){
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20,),

            //TODO
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                title ?? 'Latest News',
                style: TextStyle(
                    fontSize: getFontSize(16),
                    color: Theme.of(context).primaryColor
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                filteredList.value!.isNotEmpty ? filteredList.when(
                  data: (data){
                    return Expanded(
                      flex: 3,
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2,
                            crossAxisSpacing: 25,
                            mainAxisSpacing: 25,
                          ),
                          itemBuilder: (context, index) {
                            final post = data[index];
                            // String id = post.postId;
                            return GestureDetector(
                              onTap: (){
                                // push(context, PostView(post: post,));
                                print(post.postId);
                                Application.router!.navigateTo(context, "/home/postView/${post.postId}");
                              },
                              child: PostCard(
                                title: post.title,
                                authorName: post.authorName,
                                dateTime: timeago.format(post.createdAt.toDate()),
                                postImageUrl: post.postImageUrl,
                              ),
                            );
                          }
                      ),
                    );
                  },
                  error: (e,_)=> throw e,
                  loading: () => kProgressIndicator,)
                    : Expanded(flex: 3,
                    child: emptyWidget(context)),
            //
                const SizedBox(width: 20,),

                Expanded(
                  child: CommentAndSubscribe(
                      i: _comment,
                      ii: _name,
                      iii: _email,
                      iv: _email1
                  ),
                )
              ],
            ),

            const Footer()
          ],
        ),
      ),
    );
  }
}


class ContentAll extends ConsumerWidget {
  const ContentAll({Key? key, this.title, this.category}) : super(key: key);
  final String? title;
  final String? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final filtered = ref.watch(newFeedProvider).value?.where((element) => element.category == category);
    final filteredList = ref.watch(justFetchProviderController);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: padding.padding,
        child: Column(
          children: [
            // const SizedBox(height: 10,),
            Image.asset("assets/images/banner.jpg",
              // width: MediaQuery.sizeOf(context).width,
            ),
            // const SizedBox(height: 10,),
            Center(
              child: Text(
                'Looking for something? Search below',
                style: TextStyle(
                    fontSize: getFontSize(14)
                ),
              ),
            ),

            const SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromRGBO(14, 32, 51, 1),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                width: 0, color: Colors.transparent,
                              ),
                            ),
                            hintText: "Search articles....",
                            hintStyle: const TextStyle(
                                color: Color.fromRGBO(139, 139, 139, 1)
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),

                          controller: _search,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),

                    const SizedBox(width: 15,),

                    Expanded(
                      child: RectangularTextButton(
                        title: 'Search',
                        bgColor: Theme.of(context).cardColor,
                        height: getProportionateScreenHeight(75),
                        width: getProportionateScreenWidth(120),
                        style: TextStyle(
                            fontSize: getFontSize(10),
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).scaffoldBackgroundColor
                        ),
                        onTap: (){
                          push(context, SearchScreen(search: _search.text,));
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20,),

            //TODO
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                title ?? 'Latest News',
                style: TextStyle(
                    fontSize: getFontSize(16),
                    color: Theme.of(context).primaryColor
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                filteredList.value!.isNotEmpty ? filteredList.when(
                  data: (data){
                    return Expanded(
                      flex: 3,
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2,
                            crossAxisSpacing: 25,
                            mainAxisSpacing: 25,
                          ),
                          itemBuilder: (context, index) {
                            final post = data[index];
                            return GestureDetector(
                              onTap: (){
                                print(post.postId);
                                Application.router!.navigateTo(context, "/home/postView/${post.postId}");
                                // push(context, PostView(postId: post.postId,));
                              },
                              child: PostCard(
                                title: post.title,
                                authorName: post.authorName,
                                dateTime: timeago.format(post.createdAt.toDate()),
                                postImageUrl: post.postImageUrl,
                              ),
                            );
                          }
                      ),
                    );
                  },
                  error: (e,_)=> throw e,
                  loading: () => kProgressIndicator,)
                    : Expanded(flex: 3,
                    child: emptyWidget(context)),
                //
                const SizedBox(width: 20,),

                Expanded(
                  child: CommentAndSubscribe(
                      i: _comment,
                      ii: _name,
                      iii: _email,
                      iv: _email1
                  ),
                )
              ],
            ),

            const Footer()
          ],
        ),
      ),
    );
  }
}
