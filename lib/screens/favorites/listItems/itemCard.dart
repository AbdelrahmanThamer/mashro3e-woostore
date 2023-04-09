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

import '../../../controllers/navigationController.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../utils/utils.dart';
import '../buttons/buttons.dart';
import '../models/favoriteProduct.model.dart';

class FavoriteItemCard extends StatelessWidget {
  const FavoriteItemCard({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final ThemeData theme = Theme.of(context);
    final FavoriteProduct? favoriteProduct =
        LocatorService.productsProvider().favoriteProductsMap[productId];
    if (favoriteProduct == null) {
      return Center(child: Text(lang.somethingWentWrong));
    }
    return GestureDetector(
      onTap: _navigateToProductScreen,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: ThemeGuide.borderRadius,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: ExtendedCachedImage(
                      imageUrl: favoriteProduct.displayImage,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  child: Text(
                    favoriteProduct.name ?? 'NA',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: FittedBox(
                    child: Text(
                      Utils.formatPrice(favoriteProduct.price),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: ThemeGuide.borderRadius,
                ),
                child: FIRemoveButton(
                  productId: productId,
                  iconSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProductScreen() {
    NavigationController.navigator
        .push(ProductDetailsScreenLayoutRoute(id: productId));
  }
}
