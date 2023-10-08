import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

String viewId = "your-view-id";

// bannerUnitId
Widget adsenseAdsView(){
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
    '',
        (int viewId) => html.IFrameElement()
      ..style.width = '100%'
      ..style.height = '100%'
      ..srcdoc  = '''
      <!DOCTYPE html>
      <html><head></head>
      <body>
      <div data-frill-widget="your ad unit will come here" style="width: 340px; height: 460px;"> </div>
      <script async src="url"></script>
      </body>
      </html>
      '''
      ..style.border = 'none'
  );


  return SizedBox(
    height: 460,
    width: 340,
    child: HtmlElementView(
        viewType: viewId
    ),
  );
}