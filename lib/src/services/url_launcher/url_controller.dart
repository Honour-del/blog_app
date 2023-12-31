import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'url_services.dart';


final urlControllerProvider =
StateNotifierProvider<ContactController, dynamic>(
        (ref) => ContactController());

class ContactController extends StateNotifier{
  final Ref? _read;
  ContactController([this._read]) : super(null);

  Future<void> launchUrl(String? url) async {
    try {
      final urls = await _read?.read(contactServiceProvider).launchURL(url!);
      return urls;
    } on Exception{
      rethrow;
    }
  }
}
