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

import 'package:flutter/material.dart';

import '../../app_builder/app_builder.dart';
import '../../generated/l10n.dart';
import '../shared/app_bar/app_bar.dart';
import '../shared/screen_tile/screen_tile_section_layout.dart';

class SettingsScreenLayout extends StatelessWidget {
  const SettingsScreenLayout({Key? key, required this.screenData})
      : super(key: key);
  final AppSettingScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          if (screenData.appBarData.show)
            SliverAppBarLayout(
              overrideTitle: S.of(context).settings,
              data: screenData.appBarData,
            ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  return ScreenTileSectionLayout(data: screenData.sections[i]);
                },
                childCount: screenData.sections.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
