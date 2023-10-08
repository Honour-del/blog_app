import 'dart:async';

import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/add_post/add_post.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/dashboard/dashboard.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/post_lists/post_lists.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/welcome/welcome_page.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/homepage/home_page.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/post_details_screen/post_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart' as fluro;


class Application{
  static FluroRouter? router;
}
const String home = '/home';
const String postView = '/postView';
const String welcome = '/welcome';
const String addPost = '/addPost';
const String deletePost = '/deletePost';

class FluroRouteMain {
  // static FluroRouter router = fluro.FluroRouter();

  /* Welcome page */
  static final Handler _loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const WelcomePage());

  static final Handler _postViewHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        // final arg = context
        String colon = params["post_id"][0];
        String pure = colon.replaceAll(":", "");
        print("this is pure $pure");
        return PostView(postId: pure,);
      });//TODO

  static final Handler _homePageHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
      const HomePage());

  static final Handler _addPostHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
      const AddPost());

  static final Handler _dashboardHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
      const Dashboard());

  static final Handler _postListHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
      const PostList());

  static void setupRouter(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params){
          return const NotFound();
        });
    router.define("/home", handler: _homePageHandler, transitionType: TransitionType.fadeIn);
    router.define("/login", handler: _loginHandler, transitionType: TransitionType.fadeIn);
    router.define("/login/dashboard", handler: _dashboardHandler, transitionType: TransitionType.fadeIn);
    router.define("/login/dashboard/postList", handler: _postListHandler, transitionType: TransitionType.fadeIn);
    router.define("/login/dashboard/addPost", handler: _addPostHandler, transitionType: TransitionType.fadeIn);
    router.define("/home/postView/:post_id", handler: _postViewHandler, transitionType: TransitionType.fadeIn);
    // router.define("home/login", handler: _loginHandler, transitionType: TransitionType.fadeIn);
  }
}

// /home/postView/*  /#/home/postView./:splat  200
// /post/postId /home/postView/postId
class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Text(
            "Not Found!!!",
            style: TextStyle(
              fontSize: getFontSize(20),
              color: Theme.of(context).cardColor
            ),
          ),
        ),
      ),
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState(){
//     super.initState();
//     loadWidget();
//   }
//
//   loadWidget(){
//     var duration = const Duration(seconds: 3);
//     return Timer(duration, () {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           kProgressIndicator,
//           Text("Content Loading",
//             style: TextStyle(
//               color: const Color.fromRGBO(33, 51, 69, 1),
//               fontSize: getFontSize(30),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
