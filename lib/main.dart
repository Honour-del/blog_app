import 'package:explore_flutter_with_dart_3/firebase_options.dart';
import 'package:explore_flutter_with_dart_3/src/helper/theme.dart';
import 'package:explore_flutter_with_dart_3/src/services/router.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/homepage/home_page.dart';
// import 'package:explore_flutter_with_dart_3/src/services/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp())
  );
}


// GoRouter _appRoute = GoRouter(routes: <RouteBase>[
//   GoRoute(
//     path: '/',
//     builder: (BuildContext context, GoRouterState state){
//       return const HomePage();
//     },
//   ),
//   GoRoute(
//     path: '/welcome',
//     builder: (BuildContext context, GoRouterState state){
//       return const WelcomePage();
//     },
//   ),
//   GoRoute(
//     path: '/postView',
//     builder: (BuildContext context, GoRouterState state){
//       return const PostView();
//     },
//   ),
//   // GoRoute(
//   //   path: '/addPost',
//   //   builder: (BuildContext context, GoRouterState state){
//   //     return const AddPost();
//   //   },
//   // ),
// ]);


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> { _AppState(){
  final router = FluroRouter();
  FluroRouteMain.setupRouter(router);
  Application.router = router;
}
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  _MyAppState(){
    final router = FluroRouter();
    FluroRouteMain.setupRouter(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(themeNotifierProvider);
    return ScreenUtilInit(
      // designSize: const Size(1920, 1080),
      designSize: const Size(428, 926),
      builder: (context, child) => MaterialApp(
        title: 'clgister',
        debugShowCheckedModeBanner: false,
        theme: Themes.darkTheme,
        darkTheme: Themes.lightTheme,
        themeMode: notifier,
        initialRoute: '/home',
        // home: const HomePage(),
        onGenerateRoute: Application.router?.generator,
        // onGenerateRoute: FluroRouteMain.router.generator(routeSettings),

        // home: const SplashScreen(),
      ),
    );
  }
}

// api+key:  46a720cc9781449db10f31f8e30b90a2