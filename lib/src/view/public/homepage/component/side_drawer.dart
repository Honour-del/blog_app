import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:flutter/material.dart';
// import 'package:numbers/utils/size_config.dart';


class TabBarComponent extends StatelessWidget {
  final List<String> tabs;
  final List<Widget> tabViews;

  const TabBarComponent({Key? key, required this.tabs, required this.tabViews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Column(
          children: [
            const SizedBox(height: 30,),
            TabBar(
              labelColor: Theme.of(context).primaryColor,
              // unselectedLabelColor: Color(0xFFB6B6B6),
              isScrollable: true,
              indicator: CustomTabIndicator(),
              labelPadding: const EdgeInsets.only(left: 20, right: 20),
              labelStyle: TextStyle(
                fontSize: getFontSize(12),
                fontWeight: FontWeight.w700,
                // fontFamily: 'Ubuntu'
              ),
              tabs: tabs.map((tab) => Tab(text: tab)).toList(),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              // height: MediaQuery.sizeOf(context).height *2,
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: tabViews,
              ),
            ),
      ]),
    );
  }
}


/* ---------------------CUSTOM_PAINTER------------------------ */
class CustomTabIndicator extends Decoration {
  @override
  CustomPainter createBoxPainter([VoidCallback? onChanged]) =>
      CustomPainter(this, onChanged);
}

class CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  CustomPainter(this.decoration, VoidCallback? onChanged)
      :
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {


    final Rect rect = Rect.fromLTWH(
        configuration.size!.width / 5.4 + offset.dx - 30,///4.4
        offset.dy + 40,
        150,
        3);
    final Paint paint = Paint();
    paint.color = Colors.blueGrey;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topLeft: const Radius.circular(0),
        topRight: const Radius.circular(0),
      ),
      paint,
    );
  }
}
