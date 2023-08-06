import 'package:explore_flutter_with_dart_3/src/controllers/auth.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/helper/responsive.dart';
import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/add_post/add_post.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/advertisement/advertisement.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/post_lists/post_lists.dart';
import 'package:explore_flutter_with_dart_3/src/view/public/homepage/home_page.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,////80
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(right: 4, left: 6, top: 20),
          title: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: Responsive.isMobile(context) ? getFontSize(29) : getFontSize(20),
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 20,),
                Text(
                  'Welcome on board! Admin',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: Responsive.isMobile(context) ? getFontSize(20) : getFontSize(12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 40,
          ),
          child: Responsive(
              mobile: _mobile(),
              desktop: _desktop(),
          ),
        ),
      ),
    );
  }


  logoutButton(){
    return RectangularTextButton(
      title: 'Log Out',
      bgColor: Theme.of(context).cardColor,
      height: getProportionateScreenHeight(75),
      width: getProportionateScreenWidth(120),
      style: TextStyle(
          fontSize: getFontSize(12),
          fontWeight: FontWeight.w700,
          color: Theme.of(context).scaffoldBackgroundColor
      ),
      onTap: (){
        ref.read(authControllerProvider.notifier).logout();
        pushReplacement(context, const HomePage());
      },
    );
  }

Widget _mobile() => Center(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage(avatar),
          radius: 40,
        ),
        const SizedBox(height: 15,),
        _Cards(
          onTap: (){
            push(context, const Advertise());
          },
          label: "Manage\nAdvertisement",
          iconData: Icons.people,
        ),

        _Cards(
            label: "Create Post",
            iconData: Icons.edit,
            onTap: (){
              push(context, const AddPost());
            }
        ),

        _Cards(
          label: "Manage Posts",
          iconData: Icons.people,
            onTap: (){
              push(context, const PostList());
            },
        ),

        const SizedBox(height: 25,),

        logoutButton(),
      ],
    ),

);

  Widget _desktop() => Column(
    children: [
      const CircleAvatar(
        backgroundImage: NetworkImage(avatar),
        radius: 40,
      ),
      const SizedBox(height: 18,),
      Row(
        children: [
          Expanded(
            child: _Cards(
              onTap: (){
                push(context, const Advertise());
              },
              label: "Manage Advertisement",
              iconData: Icons.people,
            ),
          ),

          Expanded(
            child: _Cards(
                label: "Create Post",
                iconData: Icons.edit,
                onTap: (){
                  push(context, const AddPost());
                }
            ),
          ),

          Expanded(
            child: _Cards(
              label: "Manage Posts",
              iconData: Icons.people,
              onTap: (){
                push(context, const PostList());
              },
            ),
          )
        ],
      ),

      const SizedBox(height: 25,),

      logoutButton(),
    ],
  );



}

class _Cards extends StatelessWidget {
  const _Cards({Key? key, required this.onTap, this.label, this.iconData}) : super(key: key);

  final VoidCallback onTap;
  final String? label;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          height: getProportionateScreenHeight(200),
          width: getProportionateScreenWidth(200),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                  size: 19,
                ),
                const SizedBox(height: 15,),

                Text(
                  label!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
