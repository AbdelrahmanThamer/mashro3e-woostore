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

import '../../../../app_builder/app_builder.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../models/models.dart';
import '../../../shared/product_card/product_card.dart';
import '../../viewModel/productViewModel.dart';
import '../shared.dart';

class PSLinkedProductsSectionLayout extends ConsumerWidget {
  const PSLinkedProductsSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSLinkedProductsSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = 'More Products';
    List<int> productIds = const [];
    final lang = S.of(context);
    final product = ref.read(providerOfProductViewModel).currentProduct;
    if (data.runtimeType == PSRelatedProductsSectionData) {
      title = lang.related;
      if (product.wooProduct.relatedIds != null &&
          product.wooProduct.relatedIds!.isNotEmpty) {
        productIds = product.wooProduct.relatedIds!;
      }
    }

    if (data.runtimeType == PSUpSellProductsSectionData) {
      title = lang.youMayAlsoLike;
      if (product.wooProduct.upsellIds != null &&
          product.wooProduct.upsellIds!.isNotEmpty) {
        productIds = product.wooProduct.upsellIds!;
      }
    }

    if (data.runtimeType == PSCrossSellProductsSectionData) {
      title = lang.frequentlyBoughtTogether;
      if (product.wooProduct.crossSellIds != null &&
          product.wooProduct.crossSellIds!.isNotEmpty) {
        productIds = product.wooProduct.crossSellIds!;
      }
    }

    return _Body(
      productIds: productIds,
      title: title,
      data: data,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.productIds,
    required this.title,
    required this.data,
  }) : super(key: key);

  final List<int> productIds;
  final PSLinkedProductsSectionData data;
  final String title;

  /// Fetch the products from the server
  Future<List<Product>> _fetchProducts() async {
    try {
      final List<Product>? result =
          await LocatorService.productsProvider().fetchProductsById(
        productIds,
        shouldCheckInCache: true,
      );

      if (result != null && result.isNotEmpty) {
        return result;
      } else {
        return Future.error('Either value is empty or null');
      }
    } catch (e, s) {
      Dev.error('Fetch Linked Products error', error: e, stackTrace: s);
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (productIds.isEmpty) {
      return const SizedBox();
    }
    return FutureBuilder<List<Product>>(
      future: _fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SizedBox();
        }

        if (snapshot.hasData) {
          final list = snapshot.data;
          if (list == null || list.isEmpty) {
            return const SizedBox();
          }

          Widget listWidget = _HorizontalList(data: data, list: list);

          if (data.productListConfig.listType == ProductListType.grid) {
            listWidget = _GridList(data: data, list: list);
          }
          if (data.productListConfig.listType == ProductListType.verticalList) {
            listWidget = _VerticalList(data: data, list: list);
          }

          Widget widget = const SizedBox();

          if (isNotBlank(title)) {
            widget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                listWidget,
              ],
            );
          } else {
            widget = listWidget;
          }

          return PSStyledContainerLayout(
            styledData: data.styledData,
            child: widget,
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _HorizontalList extends StatelessWidget {
  const _HorizontalList({
    Key? key,
    required this.data,
    required this.list,
  }) : super(key: key);
  final List<Product> list;
  final PSLinkedProductsSectionData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: data.productListConfig.layoutData.height + 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(right: data.productListConfig.itemPadding),
            child: ProductCardLayout(
              layoutData: data.productListConfig.layoutData,
              productId: list[i].id,
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}

class _GridList extends StatelessWidget {
  const _GridList({
    Key? key,
    required this.data,
    required this.list,
  }) : super(key: key);

  final List<Product> list;
  final PSLinkedProductsSectionData data;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: data.productListConfig.layoutData.getAspectRatio(),
      crossAxisSpacing: data.productListConfig.itemPadding,
      mainAxisSpacing: data.productListConfig.itemPadding,
      crossAxisCount: data.productListConfig.gridColumns,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        list.length,
        (i) {
          return ProductCardLayout(
            layoutData: data.productListConfig.layoutData,
            productId: list[i].id,
          );
        },
      ),
    );
  }
}

class _VerticalList extends StatelessWidget {
  const _VerticalList({
    Key? key,
    required this.data,
    required this.list,
  }) : super(key: key);

  final List<Product> list;
  final PSLinkedProductsSectionData data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return Padding(
          padding: EdgeInsets.only(bottom: data.productListConfig.itemPadding),
          child: ProductCardLayout(
            layoutData: data.productListConfig.layoutData,
            productId: list[i].id,
          ),
        );
      },
      itemCount: list.length,
    );
  }
}
