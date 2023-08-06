import 'package:flutter/material.dart';

class AdvertWidget extends StatelessWidget {
  const AdvertWidget({Key? key,
    this.image,
    this.caption
  }) : super(key: key);

  final String? caption;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.network(image!,),
        ),
      ),
    );
  }
}
