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
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';

import '../../../app_builder/app_builder.dart';
import '../../../locator.dart';
import '../../../models/recent_product.dart';
import '../../shared/product_card/product_card.dart';
import 'layouts/layouts.dart';
import 'shared/decorator.dart';
import 'shared/section_title.dart';

class RecentProductsSectionLayout extends StatelessWidget {
  const RecentProductsSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final RecentProductsSectionData data;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecentProduct>>(
      future: _getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (isNotBlank(data.title)) {
            return SliverSectionLayoutDecorator(
              styledData: data.styledData,
              sliver: MultiSliver(
                children: [
                  SectionTitle(title: data.title),
                  ValueListenableBuilder<UnmodifiableListView<RecentProduct>>(
                    valueListenable:
                        LocatorService.productsRepository().recentProductsList,
                    builder: (context, list, _) {
                      return _ProductsContainer(data: data, list: list);
                    },
                  )
                ],
              ),
            );
          }

          return SliverSectionLayoutDecorator(
            styledData: data.styledData,
            sliver: ValueListenableBuilder<UnmodifiableListView<RecentProduct>>(
              valueListenable:
                  LocatorService.productsRepository().recentProductsList,
              builder: (context, list, _) {
                return _ProductsContainer(data: data, list: list);
              },
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }

  Future<List<RecentProduct>> _getProducts() async {
    try {
      final result =
          await LocatorService.productsRepository().getRecentProducts();
      return result;
    } catch (e, s) {
      Dev.error(
        '_getProducts recent products container',
        error: e,
        stackTrace: s,
      );
      return Future.error(ExceptionUtils.renderException(e));
    }
  }
}

class _ProductsContainer extends ConsumerWidget {
  const _ProductsContainer({
    Key? key,
    required this.data,
    required this.list,
  }) : super(key: key);
  final RecentProductsSectionData data;
  final List<RecentProduct> list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productCardLayoutData = data.productCardLayoutData;
    if (data.useGlobalProductCardLayout) {
      productCardLayoutData =
          ref.read(providerOfAppTemplateState).template.globalProductCardLayout;
    }

    productCardLayoutData = modifyLayoutData(productCardLayoutData);

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
              productData: ProductCardLayoutProductData(
                id: list[i].id,
                name: list[i].name,
                displayImage: list[i].displayImage,
              ),
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
              productData: ProductCardLayoutProductData(
                id: list[i].id,
                name: list[i].name,
                displayImage: list[i].displayImage,
              ),
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
            productData: ProductCardLayoutProductData(
              id: list[i].id,
              name: list[i].name,
              displayImage: list[i].displayImage,
            ),
          );
        },
      );
    }
    return listWidget;
  }

  ProductCardLayoutData modifyLayoutData(ProductCardLayoutData originalData) {
    var result = originalData;
    final isd = result.sections.firstWhere(
            (element) => element.sectionType == ProductCardSectionType.image)
        as ImageSectionData;
    final nsd = result.sections.firstWhere(
            (element) => element.sectionType == ProductCardSectionType.name)
        as NameSectionData;
    double height = originalData.height;
    if (originalData.layoutType == ProductCardLayoutType.vertical) {
      height = isd.height +
          nsd.marginData.top +
          nsd.marginData.bottom +
          nsd.textStyleData.fontSize +
          40;
    }

    result = result.copyWith(
      height: height,
      sections: [
        isd.copyWith(
          showLikeButton: false,
          showRating: false,
          showAddToCartButton: false,
        ),
        nsd,
      ],
    );
    return result;
  }
}
