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
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../../models/app_template/app_template.dart';
import '../../app_bar/app_bar.dart';
import '../dynamic/sections/shared/decorator.dart';

class BlogScreenLayout extends StatelessWidget {
  const BlogScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppBlogScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (screenData.appBarData.show)
            SliverAppBarLayout(
              data: screenData.appBarData,
              overrideTitle: 'Blog',
            ),
          if (screenData.layout == BlogScreenLayoutType.grid)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100),
              sliver: _Grid(screenData: screenData),
            ),
          if (screenData.layout == BlogScreenLayoutType.list)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100),
              sliver: _VerticalList(screenData: screenData),
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
  final AppBlogScreenData screenData;

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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: screenData.columns == 1
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Blog Title $i',
                          style: screenData.itemStyledData.textStyleData
                              .createTextStyle(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                theme.colorScheme.primary.withAlpha(50),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Category',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'May 15, 2022',
                          style: theme.textTheme.caption,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: screenData.columns == 1
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                          children: const [
                            Icon(
                              LineAwesomeIcons.alternate_feather,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Admin',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
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
  final AppBlogScreenData screenData;

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Blog Title $i',
                          style: screenData.itemStyledData.textStyleData
                              .createTextStyle(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                theme.colorScheme.primary.withAlpha(50),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Category',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'May 15, 2022',
                          style: theme.textTheme.caption,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: const [
                            Icon(
                              LineAwesomeIcons.alternate_feather,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Admin',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
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
