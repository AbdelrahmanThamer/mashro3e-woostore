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
import 'package:provider/provider.dart' as legacy;

import '../../app_builder/app_builder.dart';
import '../../controllers/navigationController.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../providers/utils/viewStateController.dart';
import '../../shared/widgets/error/noDataAvailable.dart';
import '../shared/app_bar/app_bar.dart';
import '../shared/decorator.dart';
import 'viewModel/categories.provider.dart';

AutoDisposeProvider<AppCategoryScreenData>
    providerOfCategoriesScreenLayoutData =
    Provider.autoDispose<AppCategoryScreenData>((ref) {
  return const AppCategoryScreenData();
});

class CategoriesScreenLayout extends StatelessWidget {
  const CategoriesScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);

  final AppCategoryScreenData screenData;

  @override
  Widget build(BuildContext context) {
    providerOfCategoriesScreenLayoutData =
        Provider.autoDispose<AppCategoryScreenData>((ref) {
      return screenData;
    });
    return Scaffold(
      body: legacy.ChangeNotifierProvider<CategoriesProvider>.value(
        value: LocatorService.categoriesProvider(),
        child: const _Body(),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenData = ref.read(providerOfCategoriesScreenLayoutData);
    final bool isDataAvailable =
        LocatorService.categoriesProvider().categoriesMap.isNotEmpty;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (screenData.appBarData.show)
          SliverAppBarLayout(
            data: screenData.appBarData,
            overrideTitle: S.of(context).categories,
          ),
        SliverViewStateController<CategoriesProvider>(
          fetchData: LocatorService.categoriesProvider().getCategories,
          isDataAvailable: isDataAvailable,
          builder: () {
            if (screenData.layout == CategoriesScreenLayoutType.grid) {
              return SliverPadding(
                padding: const EdgeInsets.only(bottom: 100),
                sliver: _Grid(screenData: screenData),
              );
            }
            return SliverPadding(
              padding: const EdgeInsets.only(bottom: 100),
              sliver: _VerticalList(screenData: screenData),
            );
          },
        )
      ],
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
    final list = LocatorService.categoriesProvider().getCategoriesAsModels();
    if (list.isEmpty) {
      return const SliverToBoxAdapter(child: NoDataAvailableImage());
    }
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenData.columns,
        childAspectRatio: screenData.itemStyledData.dimensionsData.aspectRatio,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          final model = list[i];
          return GestureDetector(
            onTap: () {
              NavigationController.navigator.push(
                CategorisedProductsRoute(
                  category: model.parentCategory!,
                  childrenCategoryList: model.childrenCategories ?? const [],
                ),
              );
            },
            child: SectionLayoutDecorator(
              styledData: screenData.itemStyledData,
              forcedColor: theme.colorScheme.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!screenData.hideItemImage)
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          screenData.itemStyledData.borderRadius,
                        ),
                        child: ExtendedCachedImage(
                          imageUrl: model.parentCategory?.image?.src,
                          fit: screenData.itemStyledData.imageBoxFit,
                        ),
                      ),
                    ),
                  const SizedBox(height: 5),
                  Flexible(
                    child: Center(
                      child: Text(
                        model.parentCategory?.name ?? '',
                        style: screenData.itemStyledData.textStyleData
                            .createTextStyle(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
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
  final AppCategoryScreenData screenData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final list = LocatorService.categoriesProvider().getCategoriesAsModels();
    if (list.isEmpty) {
      return const SliverToBoxAdapter(child: NoDataAvailableImage());
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          final model = list[i];
          return GestureDetector(
            onTap: () {
              NavigationController.navigator.push(
                CategorisedProductsRoute(
                  category: model.parentCategory!,
                  childrenCategoryList: model.childrenCategories ?? const [],
                ),
              );
            },
            child: SectionLayoutDecorator(
              styledData: screenData.itemStyledData,
              forcedColor: theme.colorScheme.background,
              child: Row(
                children: [
                  if (!screenData.hideItemImage)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        screenData.itemStyledData.borderRadius,
                      ),
                      child: SizedBox(
                        height: screenData.itemStyledData.dimensionsData.height,
                        width: screenData.itemStyledData.dimensionsData.width,
                        child: ExtendedCachedImage(
                          imageUrl: model.parentCategory?.image?.src,
                          fit: screenData.itemStyledData.imageBoxFit,
                        ),
                      ),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      model.parentCategory?.name ?? '',
                      style: screenData.itemStyledData.textStyleData
                          .createTextStyle(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: list.length,
      ),
    );
  }
}
