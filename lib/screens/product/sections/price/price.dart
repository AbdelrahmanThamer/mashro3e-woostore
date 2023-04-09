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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';

import '../../../../app_builder/app_builder.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../../viewModel/productViewModel.dart';
import '../shared.dart';

class PSPriceSectionLayout extends StatelessWidget {
  const PSPriceSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSPriceSectionData data;

  @override
  Widget build(BuildContext context) {
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: _Body(data: data),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PSPriceSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;

    if (data.styledData.textStyleData.alignment == TextAlign.right) {
      mainAxisAlignment = MainAxisAlignment.end;
    }

    if (data.styledData.textStyleData.alignment == TextAlign.center) {
      mainAxisAlignment = MainAxisAlignment.center;
    }

    final lang = S.of(context);
    final _theme = Theme.of(context);
    final provider = ref.watch(providerOfProductViewModel);

    if (provider.noVariationFoundError != null) {
      return Text(lang.noVariationFound);
    }

    bool onSale = provider.currentProduct.wooProduct.onSale ?? false;
    String? price = onSale
        ? provider.currentProduct.wooProduct.salePrice
        : provider.currentProduct.wooProduct.regularPrice;
    String? regularPrice = provider.currentProduct.wooProduct.regularPrice;

    if (provider.selectedVariation != null) {
      price = provider.selectedVariation!.onSale ?? false
          ? provider.selectedVariation!.salePrice
          : provider.selectedVariation!.regularPrice;
      onSale = provider.selectedVariation!.onSale ?? false;
      regularPrice = provider.selectedVariation!.regularPrice;
    }

    String? discount;
    if (isNotBlank(price) && isNotBlank(regularPrice)) {
      discount = Utils.calculateDiscount(
        salePrice: price,
        regularPrice: regularPrice,
      );
    }

    const Widget loadingIndicator = LinearProgressIndicator(minHeight: 2);

    if (!onSale) {
      if (isNotBlank(price)) {
        return Text(
          Utils.formatPrice(price),
          style: data.styledData.textStyleData.createTextStyle(),
        );
      } else {
        return loadingIndicator;
      }
    } else {
      if (isNotBlank(price)) {
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              Utils.formatPrice(price),
              style: data.styledData.textStyleData.createTextStyle(),
            ),
            const SizedBox(width: 10),
            if (isNotBlank(regularPrice))
              Text(
                Utils.formatPrice(regularPrice),
                style: _theme.textTheme.bodyText2?.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            if (isNotBlank(discount)) const SizedBox(width: 10),
            if (isNotBlank(discount))
              Text(
                discount!,
                style: _theme.textTheme.bodyText2?.copyWith(
                  fontSize: 14,
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        );
      } else {
        return loadingIndicator;
      }
    }
  }
}
