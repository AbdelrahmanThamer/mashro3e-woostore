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

import '../../../../../generated/l10n.dart';
import '../../../../../themes/theme.dart';
import '../../../viewModel/productViewModel.dart';

/// Creates an animated container which shows on sale tags
/// according to the product view model's data
class OnSaleAnimatedContainer extends StatelessWidget {
  const OnSaleAnimatedContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Consumer<ProductViewModel>(
      builder: (context, provider, child) {
        double height = 0;
        EdgeInsets margin = const EdgeInsets.only(bottom: 0);

        // return if variation is in stock
        if (provider.selectedVariation != null) {
          if (provider.selectedVariation.onSale) {
            height = 38;
            margin = const EdgeInsets.only(bottom: 10);
          }
        } else {
          // return if there is no variation for the product
          if (provider.currentProduct.wooProduct.onSale) {
            height = 38;
            margin = const EdgeInsets.only(bottom: 10);
          }
        }

        return AnimatedContainer(
          height: height,
          margin: margin,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastLinearToSlowEaseIn,
          padding: ThemeGuide.padding10,
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: ThemeGuide.borderRadius,
          ),
          child: Text(
            lang.onSale,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 1200),
        curve: Curves.fastLinearToSlowEaseIn,
        builder: (context, anim, w) {
          return Transform.scale(
            scale: anim,
            child: w,
          );
        },
        child: Container(
          padding: ThemeGuide.padding10,
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: ThemeGuide.borderRadius,
          ),
          child: Text(
            lang.onSale,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
