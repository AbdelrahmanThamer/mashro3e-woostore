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

//**********************************************************
// Shared
//**********************************************************

import 'package:am_common_packages/am_common_packages.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as legacy;
import 'package:quiver/strings.dart';

import '../../../app_builder/app_builder.dart';
import '../../../controllers/navigationController.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../providers/products/products.provider.dart';
import '../../../shared/animatedButton.dart';
import '../../../shared/widgets/likedIcon/likedIcon.dart';
import '../../../themes/colors.dart';
import '../../../utils/utils.dart';
import 'product_card.dart';

class RatingBarLayout extends StatelessWidget {
  const RatingBarLayout({
    Key? key,
    required this.sectionData,
    this.averageRating,
    this.ratingCount,
  }) : super(key: key);

  final RatingSectionData sectionData;
  final String? averageRating;
  final int? ratingCount;

  @override
  Widget build(BuildContext context) {
    if (isBlank(averageRating) && ratingCount == null) {
      return const SizedBox();
    }
    return Padding(
      padding: EdgeInsets.only(
        left: sectionData.marginData.left,
        right: sectionData.marginData.right,
        top: sectionData.marginData.top,
        bottom: sectionData.marginData.bottom,
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: RatingBar.builder(
              ignoreGestures: true,
              glow: false,
              initialRating: double.tryParse(averageRating ?? '0') ?? 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: sectionData.textStyleData.fontSize,
              unratedColor: Colors.grey.withAlpha(100),
              itemBuilder: (__, _) => const Icon(
                EvaIcons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (_) {},
            ),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              '$averageRating ${ratingCount != null ? '($ratingCount)' : ''}',
              style: TextStyle(
                fontSize: sectionData.textStyleData.fontSize,
                fontWeight: TextStyleData.convertToFontWeight(
                  sectionData.textStyleData.fontWeight,
                ),
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LikeButtonLayout extends ConsumerWidget {
  const LikeButtonLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productData = ref.read(providerOfProductCardLayoutProductData);
    return GestureDetector(
      onTap: () =>
          LocatorService.productsProvider().toggleStatus(productData.id),
      child: legacy.Selector<ProductsProvider, bool>(
        selector: (context, d) => d.productsMap[productData.id]?.liked ?? false,
        builder: (context, isLiked, _) {
          return isLiked
              ? const LikedIcon()
              : const Icon(Icons.favorite_border);
        },
      ),
    );
  }
}

class ImageContainerLayout extends ConsumerWidget {
  const ImageContainerLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final ImageSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productData = ref.read(providerOfProductCardLayoutProductData);
    return ClipRRect(
      borderRadius: BorderRadius.circular(data.borderRadius),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ExtendedCachedImage(
          imageUrl: productData.displayImage,
          fit: data.boxFit,
        ),
      ),
    );
  }
}

class AddToCartButtonLayout extends ConsumerWidget {
  const AddToCartButtonLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productData = ref.read(providerOfProductCardLayoutProductData);
    return AnimButton(
      onTap: () async {
        // Check if the user is not present and guest checkout is disabled
        if (isBlank(LocatorService.userProvider().user.id)) {
          if (!ParseEngine.enabledGuestCheckout) {
            NavigationController.navigator.push(LoginFromXRoute(
              onSuccess: () {},
            ));
            return;
          }
        }

        // Add to cart if simple product
        if (productData.type == 'simple') {
          await LocatorService.cartViewModel().addToCart(productData.id);
        } else {
          NavigationController.navigator.push(
            ProductDetailsScreenLayoutRoute(id: productData.id),
          );
        }
      },
      child: Container(
        padding: ThemeGuide.padding5,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: ThemeGuide.borderRadius5,
        ),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

class RatingLayout extends ConsumerWidget {
  const RatingLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productData = ref.read(providerOfProductCardLayoutProductData);
    return Container(
      padding: ThemeGuide.padding5,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: ThemeGuide.borderRadius5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.star,
            color: Color(0xFFF9A825),
            size: 12,
          ),
          const SizedBox(width: 5),
          Text(
            productData.averageRating?.toString() ?? '0',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class DiscountStrip extends ConsumerWidget {
  const DiscountStrip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.read(providerOfProductCardLayoutProductData);
    if (!data.onSale) {
      return const SizedBox();
    }
    String? onSaleString = Utils.calculateDiscount(
      salePrice: data.price,
      regularPrice: data.regularPrice,
    );

    if (onSaleString == null || onSaleString.isEmpty) {
      onSaleString = S.of(context).onSale;
    }
    return Container(
      padding: ThemeGuide.padding5,
      decoration: BoxDecoration(
        color: ThemeGuide.isDarkMode(context)
            ? AppColors.productItemCardOnSaleBannerDark
            : AppColors.productItemCardOnSaleBanner,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Text(
        onSaleString,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}

class ProductNameLayout extends ConsumerWidget {
  const ProductNameLayout({
    Key? key,
    required this.sectionData,
    required this.name,
  }) : super(key: key);
  final NameSectionData sectionData;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        left: sectionData.marginData.left,
        right: sectionData.marginData.right,
        top: sectionData.marginData.top,
        bottom: sectionData.marginData.bottom,
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: sectionData.textStyleData.fontSize,
          fontWeight: TextStyleData.convertToFontWeight(
            sectionData.textStyleData.fontWeight,
          ),
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class PriceLayout extends StatelessWidget {
  const PriceLayout({
    Key? key,
    required this.sectionData,
    this.price,
    this.regularPrice,
  }) : super(key: key);
  final PriceSectionData sectionData;
  final String? price;
  final String? regularPrice;

  @override
  Widget build(BuildContext context) {
    if (isBlank(price) && isBlank(regularPrice)) {
      return const SizedBox();
    }

    Widget? priceWidget;

    if (isNotBlank(price)) {
      priceWidget = Text(
        '${ParseEngine.currencySymbol}$price',
        style: TextStyle(
          fontWeight: TextStyleData.convertToFontWeight(
            sectionData.textStyleData.fontWeight,
          ),
          fontSize: sectionData.textStyleData.fontSize,
        ),
      );
    }

    if (isNotBlank(regularPrice)) {
      if (priceWidget != null) {
        priceWidget = Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '${ParseEngine.currencySymbol}$price',
              style: TextStyle(
                fontWeight: TextStyleData.convertToFontWeight(
                  sectionData.textStyleData.fontWeight,
                ),
                fontSize: sectionData.textStyleData.fontSize,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                '${ParseEngine.currencySymbol}$regularPrice',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                  fontWeight: TextStyleData.convertToFontWeight(
                    sectionData.textStyleData.fontWeight,
                  ),
                  fontSize: sectionData.textStyleData.fontSize,
                ),
              ),
            ),
          ],
        );
      } else {
        priceWidget = Text(
          '${ParseEngine.currencySymbol}$regularPrice',
          style: TextStyle(
            fontWeight: TextStyleData.convertToFontWeight(
              sectionData.textStyleData.fontWeight,
            ),
            fontSize: sectionData.textStyleData.fontSize,
          ),
        );
      }
    }
    return Padding(
      padding: EdgeInsets.only(
        left: sectionData.marginData.left,
        right: sectionData.marginData.right,
        top: sectionData.marginData.top,
        bottom: sectionData.marginData.bottom,
      ),
      child: priceWidget,
    );
  }
}
