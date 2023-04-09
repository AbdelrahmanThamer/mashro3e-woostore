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
import '../../../models/models.dart';
import 'model.dart';
import 'shared.dart';

export 'model.dart';

final providerOfProductCardLayoutProductData =
    StateProvider.autoDispose<ProductCardLayoutProductData>(
  (ref) => const ProductCardLayoutProductData(
    id: '0',
    name: '',
    displayImage: '',
  ),
);

class ProductCardLayout extends StatelessWidget {
  const ProductCardLayout({
    Key? key,
    required this.layoutData,
    this.productId,
    this.productData,
  })  : assert(
          productId != null || productData != null,
          'Both productId and productData cannot be empty',
        ),
        super(key: key);
  final ProductCardLayoutData layoutData;
  final String? productId;
  final ProductCardLayoutProductData? productData;

  @override
  Widget build(BuildContext context) {
    final product = LocatorService.productsProvider().productsMap[productId];
    if (productData == null && _isEmptyProduct(product)) {
      return const SizedBox();
    }
    Widget main = _VerticalLayout(productCardLayoutData: layoutData);
    if (layoutData.layoutType == ProductCardLayoutType.vertical) {
      main = _VerticalLayout(productCardLayoutData: layoutData);
    }
    if (layoutData.layoutType == ProductCardLayoutType.horizontal) {
      main = _HorizontalLayout(productCardLayoutData: layoutData);
    }

    final ProductCardLayoutProductData data = productData ??
        ProductCardLayoutProductData(
          id: product!.id,
          name: product.wooProduct.name ?? 'NA',
          displayImage: product.displayImage,
          averageRating: product.wooProduct.averageRating,
          ratingCount: product.wooProduct.ratingCount,
          price: product.wooProduct.price,
          regularPrice: product.wooProduct.regularPrice,
          type: product.wooProduct.type,
          onSale: product.wooProduct.onSale ?? false,
        );

    return GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: NavigateToSingleProductScreenAction(
          productData: ProductData(
            id: data.id,
            name: data.name,
            imageUrl: data.displayImage,
          ),
        ),
      )?.call(),
      child: ProviderScope(
        overrides: [
          providerOfProductCardLayoutProductData.overrideWithValue(
              StateController<ProductCardLayoutProductData>(data)),
        ],
        child: main,
      ),
    );
  }

  /// Checks if the product is empty or not
  bool _isEmptyProduct(Product? product) {
    if (product == null ||
        product.id.isEmpty ||
        product.wooProduct.id == null) {
      return true;
    }
    return false;
  }
}

