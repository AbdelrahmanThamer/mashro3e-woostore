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

// @dart=2.9

import 'package:am_common_packages/am_common_packages.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../controllers/navigationController.dart';
import '../controllers/uiController.dart';
import '../locator.dart';
import '../models/models.dart';
import '../providers/products/products.provider.dart';
import '../themes/colors.dart';
import '../themes/themeGuide.dart' as legacy;
import '../utils/utils.dart';
import 'animatedButton.dart';
import 'widgets/likedIcon/likedIcon.dart';

/// ## `Description`
///
/// Item card is the widget which shows the information
/// about the product.
class ItemCard extends StatelessWidget {
  const ItemCard({
    Key key,
    @required this.productId,
  }) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final product = LocatorService.productsProvider().productsMap[productId];
    if (_isEmptyProduct(product)) {
      return const SizedBox();
    }
    return AspectRatio(
      aspectRatio: legacy.ThemeGuide.productItemCardAspectRatio,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: _theme.colorScheme.background,
          borderRadius: ThemeGuide.borderRadius,
        ),
        child: (product?.wooProduct?.onSale ?? false)
            ? Stack(
                children: [
                  _Body(product: product),
                  Positioned(
                    top: 15,
                    child: _DiscountStrip(
                      regularPrice: product.wooProduct.regularPrice,
                      salePrice: product.wooProduct.salePrice,
                    ),
                  ),
                ],
              )
            : _Body(product: product),
      ),
    );
  }

  /// Checks if the product is empty or not
  bool _isEmptyProduct(Product product) {
    if (product == null ||
        product.id == null ||
        product.id.isEmpty ||
        product.wooProduct == null ||
        product.wooProduct.id == null) {
      return true;
    }
    return false;
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key key,
    @required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: () {
              NavigationController.navigator.push(
                ProductDetailsScreenLayoutRoute(id: product.id),
              );
            },
            child: Container(
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _ItemImage(displayImage: product.displayImage),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: AnimButton(
                      onTap: () {
                        // Add to cart if simple product
                        if (product.wooProduct.type == 'simple') {
                          LocatorService.cartViewModel().addToCart(product.id);
                          UiController.itemAddedNotification(context: context);
                        } else {
                          NavigationController.navigator.push(
                            ProductDetailsScreenLayoutRoute(id: product.id),
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 35,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          product.wooProduct.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: GestureDetector(
                          onTap: () {
                            LocatorService.productsProvider()
                                .toggleStatus(product.id);
                          },
                          child: Selector<ProductsProvider, bool>(
                            selector: (context, d) =>
                                d.productsMap[product.id].liked,
                            builder: (context, isLiked, _) {
                              return isLiked
                                  ? const LikedIcon()
                                  : const Icon(Icons.favorite_border);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          Utils.formatPrice(product.wooProduct.price),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    if ((product?.wooProduct?.onSale ?? false) &&
                        product.wooProduct.regularPrice.isNotEmpty)
                      const SizedBox(width: 8),
                    if ((product?.wooProduct?.onSale ?? false) &&
                        product.wooProduct.regularPrice.isNotEmpty)
                      Flexible(
                        child: FittedBox(
                          child: Text(
                            Utils.formatPrice(product.wooProduct.regularPrice),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                if (product.wooProduct.averageRating != null &&
                    product.wooProduct.averageRating.isNotEmpty)
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          child: FittedBox(
                            child: RatingBar.builder(
                              ignoreGestures: true,
                              glow: false,
                              initialRating: double.tryParse(
                                      product.wooProduct.averageRating) ??
                                  0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              unratedColor: Colors.grey.withAlpha(100),
                              itemBuilder: (__, _) => const Icon(
                                EvaIcons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: null,
                            ),
                          ),
                        ),
                        const Flexible(child: SizedBox(width: 4)),
                        Flexible(
                          child: FittedBox(
                            child: Text(
                              '${product.wooProduct.averageRating} ${product.wooProduct.ratingCount != null ? '(${product.wooProduct.ratingCount})' : ''}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DiscountStrip extends StatelessWidget {
  const _DiscountStrip({
    Key key,
    this.regularPrice,
    this.salePrice,
  }) : super(key: key);
  final String regularPrice;
  final String salePrice;

  @override
  Widget build(BuildContext context) {
    String onSaleString = Utils.calculateDiscount(
      salePrice: salePrice,
      regularPrice: regularPrice,
    );

    if (onSaleString == null || onSaleString.isEmpty) {
      onSaleString = 'On Sale!';
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

/// Renders the image for the item.
class _ItemImage extends StatelessWidget {
  const _ItemImage({
    Key key,
    this.displayImage,
  }) : super(key: key);

  final String displayImage;

  @override
  Widget build(BuildContext context) {
    return ExtendedCachedImage(
      imageUrl: displayImage,
      borderRadius: ThemeGuide.borderRadius,
    );
  }
}
