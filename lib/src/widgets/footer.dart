import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/helper/responsive.dart';
import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // color: Color.fromRGBO(33, 51, 69, 1),
        color: Colors.white
      ),
      height: 70,
      width: double.infinity,
      child: Center(
        child: Text(
          'Copyright\u00A9 2023 \nAlien(\u{1F47D})-blogSite.com /nDesign By Alienwear',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).canvasColor,
            fontSize: Responsive.isMobile(context) ? getFontSize(12) : getFontSize(4),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}




/// custom cupertino alert dialog box


class CupertinoAlertBox extends StatelessWidget {
  const CupertinoAlertBox({Key? key, this.del, this.edit, this.bodyText, this.titleText}) : super(key: key);
  final VoidCallback? del;
  final VoidCallback? edit;
  final String? titleText;
  final String? bodyText;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Delete?"),
      // backgroundColor: Colors.transparent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,),
            child: Center(
              child: Text(
                  titleText ?? 'Wanna delete this post?'
              ),
            ),
          ),
          // container1(),
          // container2(context),
          // const SizedBox(height: 15,),
          // container2(context),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: del,
          child: const Text('Delete'),
        ),
        CupertinoDialogAction(
          onPressed: edit,
          child: const Text('Edit'),
        ),
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: ()=> pop(context),
        ),
      ],
    );
  }
}

