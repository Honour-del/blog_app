
import 'package:explore_flutter_with_dart_3/src/controllers/comment.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/helper/responsive.dart';
import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/cards.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentAndSubscribe extends ConsumerStatefulWidget {
  const CommentAndSubscribe({Key? key, required this.i, required this.ii, required this.iii, required this.iv, this.postId,}) : super(key: key);

  final TextEditingController i;
  final TextEditingController ii;
  final TextEditingController iii;
  final TextEditingController iv;

  final String? postId;


  @override
  ConsumerState<CommentAndSubscribe> createState() => _CommentAndSubscribeState();
}
final key = GlobalKey<FormState>();
bool loading = false;

class _CommentAndSubscribeState extends ConsumerState<CommentAndSubscribe> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'BE THE FIRST TO COMMENT',
              style: TextStyle(
                // decoration: TextDecoration.underline,
                  color: Theme.of(context).primaryColor,
                  fontSize: Responsive.isMobile(context) ? getFontSize(17) : getFontSize(5),
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
          const Divider(),

          SizedBox(height: getProportionateScreenHeight(15),),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Leave a Reply',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: Responsive.isMobile(context) ? getFontSize(17) : getFontSize(5),
                  fontWeight: FontWeight.w700
              ),
            ),
          ),

          SizedBox(height: getProportionateScreenHeight(26),),

          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Your email address will not be published.',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: Responsive.isMobile(context) ? getFontSize(17) : getFontSize(5),
                  fontWeight: FontWeight.w700
              ),
            ),
          ),

          SizedBox(height: getProportionateScreenHeight(22),),

          InputField(
            label: 'Comment',
            hint: '',
            height: 150,
            x: 6,
            keyboardType: TextInputType.text,
            controller: widget.i,
          ),
          SizedBox(height: getProportionateScreenHeight(12),),

          InputField(
            label: 'Name',
            hint: '',
            keyboardType: TextInputType.text,
            controller: widget.ii,
          ),
          SizedBox(height: getProportionateScreenHeight(12),),

          InputField(
            label: 'Email',
            hint: '',
            keyboardType: TextInputType.text,
            controller: widget.iii,
          ),
          SizedBox(height: getProportionateScreenHeight(15),),

          if(loading)
            kProgressIndicator,

          RectangularTextButton(
            title: 'POST COMMENT',
            bgColor: Theme.of(context).cardColor,
            height: getProportionateScreenHeight(50),
            width: getProportionateScreenWidth(200),
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).canvasColor
            ),
            onTap: (){
              key.currentState!.save();
              setState(() {
                loading = true;
              });
              ref.read(commentProvider.notifier).addComment(
                postId: widget.postId!,
                comment: widget.i.text,
                userName: widget.ii.text,
              );
              setState(() {
                loading = false;
              });
            },
          ),
          SizedBox(height: getProportionateScreenHeight(17),),



          Text(
            'SUBSCRIBE FOR LATEST POST',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: Responsive.isMobile(context) ? getFontSize(17) : getFontSize(5),
                fontWeight: FontWeight.w700
            ),
          ),

          const Divider(),

          InputField(
            label: 'Email',
            hint: '',
            keyboardType: TextInputType.text,
            controller: widget.iv,
          ),
          SizedBox(height: getProportionateScreenHeight(12),),
          Center(
            child: RectangularTextButton(
              title: 'SUBSCRIBE',
              bgColor: Theme.of(context).cardColor,
              height: getProportionateScreenHeight(60),
              width: getProportionateScreenWidth(120),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).canvasColor // canvasColor
              ),
              onTap: (){},
            ),
          ),

        ],
      ),
    );
  }
}
