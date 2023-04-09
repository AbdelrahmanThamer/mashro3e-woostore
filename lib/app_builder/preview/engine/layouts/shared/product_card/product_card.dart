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

import '../../../../../models/app_template/app_screen_data/shared/product_card_layout/product_card_layout.dart';
import '../../../../../models/app_template/app_screen_data/shared/text_style_data.dart';
import 'shared.dart';

class ProductCardLayout extends StatelessWidget {
  const ProductCardLayout({
    Key? key,
    required this.layoutData,
  }) : super(key: key);
  final ProductCardLayoutData layoutData;

  @override
  Widget build(BuildContext context) {
    if (layoutData.layoutType == ProductCardLayoutType.vertical) {
      return _VerticalLayout(productCardLayoutData: layoutData);
    }
    if (layoutData.layoutType == ProductCardLayoutType.horizontal) {
      return _HorizontalLayout(productCardLayoutData: layoutData);
    }
    return const _VerticalLayout();
  }
}

class _VerticalLayout extends StatelessWidget {
  const _VerticalLayout({
    Key? key,
    this.productCardLayoutData = const ProductCardLayoutData(),
  }) : super(key: key);
  final ProductCardLayoutData productCardLayoutData;

  @override
  Widget build(BuildContext context) {
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
              return buildImageSection(e as ImageSectionData, theme);
            }
            if (e.sectionType == ProductCardSectionType.name) {
              return buildNameSection(e as NameSectionData);
            }
            if (e.sectionType == ProductCardSectionType.price) {
              return buildPriceSection(e as PriceSectionData);
            }
            if (e.sectionType == ProductCardSectionType.rating) {
              return buildRatingSection(e as RatingSectionData);
            }
            return const SizedBox();
          }).toList(),
        ),
      ),
    );
  }

  Widget buildImageSection(ImageSectionData isd, ThemeData theme) {
    return SizedBox(
      height: isd.height,
      child: Stack(
        children: [
          ImageContainerLayout(data: isd),
          if (isd.showRating)
            const Positioned(
              bottom: 10,
              left: 10,
              child: RatingLayout(ratingCount: '4.22'),
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

  Widget buildNameSection(NameSectionData nsd) {
    return Padding(
      padding: EdgeInsets.only(
        left: nsd.marginData.left,
        right: nsd.marginData.right,
        top: nsd.marginData.top,
        bottom: nsd.marginData.bottom,
      ),
      child: Text(
        'Product Name',
        style: TextStyle(
          fontSize: nsd.textStyleData.fontSize,
          fontWeight: TextStyleData.convertToFontWeight(
            nsd.textStyleData.fontWeight,
          ),
        ),
      ),
    );
  }

  Widget buildPriceSection(PriceSectionData psd) {
    return Padding(
      padding: EdgeInsets.only(
        left: psd.marginData.left,
        right: psd.marginData.right,
        top: psd.marginData.top,
        bottom: psd.marginData.bottom,
      ),
      child: Row(
        children: [
          Text(
            '\$100',
            style: TextStyle(
              fontWeight: TextStyleData.convertToFontWeight(
                psd.textStyleData.fontWeight,
              ),
              fontSize: psd.textStyleData.fontSize,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              '\$300',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
                fontWeight: TextStyleData.convertToFontWeight(
                  psd.textStyleData.fontWeight,
                ),
                fontSize: psd.textStyleData.fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRatingSection(RatingSectionData rsd) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(
          left: rsd.marginData.left,
          right: rsd.marginData.right,
          top: rsd.marginData.top,
          bottom: rsd.marginData.bottom,
        ),
        child: RatingBarLayout(
          size: rsd.textStyleData.fontSize,
          fontWeight: TextStyleData.convertToFontWeight(
            rsd.textStyleData.fontWeight,
          ),
        ),
      ),
    );
  }
}

class _HorizontalLayout extends StatelessWidget {
  const _HorizontalLayout({
    Key? key,
    this.productCardLayoutData = const ProductCardLayoutData.horizontal(),
  }) : super(key: key);
  final ProductCardLayoutData productCardLayoutData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ImageSectionData isd = productCardLayoutData.sections.firstWhere(
            (element) => element.sectionType == ProductCardSectionType.image)
        as ImageSectionData;

    final NameSectionData nsd = productCardLayoutData.sections.firstWhere(
            (element) => element.sectionType == ProductCardSectionType.name)
        as NameSectionData;

    final PriceSectionData psd = productCardLayoutData.sections.firstWhere(
            (element) => element.sectionType == ProductCardSectionType.price)
        as PriceSectionData;

    final RatingSectionData rsd = productCardLayoutData.sections.firstWhere(
            (element) => element.sectionType == ProductCardSectionType.rating)
        as RatingSectionData;

    return ClipRRect(
      borderRadius: BorderRadius.circular(productCardLayoutData.borderRadius),
      child: Container(
        height: productCardLayoutData.height,
        width: productCardLayoutData.width,
        decoration: BoxDecoration(color: theme.colorScheme.background),
        child: Row(
          children: [
            SizedBox(
              width: isd.width,
              child: ImageContainerLayout(data: isd),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: nsd.marginData.left,
                        right: nsd.marginData.right,
                        top: nsd.marginData.top,
                        bottom: nsd.marginData.bottom,
                      ),
                      child: Text(
                        'Product Name',
                        style: TextStyle(
                          fontSize: nsd.textStyleData.fontSize,
                          fontWeight: TextStyleData.convertToFontWeight(
                            nsd.textStyleData.fontWeight,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: psd.marginData.left,
                        right: psd.marginData.right,
                        top: psd.marginData.top,
                        bottom: psd.marginData.bottom,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '\$100',
                            style: TextStyle(
                              fontWeight: TextStyleData.convertToFontWeight(
                                psd.textStyleData.fontWeight,
                              ),
                              fontSize: psd.textStyleData.fontSize,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              '\$300',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: TextStyleData.convertToFontWeight(
                                  psd.textStyleData.fontWeight,
                                ),
                                fontSize: psd.textStyleData.fontSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: rsd.marginData.left,
                        right: rsd.marginData.right,
                        top: rsd.marginData.top,
                        bottom: rsd.marginData.bottom,
                      ),
                      child: RatingBarLayout(
                        size: rsd.textStyleData.fontSize,
                        fontWeight: TextStyleData.convertToFontWeight(
                          rsd.textStyleData.fontWeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isd.showLikeButton || isd.showAddToCartButton)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    if (isd.showLikeButton) const LikeButtonLayout(),
                    if (isd.showAddToCartButton) const SizedBox(height: 5),
                    if (isd.showAddToCartButton) const AddToCartButtonLayout(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
