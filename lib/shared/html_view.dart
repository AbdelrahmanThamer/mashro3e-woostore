// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is, and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HtmlCustomView extends StatelessWidget {
  const HtmlCustomView({
    Key? key,
    required this.htmlText,
  }) : super(key: key);
  final String htmlText;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: htmlText,
      shrinkWrap: true,
      onLinkTap: (link, renderContext, _, __) async {
        if (isBlank(link)) {
          return;
        }

        if (await canLaunchUrlString(link!)) {
          launchUrlString(link);
        }
      },
      onImageTap: (url, _, __, ___) {},
      customImageRenders: {
        (attr, __) => attr['src'] != null: (ctx, attr, __) => Container(
              width: double.infinity,
              margin: ThemeGuide.marginV5,
              child: ExtendedCachedImage(imageUrl: attr['src']),
            )
      },
    );
  }
}
