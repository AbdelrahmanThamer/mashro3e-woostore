// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../locator.dart';
import '../../../../../providers/products/products.provider.dart';
import '../../../../../shared/animatedButton.dart';
import '../../../../../shared/widgets/likedIcon/likedIcon.dart';
import '../../../../../themes/theme.dart';
import '../../../../../utils/style.dart';

class ProductLikeButton extends StatelessWidget {
  const ProductLikeButton({
    Key key,
    this.productId,
  }) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    return AnimButton(
      onTap: () {
        LocatorService.productsProvider().toggleStatus(productId);
      },
      child: Container(
        padding: ThemeGuide.padding10,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: ThemeGuide.borderRadius,
          boxShadow: UIStyle.renderShadow(
            context: context,
            light: ThemeGuide.darkShadow,
            dark: ThemeGuide.primaryShadowDark,
          ),
        ),
        child: Selector<ProductsProvider, bool>(
          selector: (context, d) => d.productsMap[productId].liked,
          builder: (context, liked, _) {
            return liked
                ? const LikedIcon()
                : const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  );
          },
        ),
      ),
    );
  }
}
