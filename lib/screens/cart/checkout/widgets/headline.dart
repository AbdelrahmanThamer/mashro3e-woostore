// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

// @dart=2.9

import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

class Headline extends StatelessWidget {
  const Headline({Key key, this.title, this.subtitle}) : super(key: key);
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        text: title ?? '',
        style: _theme.textTheme.headline5,
        children: [
          if (isNotBlank(subtitle))
            TextSpan(
              text: '\n$subtitle',
              style: _theme.textTheme.caption.copyWith(fontSize: 12),
            ),
        ],
      ),
    );
  }
}
