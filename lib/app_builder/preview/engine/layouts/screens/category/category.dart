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

class CategoryScreenLayout extends StatelessWidget {
  const CategoryScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppCategoryScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (screenData.appBarData.show)
            SliverAppBarLayout(
              data: screenData.appBarData,
              overrideTitle: 'Category',
            ),
          if (screenData.layout == CategoriesScreenLayoutType.grid)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100),
              sliver: _Grid(screenData: screenData),
            ),
          if (screenData.layout == CategoriesScreenLayoutType.list)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100),
              sliver: _VerticalList(screenData: screenData),
            ),
          // if (screenData.layout ==
          //     CategoriesScreenLayout.listChildCategoriesVisible)
          //   SliverPadding(
          //     padding: const EdgeInsets.only(bottom: 100),
          //     sliver: _ListWithChild(screenData: screenData),
          //   ),
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
  final AppCategoryScreenData screenData;

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
            child: Column(
              children: [
                if (!screenData.hideItemImage)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      screenData.itemStyledData.borderRadius,
                    ),
                    child: Image.asset(
                      'assets/images/placeholder-image.png',
                      fit: screenData.itemStyledData.imageBoxFit,
                    ),
                  ),
                const SizedBox(height: 5),
                Expanded(
                  child: Center(
                    child: Text(
                      'Category $i',
                      style: screenData.itemStyledData.textStyleData
                          .createTextStyle(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
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
  final AppCategoryScreenData screenData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return SectionLayoutDecorator(
            styledData: screenData.itemStyledData,
            forcedColor: theme.colorScheme.background,
            child: Row(
              children: [
                if (!screenData.hideItemImage)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      screenData.itemStyledData.borderRadius,
                    ),
                    child: Image.asset(
                      'assets/images/placeholder-image.png',
                      height: screenData.itemStyledData.dimensionsData.height,
                      width: screenData.itemStyledData.dimensionsData.width,
                      fit: screenData.itemStyledData.imageBoxFit,
                    ),
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Category $i',
                    style: screenData.itemStyledData.textStyleData
                        .createTextStyle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          );
        },
        childCount: 20,
      ),
    );
  }
}

// class _ListWithChild extends StatelessWidget {
//   const _ListWithChild({
//     Key? key,
//     required this.screenData,
//   }) : super(key: key);
//   final AppCategoryScreenData screenData;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
