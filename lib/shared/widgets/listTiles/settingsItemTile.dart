// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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

import '../../../themes/theme.dart';
import '../../animatedButton.dart';

class SettingsItemTile extends StatelessWidget {
  const SettingsItemTile({
    Key key,
    this.title,
    this.onTap,
    this.iconData,
  }) : super(key: key);

  final String title;
  final Function onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return AnimButton(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        decoration: BoxDecoration(
          color: _theme.colorScheme.background,
          borderRadius: ThemeGuide.borderRadius,
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: _theme.disabledColor.withAlpha(20),
                borderRadius: ThemeGuide.borderRadius,
              ),
              child: Icon(iconData),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  title,
                  style: _theme.textTheme.subtitle2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
