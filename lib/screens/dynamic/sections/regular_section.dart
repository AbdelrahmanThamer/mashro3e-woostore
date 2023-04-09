// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

import '../../../app_builder/app_builder.dart';
import '../../../generated/l10n.dart';
import '../../../shared/customLoader.dart';
import '../../../shared/widgets/error/errorReload.dart';
import '../../../shared/widgets/error/noDataAvailable.dart';
import '../../shared/product_card/product_card.dart';
import '../state.dart';
import 'layouts/layouts.dart';
import 'shared/decorator.dart';
import 'shared/section_title.dart';

class RegularSectionLayout extends StatelessWidget {
  const RegularSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final RegularSectionData data;

  @override
  Widget build(BuildContext context) {
    if (isNotBlank(data.title) || data.enableShowAllButton) {
      return SliverSectionLayoutDecorator(
        styledData: data.styledData,
        sliver: MultiSliver(
          children: [
            SectionTitle(
              title: data.title,
              showAllButton: data.enableShowAllButton,
              showAllButtonOnPressed: () => ParseEngine.createAction(
                context: context,
                action: NavigateToAllProductsScreenAction(
                  title: data.title ?? '',
                  tagData: data.loadProductsConfigData.tag,
                  categoryData: data.loadProductsConfigData.category,
                ),
              )?.call(),
            ),
            _ProductsContainer(data: data),
          ],
        ),
      );
    }

    return SliverSectionLayoutDecorator(
      styledData: data.styledData,
      sliver: _ProductsContainer(data: data),
    );
  }
}

class _ProductsContainer extends ConsumerWidget {
  const _ProductsContainer({
    Key? key,
    required this.data,
  }) : super(key: key);
  final RegularSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(providerOfDynamicSectionProductsNotifier(
      data.loadProductsConfigData,
    ));

    if (state.status == DynamicSectionStatus.undefined) {
      return const SliverToBoxAdapter(child: SizedBox());
    }

    if (state.status == DynamicSectionStatus.loading) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CustomLoader(),
        ),
      );
    }

    if (state.status == DynamicSectionStatus.error) {
      return SliverToBoxAdapter(
        child: ErrorReload(
          errorMessage: state.errorMessage ?? S.of(context).somethingWentWrong,
          reloadFunction: ref
              .read(
                providerOfDynamicSectionProductsNotifier(
                  data.loadProductsConfigData,
                ).notifier,
              )
              .fetchProducts,
        ),
      );
    }

    if (state.status == DynamicSectionStatus.noData) {
      Dev.warn('No data available for ${data.title}');
      return const SliverToBoxAdapter(child: NoDataAvailable());
    }

    final list = state.productsList.toList();

    var productCardLayoutData = data.productCardLayoutData;
    if (data.useGlobalProductCardLayout) {
      productCardLayoutData =
          ref.read(providerOfAppTemplateState).template.globalProductCardLayout;
    }

    Widget listWidget = SliverToBoxAdapter(
      child: HorizontalListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: DimensionsData(
          height: productCardLayoutData.height,
          width: productCardLayoutData.width,
        ),
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: data.itemPadding),
            child: ProductCardLayout(
              layoutData: productCardLayoutData,
              productId: list[i],
            ),
          );
        },
      ),
    );

    if (data.layout == SectionLayout.verticalList) {
      listWidget = VerticalListSectionLayout(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(bottom: data.itemPadding),
            child: ProductCardLayout(
              layoutData: productCardLayoutData,
              productId: list[i],
            ),
          );
        },
      );
    }

    if (data.layout == SectionLayout.grid) {
      listWidget = GridListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: DimensionsData(
          height: productCardLayoutData.height,
          width: productCardLayoutData.width,
          aspectRatio: productCardLayoutData.getAspectRatio(),
        ),
        columns: data.columns,
        spacing: data.itemPadding,
        aspectRatio: productCardLayoutData.getAspectRatio(),
        itemBuilder: (context, i) {
          return ProductCardLayout(
            layoutData: productCardLayoutData,
            productId: list[i],
          );
        },
      );
    }

    return listWidget;
  }
}