class _VerticalLayout extends ConsumerWidget {
  const _VerticalLayout({
    Key? key,
    this.productCardLayoutData = const ProductCardLayoutData(),
  }) : super(key: key);
  final ProductCardLayoutData productCardLayoutData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productData = ref.read(providerOfProductCardLayoutProductData);
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(productCardLayoutData.borderRadius),
      child: Container(
        height: productCardLayoutData.height,
        width: productCardLayoutData.width,
        decoration: BoxDecoration(color: theme.colorScheme.background),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: productCardLayoutData.sections.map((e) {
            if (e.sectionType == ProductCardSectionType.image) {
              return buildImageSection(
                isd: e as ImageSectionData,
                theme: theme,
                productData: productData,
              );
            }
            if (e.sectionType == ProductCardSectionType.name) {
              return ProductNameLayout(
                sectionData: e as NameSectionData,
                name: productData.name,
              );
            }
            if (e.sectionType == ProductCardSectionType.price) {
              return PriceLayout(
                sectionData: e as PriceSectionData,
                price: productData.price,
                regularPrice: productData.regularPrice,
              );
            }
            if (e.sectionType == ProductCardSectionType.rating) {
              if (isBlank(productData.averageRating) &&
                  productData.ratingCount == null) {
                return const SizedBox();
              }
              return Flexible(
                child: RatingBarLayout(
                  sectionData: e as RatingSectionData,
                  averageRating: productData.averageRating,
                  ratingCount: productData.ratingCount,
                ),
              );
            }
            return const SizedBox();
          }).toList(),
        ),
      ),
    );
  }

  Widget buildImageSection({
    required ImageSectionData isd,
    required ThemeData theme,
    required ProductCardLayoutProductData productData,
  }) {
    return SizedBox(
      height: isd.height,
      child: Stack(
        children: [
          ImageContainerLayout(data: isd),
          if (productData.onSale)
            Positioned(
              top: isd.height * 0.08,
              child: const DiscountStrip(),
            ),
          if (isd.showRating)
            const Positioned(
              bottom: 10,
              left: 10,
              child: RatingLayout(),
            ),
          if (!isd.showLikeButton && !isd.showAddToCartButton)
            const SizedBox()
          else
            Positioned(
              right: 10,
              bottom: 10,
              child: Column(
                children: [
                  if (isd.showLikeButton)
                    Container(
                      padding: ThemeGuide.padding5,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.background,
                        borderRadius: ThemeGuide.borderRadius5,
                      ),
                      child: const LikeButtonLayout(),
                    ),
                  if (isd.showAddToCartButton) const SizedBox(height: 5),
                  if (isd.showAddToCartButton) const AddToCartButtonLayout(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _HorizontalLayout extends ConsumerWidget {
  const _HorizontalLayout({
    Key? key,
    this.productCardLayoutData = const ProductCardLayoutData.horizontal(),
  }) : super(key: key);
  final ProductCardLayoutData productCardLayoutData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productData = ref.read(providerOfProductCardLayoutProductData);
    final theme = Theme.of(context);
    final ImageSectionData? isd = productCardLayoutData.sections
            .firstWhereOrNull((element) =>
                element.sectionType == ProductCardSectionType.image)
        as ImageSectionData?;

    final NameSectionData? nsd = productCardLayoutData.sections
            .firstWhereOrNull(
                (element) => element.sectionType == ProductCardSectionType.name)
        as NameSectionData?;

    final PriceSectionData? psd = productCardLayoutData.sections
            .firstWhereOrNull((element) =>
                element.sectionType == ProductCardSectionType.price)
        as PriceSectionData?;

    final RatingSectionData? rsd = productCardLayoutData.sections
            .firstWhereOrNull((element) =>
                element.sectionType == ProductCardSectionType.rating)
        as RatingSectionData?;

    return ClipRRect(
      borderRadius: BorderRadius.circular(productCardLayoutData.borderRadius),
      child: Container(
        height: productCardLayoutData.height,
        width: productCardLayoutData.width,
        decoration: BoxDecoration(color: theme.colorScheme.background),
        child: Row(
          children: [
            if (isd != null)
              SizedBox(
                width: isd.width,
                child: productData.onSale
                    ? Stack(
                        children: [
                          ImageContainerLayout(data: isd),
                          Positioned(
                            top: isd.height * 0.15,
                            child: const DiscountStrip(),
                          ),
                        ],
                      )
                    : ImageContainerLayout(data: isd),
              ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (nsd != null)
                      ProductNameLayout(
                        sectionData: nsd,
                        name: productData.name,
                      ),
                    if (psd != null)
                      PriceLayout(
                        sectionData: psd,
                        price: productData.price,
                        regularPrice: productData.regularPrice,
                      ),
                    if (rsd != null)
                      RatingBarLayout(
                        sectionData: rsd,
                        averageRating: productData.averageRating,
                        ratingCount: productData.ratingCount,
                      ),
                  ],
                ),
              ),
            ),
            if (isd != null)
              if (isd.showLikeButton || isd.showAddToCartButton)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      if (isd.showLikeButton) const LikeButtonLayout(),
                      if (isd.showAddToCartButton) const SizedBox(height: 5),
                      if (isd.showAddToCartButton)
                        const AddToCartButtonLayout(),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
