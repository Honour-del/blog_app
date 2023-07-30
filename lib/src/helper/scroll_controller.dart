//


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final scrollNotifierProvider = StateNotifierProvider<ScrollControllerNotifier, ScrollController>((ref) => ScrollControllerNotifier());

final selectedKey = StateProvider<Key?>((ref) => null);

class ScrollControllerNotifier extends StateNotifier<ScrollController>{
  ScrollControllerNotifier():  super(ScrollController());

  void dispose(){
    state.dispose();
  }
}

//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
//

//
// final drawerNotifierProvider = StateNotifierProvider((ref) => DrawerProvider(ref));
//
// class ScrollProvider extends Notifier<ScrollController>{
//   final scrollController = ScrollController();
//
//   ScrollProvider() : super();
//
//   void dispose() {
//     state.dispose();
//   }
//
//   ScrollController get controller => scrollController;
//   scroll(int index){
//     double offset = index == 1
//         ? 270
//         : index == 2
//         ? 255 : index == 3
//         ? 250
//         : 245;
//     controller.animateTo(
//         offset * index.toDouble(),
//         duration: const Duration(seconds: 1),
//         curve: Curves.easeInOut,
//     );
//   }
//
//   scrollMobile(int index){
//     double offset = index == 1
//         ? 290
//         : index == 2
//         ? 360 : index == 3
//         ? 300
//         : 310;
//     controller.animateTo(
//       offset * index.toDouble(),
//       duration: const Duration(seconds: 1),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   ScrollController build() {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
//
// class DrawerProvider extends StateNotifier{
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   DrawerProvider(super.state);
//
//   GlobalKey<ScaffoldState> get key => scaffoldKey;
// }