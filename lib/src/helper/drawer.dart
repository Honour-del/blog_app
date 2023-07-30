import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:explore_flutter_with_dart_3/src/helper/scroll_controller.dart';
import 'package:explore_flutter_with_dart_3/src/helper/theme.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/welcome/welcome_page.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/homepage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({Key? key, required this.scrollController}) : super(key: key);
  final ScrollController scrollController;
  static String routeName = "/customDrawer";
  @override
  Widget build(BuildContext context, ref) {
    // final scrollProvider = ref.watch(scrollNotifierProvider);
    final notifier = ref.watch(themeNotifierProvider);
    return Scaffold(
      body: Padding(
        padding: padding.padding,
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SwitchListTile(
                title: Text('Theme', style: Theme.of(context).textTheme.bodyMedium,),
                  // value: notifier.darkTheme,
                  value: notifier  == ThemeMode.system,
                  onChanged: (onChanged){
                  ref.read(themeNotifierProvider.notifier).changeTheme(onChanged);
              }),
            ),


            ListTile(
              title: Text(
                'All News',
                style: TextStyle(
                    fontSize: getFontSize(12),
                    color: Theme.of(context).primaryColor
                ),
              ),
              onTap: (){
                push(context, const Content());
              },
            ),

            const SizedBox(height: 20,),
            ListTile(
              title: Text(
                'SPORTS',
                style: TextStyle(
                    fontSize: getFontSize(12),
                    color: Theme.of(context).primaryColor
                ),
              ),
              onTap: (){
                // ref.read(scrollProvider);
                pop(context);
                scrollToSection(context, ref, const Key('Sports'));
              },
            ),
            const SizedBox(height: 20,),

            ListTile(
              title: Text(
                'EDUCATION',
                style: TextStyle(
                    fontSize: getFontSize(12),
                    color: Theme.of(context).primaryColor
                ),
              ),
              onTap: (){},
            ),
            const SizedBox(height: 20,),
            ListTile(
              title: Text(
                'GISTS',
                style: TextStyle(
                    fontSize: getFontSize(12),
                    color: Theme.of(context).primaryColor
                ),
              ),
              onTap: (){},
            ),
            const SizedBox(height: 20,),
            ListTile(
              title: Text(
                'NYSC',
                style: TextStyle(
                    fontSize: getFontSize(12),
                    color: Theme.of(context).primaryColor
                ),
              ),
              onTap: (){},
            ),
            const SizedBox(height: 20,),
            ListTile(
              title: Text(
                'ADMIN',
                style: TextStyle(
                    fontSize: getFontSize(12),
                    color: Theme.of(context).primaryColor
                ),
              ),
              onTap: (){
                push(context, const WelcomePage());
              },
            ),
          ],
        ),
      ),
    );
  }
  
  
  void scrollToSection(context, WidgetRef ref,  Key key){
    // calculate the height of the app bar 
    final double appBarHeight = AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
    
    // calculate the position to scroll to based on the category's position in the column
    final int categoryIndex = findCategoryIndex(key);
    final double scrollToPosition = categoryIndex * 200.0 + appBarHeight;

    // scroll to category section
    ref.read(scrollNotifierProvider).animateTo(scrollToPosition,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

    ref.read(selectedKey.notifier); //= key;
  }

  int findCategoryIndex(Key key){
    
    List<Key> keys = const [
      Key('Education'),
      Key('Gists'),
      Key('Nysc'),
      Key('Sports'),
    ];
    return keys.indexOf(key);
  }
}

