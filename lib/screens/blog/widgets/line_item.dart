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
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quiver/strings.dart';

import '../../../app_builder/app_builder.dart';
import '../../../models/models.dart';
import '../../shared/decorator.dart';
import '../view_model/view_model.dart';

class BlogGridListItem extends StatelessWidget {
  const BlogGridListItem({
    Key? key,
    required this.screenData,
    required this.blogData,
  }) : super(key: key);
  final AppBlogScreenData screenData;
  final WordpressPost blogData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              child: ExtendedCachedImage(
                imageUrl: blogData.displayImage,
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
                    blogData.title,
                    style: screenData.itemStyledData.textStyleData
                        .createTextStyle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  if (blogData.categories.isNotEmpty &&
                      isNotBlank(blogData.categories.first.name))
                    const SizedBox(height: 10),
                  if (blogData.categories.isNotEmpty &&
                      isNotBlank(blogData.categories.first.name))
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            theme.colorScheme.primary.withAlpha(50),
                      ),
                      onPressed: () => ParseEngine.createAction(
                        context: context,
                        action: NavigationAction(
                          navigationData: NavigationData(
                            screenId: screenData.id,
                            screenName: screenData.name,
                          ),
                          arguments: {
                            'filter': BlogFilter(
                              categories: [blogData.categories.first.id],
                            ),
                          },
                        ),
                      )?.call(),
                      child: Text(
                        blogData.categories.first.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  if (isNotBlank(blogData.date)) const SizedBox(height: 10),
                  if (isNotBlank(blogData.date))
                    Text(
                      blogData.date!,
                      style: theme.textTheme.caption,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  if (isNotBlank(blogData.author)) const SizedBox(height: 15),
                  if (isNotBlank(blogData.author))
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: screenData.columns == 1
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        const Icon(
                          LineAwesomeIcons.alternate_feather,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          blogData.author!,
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
  }
}

class BlogVerticalListItem extends StatelessWidget {
  const BlogVerticalListItem({
    Key? key,
    required this.screenData,
    required this.blogData,
  }) : super(key: key);
  final AppBlogScreenData screenData;
  final WordpressPost blogData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SectionLayoutDecorator(
      styledData: screenData.itemStyledData,
      forcedColor: theme.colorScheme.background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!screenData.hideItemImage)
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  screenData.itemStyledData.borderRadius,
                ),
                child: ExtendedCachedImage(
                  imageUrl: blogData.displayImage,
                  fit: screenData.itemStyledData.imageBoxFit,
                ),
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
                    blogData.title,
                    style: screenData.itemStyledData.textStyleData
                        .createTextStyle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  if (blogData.categories.isNotEmpty &&
                      isNotBlank(blogData.categories.first.name))
                    const SizedBox(height: 10),
                  if (blogData.categories.isNotEmpty &&
                      isNotBlank(blogData.categories.first.name))
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            theme.colorScheme.primary.withAlpha(50),
                      ),
                      onPressed: () => ParseEngine.createAction(
                        context: context,
                        action: NavigationAction(
                          navigationData: NavigationData(
                            screenId: screenData.id,
                            screenName: screenData.name,
                          ),
                          arguments: {
                            'filter': BlogFilter(
                              categories: [blogData.categories.first.id],
                            ),
                          },
                        ),
                      )?.call(),
                      child: Text(
                        blogData.categories.first.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  if (isNotBlank(blogData.date)) const SizedBox(height: 10),
                  if (isNotBlank(blogData.date))
                    Text(
                      blogData.date!,
                      style: theme.textTheme.caption,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  if (isNotBlank(blogData.author)) const SizedBox(height: 15),
                  if (isNotBlank(blogData.author))
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          LineAwesomeIcons.alternate_feather,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          blogData.author!,
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
  }
}
