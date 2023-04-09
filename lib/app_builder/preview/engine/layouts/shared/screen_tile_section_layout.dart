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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/app_template/app_screen_data/app_screen_data.dart';
import '../../engine.dart';

class ScreenTileSectionLayout extends StatelessWidget {
  const ScreenTileSectionLayout({Key? key, required this.data})
      : super(key: key);
  final ScreenTileSectionData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: data.action,
      )?.call(),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: ThemeGuide.borderRadius10,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: ThemeGuide.borderRadius10,
              ),
              child: Icon(data.iconData),
            ),
            const SizedBox(width: 10),
            Text(
              data.name,
              style: const TextStyle(fontSize: 16),
            ),
            if (data.type == ScreenTileSectionType.darkMode) const Spacer(),
            if (data.type == ScreenTileSectionType.darkMode)
              const CupertinoSwitch(value: true, onChanged: null),
          ],
        ),
      ),
    );
  }
}
