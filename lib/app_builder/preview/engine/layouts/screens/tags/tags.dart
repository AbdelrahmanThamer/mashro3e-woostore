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

import '../../../../../models/app_template/app_template.dart';
import '../../app_bar/app_bar.dart';
import '../dynamic/sections/shared/decorator.dart';

class TagsScreenLayout extends StatelessWidget {
  const TagsScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppTagsScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (screenData.appBarData.show)
            SliverAppBarLayout(
              data: screenData.appBarData,
              overrideTitle: 'Tags',
            ),
          if (screenData.layout == TagsScreenLayoutType.grid)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100),
              sliver: _Grid(screenData: screenData),
            ),
          if (screenData.layout == TagsScreenLayoutType.list)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100),
              sliver: _VerticalList(screenData: screenData),
            ),
          if (screenData.layout == TagsScreenLayoutType.wrap)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100),
              sliver: _Wrap(screenData: screenData),
            ),
        ],
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppTagsScreenData screenData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenData.columns,
        childAspectRatio: screenData.itemStyledData.dimensionsData.aspectRatio,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return SectionLayoutDecorator(
            styledData: screenData.itemStyledData,
            forcedColor: theme.colorScheme.background,
            child: Center(
              child: Text(
                'Tags$i',
                style:
                    screenData.itemStyledData.textStyleData.createTextStyle(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          );
        },
        childCount: 20,
      ),
    );
  }
}

class _VerticalList extends StatelessWidget {
  const _VerticalList({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppTagsScreenData screenData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return SectionLayoutDecorator(
            styledData: screenData.itemStyledData,
            forcedColor: theme.colorScheme.background,
            child: SizedBox(
              height: screenData.itemStyledData.dimensionsData.height,
              child: Center(
                child: Text(
                  'Tags$i',
                  style:
                      screenData.itemStyledData.textStyleData.createTextStyle(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          );
        },
        childCount: 20,
      ),
    );
  }
}

class _Wrap extends StatelessWidget {
  const _Wrap({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppTagsScreenData screenData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Wrap(
          children: List.generate(
            40,
            (i) => SectionLayoutDecorator(
              styledData: screenData.itemStyledData,
              forcedColor: theme.colorScheme.background,
              child: Text(
                'Tags$i',
                style:
                    screenData.itemStyledData.textStyleData.createTextStyle(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
