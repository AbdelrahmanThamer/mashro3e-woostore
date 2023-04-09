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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as legacy;

import '../../app_builder/app_builder.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../providers/utils/viewStateController.dart';
import '../shared/app_bar/app_bar.dart';
import '../shared/decorator.dart';
import 'viewModel/view_model.dart';

AutoDisposeProvider<AppTagsScreenData> providerOfTagsScreenLayoutData =
    Provider.autoDispose<AppTagsScreenData>((ref) {
  return const AppTagsScreenData();
});

class TagsScreenLayout extends StatelessWidget {
  const TagsScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppTagsScreenData screenData;

  @override
  Widget build(BuildContext context) {
    providerOfTagsScreenLayoutData =
        Provider.autoDispose<AppTagsScreenData>((ref) {
      return screenData;
    });

    // If the data is available, then load the body directly
    // else create a ViewStateController to fetch the data
    final bool isDataAvailable = LocatorService.tagsViewModel().tags.isNotEmpty;

    return Scaffold(
      body: isDataAvailable
          ? const _Body()
          : legacy.ChangeNotifierProvider<TagsViewModel>.value(
              value: LocatorService.tagsViewModel(),
              child: const _BodyWithoutData(),
            ),
    );
  }
}

class _BodyWithoutData extends StatelessWidget {
  const _BodyWithoutData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateController<TagsViewModel>(
      fetchData: LocatorService.tagsViewModel().getTags,
      child: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenData = ref.read(providerOfTagsScreenLayoutData);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (screenData.appBarData.show)
          SliverAppBarLayout(
            data: screenData.appBarData,
            overrideTitle: S.of(context).tags,
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
    final list = LocatorService.tagsViewModel().tags;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenData.columns,
        childAspectRatio: screenData.itemStyledData.dimensionsData.aspectRatio,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return GestureDetector(
            onTap: () => ParseEngine.createAction(
              context: context,
              action: NavigateToAllProductsScreenAction(
                title: list[i].name ?? 'NA',
                tagData: TagData(
                  id: list[i].id ?? 0,
                  tagId: list[i].id?.toString() ?? '0',
                  title: list[i].name ?? 'NA',
                ),
              ),
            )?.call(),
            child: SectionLayoutDecorator(
              styledData: screenData.itemStyledData,
              forcedColor: theme.colorScheme.background,
              child: Center(
                child: Text(
                  list[i].name ?? 'NA',
                  style:
                      screenData.itemStyledData.textStyleData.createTextStyle(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          );
        },
        childCount: list.length,
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
    final list = LocatorService.tagsViewModel().tags;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return GestureDetector(
            onTap: () => ParseEngine.createAction(
              context: context,
              action: NavigateToAllProductsScreenAction(
                title: list[i].name ?? 'NA',
                tagData: TagData(
                  id: list[i].id ?? 0,
                  tagId: list[i].id?.toString() ?? '0',
                  title: list[i].name ?? 'NA',
                ),
              ),
            )?.call(),
            child: SectionLayoutDecorator(
              styledData: screenData.itemStyledData,
              forcedColor: theme.colorScheme.background,
              child: SizedBox(
                height: screenData.itemStyledData.dimensionsData.height,
                child: Center(
                  child: Text(
                    list[i].name ?? 'NA',
                    style: screenData.itemStyledData.textStyleData
                        .createTextStyle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ),
          );
        },
        childCount: list.length,
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
    final list = LocatorService.tagsViewModel().tags;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Wrap(
          children: List.generate(
            list.length,
            (i) => GestureDetector(
              onTap: () => ParseEngine.createAction(
                context: context,
                action: NavigateToAllProductsScreenAction(
                  title: list[i].name ?? 'NA',
                  tagData: TagData(
                    id: list[i].id ?? 0,
                    tagId: list[i].id?.toString() ?? '0',
                    title: list[i].name ?? 'NA',
                  ),
                ),
              )?.call(),
              child: SectionLayoutDecorator(
                styledData: screenData.itemStyledData,
                forcedColor: theme.colorScheme.background,
                child: Text(
                  list[i].name ?? 'NA',
                  style:
                      screenData.itemStyledData.textStyleData.createTextStyle(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
