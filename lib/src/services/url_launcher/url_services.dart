import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:url_launcher/url_launcher.dart';



final contactServiceProvider = Provider<ContactService>((ref) {
  return ContactService();
});

class ContactService{

  launchURL(String url) async{
    final uri = Uri.parse(url);
    if(await canLaunchUrl(uri)){
      await launchUrl(uri);
      kPrint('$uri launched');
    }else{
      throw 'Could not launch';
    }
  }
}