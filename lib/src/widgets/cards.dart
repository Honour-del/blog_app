import 'package:explore_flutter_with_dart_3/src/helper/responsive.dart';
import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:flutter/material.dart';


/* Long rectangular cards */
class PostCard extends StatelessWidget {
  const PostCard({Key? key,
    this.height,
    this.width,
    this.title,
    this.dateTime,
    this.authorName,
    this.postImageUrl
  }) : super(key: key);

  final double? height;
  final double? width;
  final String? title;
  final String? dateTime;
  final String? authorName;
  final String? postImageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                blurRadius: 5,
              ),
            ]),
        constraints: const BoxConstraints(
          minWidth: 0.0,
          minHeight: 0.0,
          maxWidth: double.infinity,
        ),
        height: getProportionateScreenHeight(200),
        width: getProportionateScreenWidth(335),
        child: Padding(padding: const EdgeInsets.only(top: 8, left: 10, right: 15 , bottom: 10),
          child: Row(
            children: [
              Expanded(
                // flex: 1,
                child: Container(
                height: height ?? getProportionateScreenHeight(220),
                width: width ?? 0,
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: postImageUrl!.isNotEmpty ? DecorationImage(
                      image: NetworkImage(postImageUrl!),
                    ) : null,
                  ),
              ),),
              const SizedBox(width: 10,),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14,),
                    Text(
                      title! ,//?? 'Tough Times As Students In Nigeria.'
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).canvasColor,
                        fontSize: Responsive.isMobile(context) ? getFontSize(15) :  getFontSize(6),
                        fontWeight: FontWeight.w700
                      ),
                    ),

                    // const SizedBox(height: 1.5,),
                    const Spacer(),
                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(text: TextSpan(
                          children: [
                            WidgetSpan(
                                child: Icon(
                                  Icons.lock_clock,
                                  color: Colors.black,
                                  size: Responsive.isMobile(context) ? getFontSize(13) :  getFontSize(5.5),
                                )
                            ),
                            const WidgetSpan(child: SizedBox(width: 1,)),
                            TextSpan(
                                text: dateTime,
                                style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: Responsive.isMobile(context) ? getFontSize(12) :  getFontSize(4.5),
                                )
                            ),
                          ]
                        )),

                        RichText(text: TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: Responsive.isMobile(context) ? getFontSize(13) :  getFontSize(5.5),
                                  ),
                              ),
                              const WidgetSpan(child: SizedBox(width: 1,)),
                              TextSpan(
                                  text: authorName,
                                  style: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                    fontSize: Responsive.isMobile(context) ? getFontSize(12) :  getFontSize(4.5),
                                  )
                              ),

                            ]
                        )),

                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
class RectangularTextButton extends StatelessWidget {
  RectangularTextButton({Key? key,
    this.height, this.width, this.color, this.title, this.onTap, this.style, this.bgColor
  }) : super(key: key);
  double? width;
  double? height;
  String? title;
  Color? color;
  Color? bgColor;
  VoidCallback? onTap;
  TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          color: bgColor,
        ),
        height: height,
        width: width,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title!,
            style: style,
          ),
        ),
      ),
    );
  }
}

