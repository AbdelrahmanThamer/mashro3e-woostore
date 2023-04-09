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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';

import '../../app_builder/app_builder.dart';
import '../../generated/l10n.dart';
import '../../shared/html_view.dart';
import '../blog/view_model/view_model.dart';
import '../shared/app_bar/app_bar.dart';
import 'state.dart';

class SinglePostScreenLayout extends StatelessWidget {
  const SinglePostScreenLayout({Key? key, required this.screenData})
      : super(key: key);
  final AppSinglePostScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (screenData.appBarData.show)
            SliverAppBarLayout(data: screenData.appBarData),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 100),
            sliver: SliverToBoxAdapter(child: _Post(screenData: screenData)),
          ),
        ],
      ),
    );
  }
}

class _Post extends ConsumerWidget {
  const _Post({Key? key, required this.screenData}) : super(key: key);
  final AppSinglePostScreenData screenData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(providerOfSinglePostState(screenData.postId));
    if (state.status == SinglePostStateStatus.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (state.status == SinglePostStateStatus.error) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: Center(
          child: Text(
            state.errorMessage ?? S.of(context).somethingWentWrong,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (state.status == SinglePostStateStatus.hasData) {
      final post = state.post!;
      final theme = Theme.of(context);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isNotBlank(post.title))
            Padding(
              padding: ThemeGuide.padding10,
              child: Text(
                post.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          if (isNotBlank(post.displayImage))
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
              width: double.infinity,
              child: ExtendedCachedImage(imageUrl: post.displayImage),
            ),
          if (isNotBlank(post.author))
            Padding(
              padding: ThemeGuide.padding10,
              child: Text(post.author!),
            ),
          if (isNotBlank(post.content))
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: HtmlCustomView(htmlText: post.content),
            ),
          if (post.tags.isNotEmpty) const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              borderRadius: ThemeGuide.borderRadius10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).tags,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: post.tags
                        .map(
                          (e) => TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    theme.colorScheme.primary.withAlpha(50)),
                            child: Text(e.name ?? 'NA'),
                            onPressed: () => ParseEngine.createAction(
                              context: context,
                              action: NavigationAction(
                                navigationData: const NavigationData(
                                  screenId: AppPrebuiltScreensId.blogs,
                                  screenName: AppPrebuiltScreensNames.blogs,
                                ),
                                arguments: {
                                  'filter': BlogFilter(tags: [e.id]),
                                },
                              ),
                            )?.call(),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          if (post.categories.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: ThemeGuide.borderRadius10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).categories,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: post.categories
                          .map(
                            (e) => TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    theme.colorScheme.primary.withAlpha(50),
                              ),
                              child: Text(e.name ?? 'NA'),
                              onPressed: () => ParseEngine.createAction(
                                context: context,
                                action: NavigationAction(
                                  navigationData: const NavigationData(
                                    screenId: AppPrebuiltScreensId.blogs,
                                    screenName: AppPrebuiltScreensNames.blogs,
                                  ),
                                  arguments: {
                                    'filter': BlogFilter(categories: [e.id]),
                                  },
                                ),
                              )?.call(),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    }
    return const SizedBox();
  }
}
