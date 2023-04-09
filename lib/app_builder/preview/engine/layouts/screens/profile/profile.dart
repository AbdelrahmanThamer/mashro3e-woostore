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

import '../../../../../models/app_template/app_template.dart';
import '../../app_bar/app_bar.dart';
import '../../shared/screen_tile_section_layout.dart';

class ProfileScreenLayout extends StatelessWidget {
  const ProfileScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppProfileScreenData screenData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary,
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
            ),
          ),
          _Body(screenData: screenData),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, required this.screenData}) : super(key: key);
  final AppProfileScreenData screenData;

  @override
  Widget build(BuildContext context) {
    final List<dynamic> list = [
      'profile-info-container',
      ...screenData.sections,
    ];
    return CustomScrollView(
      controller: ScrollController(),
      slivers: [
        if (screenData.appBarData.show)
          SliverAppBarLayout(
            overrideTitle: 'Profile',
            data: screenData.appBarData,
          ),
        SliverPadding(
          padding: ThemeGuide.listPadding,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                if (list[i] == 'profile-info-container') {
                  return const _FirstItem();
                }

                return ScreenTileSectionLayout(
                  data: list[i] as ScreenTileSectionData,
                );
              },
              childCount: list.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _FirstItem extends StatelessWidget {
  const _FirstItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: ThemeGuide.borderRadius20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'User Name',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text('user-123@email.com'),
            ],
          ),
        ),
      ),
    );
  }
}
