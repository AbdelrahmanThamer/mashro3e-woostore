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
import 'package:woocommerce/models/product_category.dart';

import '../../../app_builder/app_builder.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../shared/customLoader.dart';
import '../../../shared/widgets/error/errorReload.dart';
import 'layouts/layouts.dart';
import 'shared/decorator.dart';

class CategoriesSectionLayout extends StatelessWidget {
  const CategoriesSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final CategoriesSectionData data;

  @override
  Widget build(BuildContext context) {
    if (data.showAll) {
      return _BodyWithoutData(data: data);
    }
    return _Body(data: data, list: data.categories);
  }
}

class _BodyWithoutData extends ConsumerWidget {
  const _BodyWithoutData({
    Key? key,
    required this.data,
  }) : super(key: key);
  final CategoriesSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(providerOfCategoriesSectionNotifier(data));

    if (state.status == CategoriesSectionStatus.undefined) {
      return const SliverToBoxAdapter(child: SizedBox());
    }

    if (state.status == CategoriesSectionStatus.loading) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CustomLoader(),
        ),
      );
    }

    if (state.status == CategoriesSectionStatus.error) {
      return SliverToBoxAdapter(
        child: ErrorReload(
          errorMessage: state.errorMessage ?? S.of(context).somethingWentWrong,
          reloadFunction: ref
              .read(providerOfCategoriesSectionNotifier(data).notifier)
              .fetchCategories,
        ),
      );
    }

    if (state.status == CategoriesSectionStatus.noData) {
      Dev.warn('No data available');
      return const SliverToBoxAdapter(child: SizedBox());
    }

    final tempList = state.categoryList;
    final list = <CategoryData>[];
    for (final o in tempList) {
      if (o.id == null || o.id is! int || o.id == 0) {
        continue;
      }
      list.add(CategoryData(
        id: o.id!,
        categoryId: o.id!.toString(),
        imageUrl: o.image?.src ?? '',
        title: o.name ?? '',
      ));
    }
    return _Body(data: data, list: list);
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.data,
    required this.list,
  }) : super(key: key);
  final CategoriesSectionData data;
  final List<CategoryData> list;

  @override
  Widget build(BuildContext context) {
    Widget listWidget = SliverToBoxAdapter(
      child: HorizontalListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.itemDimensionsData,
        itemBuilder: (context, i) {
          return SizedBox(
            width: data.itemDimensionsData.width,
            height: data.itemDimensionsData.height,
            child: _ItemCard(sectionData: data, itemData: list[i]),
          );
        },
      ),
    );

    if (data.layout == CategorySectionLayoutType.verticalList) {
      listWidget = VerticalListSectionLayout(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return SizedBox(
            width: double.infinity,
            height: data.itemDimensionsData.height,
            child: _ItemCard(sectionData: data, itemData: list[i]),
          );
        },
      );
    }

    if (data.layout == CategorySectionLayoutType.grid) {
      listWidget = GridListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.itemDimensionsData,
        columns: data.columns,
        spacing: 0,
        itemBuilder: (context, i) {
          return AspectRatio(
            aspectRatio: data.itemDimensionsData.aspectRatio,
            child: _ItemCard(sectionData: data, itemData: list[i]),
          );
        },
      );
    }

    if (data.layout == CategorySectionLayoutType.wrap) {
      listWidget = SliverToBoxAdapter(
        child: Wrap(
          children: list
              .map<Widget>((e) => SizedBox(
                    width: data.itemDimensionsData.width,
                    height: data.itemDimensionsData.height,
                    child: _ItemCard(sectionData: data, itemData: e),
                  ))
              .toList(),
        ),
      );
    }

    return SliverSectionLayoutDecorator(
      styledData: data.styledData,
      sliver: listWidget,
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    Key? key,
    required this.sectionData,
    required this.itemData,
  }) : super(key: key);

  final CategoriesSectionData sectionData;
  final CategoryData itemData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: NavigateToAllProductsScreenAction(
          title: itemData.title,
          categoryData: itemData,
        ),
      )?.call(),
      child: Container(
        padding: sectionData.itemStyledData.paddingData.createEdgeInsets(),
        margin: sectionData.itemStyledData.marginData.createEdgeInsets(),
        decoration: BoxDecoration(
          color: HexColor.fromHex(
            sectionData.itemStyledData.backgroundColor,
            Theme.of(context).colorScheme.background,
          ),
          borderRadius:
              BorderRadius.circular(sectionData.itemStyledData.borderRadius),
        ),
        child: sectionData.showLabel
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: ExtendedCachedImage(
                        imageUrl: itemData.imageUrl,
                        borderRadius: BorderRadius.circular(
                          sectionData.itemStyledData.borderRadius,
                        ),
                        fit: sectionData.itemStyledData.imageBoxFit,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      itemData.title,
                      style: sectionData.itemStyledData.textStyleData
                          .createTextStyle(
                        forcedColor:
                            Theme.of(context).textTheme.bodyText2?.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              )
            : ExtendedCachedImage(
                imageUrl: itemData.imageUrl,
                borderRadius: BorderRadius.circular(
                  sectionData.itemStyledData.borderRadius,
                ),
                fit: sectionData.itemStyledData.imageBoxFit,
              ),
      ),
    );
  }
}

final providerOfCategoriesSectionNotifier = StateNotifierProvider.autoDispose
    .family<CategoriesSectionNotifier, CategoriesSectionState,
        CategoriesSectionData>((ref, sectionData) {
  ref.maintainState = true;
  return CategoriesSectionNotifier(sectionData);
});

class CategoriesSectionNotifier extends StateNotifier<CategoriesSectionState> {
  CategoriesSectionNotifier(
    this.sectionData,
  ) : super(const CategoriesSectionState()) {
    fetchCategories();
  }

  final CategoriesSectionData sectionData;

  Future<void> fetchCategories() async {
    try {
      state = state.copyWith(status: CategoriesSectionStatus.loading);

      // Fetch data from backend
      final List<WooProductCategory>? result =
          await LocatorService.wooService().getCategories(
        include: !sectionData.showAll
            ? sectionData.categories
                .map((e) => int.tryParse(e.categoryId) ?? 0)
                .toList()
                .cast<int>()
            : null,
      );

      if (result == null || result.isEmpty) {
        if (state.categoryList.isNotEmpty) {
          state = state.copyWith(status: CategoriesSectionStatus.hasData);
        } else {
          state = state.copyWith(status: CategoriesSectionStatus.noData);
        }
      }

      if (result!.isNotEmpty) {
        state = state.copyWith(
          categoryList: result,
          status: CategoriesSectionStatus.hasData,
        );
      }
    } catch (e, s) {
      Dev.error(
        'Fetch  Dynamic Section  State Notifier',
        error: e,
        stackTrace: s,
      );
      state = state.copyWith(
        status: CategoriesSectionStatus.error,
        errorMessage: ExceptionUtils.renderException(e),
      );
    }
  }
}

@immutable
class CategoriesSectionState {
  final List<WooProductCategory> categoryList;
  final CategoriesSectionStatus status;
  final String? errorMessage;

  const CategoriesSectionState({
    this.categoryList = const [],
    this.status = CategoriesSectionStatus.undefined,
    this.errorMessage,
  });

  CategoriesSectionState copyWith({
    List<WooProductCategory>? categoryList,
    CategoriesSectionStatus? status,
    String? errorMessage,
  }) {
    return CategoriesSectionState(
      categoryList: categoryList ?? this.categoryList,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

enum CategoriesSectionStatus {
  loading,
  hasData,
  noData,
  error,
  undefined,
}
