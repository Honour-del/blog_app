import 'package:explore_flutter_with_dart_3/firebase_options.dart';
import 'package:explore_flutter_with_dart_3/src/helper/theme.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/add_post/add_post.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/advertisement/advertisement.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/dashboard/dashboard.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/post_lists/post_lists.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/homepage/home_page.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/post_details_screen/post_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp())
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.watch(themeNotifierProvider);
    return ScreenUtilInit(
      // designSize: const Size(1920, 1080),
      designSize: const Size(428, 926),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: notifier,
          // home: const HomePage(),
          home: const HomePage(),
      ),
    );
  }
}

// api+key:  46a720cc9781449db10f31f8e30b90a2