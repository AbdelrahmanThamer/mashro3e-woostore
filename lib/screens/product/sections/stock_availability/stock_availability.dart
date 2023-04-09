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

import '../../../../app_builder/app_builder.dart';
import '../../../../generated/l10n.dart';
import '../../viewModel/productViewModel.dart';
import '../shared.dart';

class PSStockAvailabilitySectionLayout extends StatelessWidget {
  const PSStockAvailabilitySectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSStockAvailabilitySectionData data;

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

  final PSStockAvailabilitySectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = S.of(context);
    final provider = ref.watch(providerOfProductViewModel);
    final variation = provider.selectedVariation;
    final currentProduct = provider.currentProduct;
    if (variation == null) {
      if (currentProduct.inStock) {
        int stockQuantity = 0;

        if (currentProduct.wooProduct.stockQuantity != null) {
          stockQuantity = currentProduct.wooProduct.stockQuantity!;
        }

        return stockQuantity > 0
            ? Text(
                '${lang.inStock} ( $stockQuantity )',
                style: data.styledData.textStyleData
                    .createTextStyle()
                    .copyWith(color: Colors.green),
                textAlign: data.styledData.textStyleData.alignment,
              )
            : Text(
                lang.inStock,
                style: data.styledData.textStyleData
                    .createTextStyle()
                    .copyWith(color: Colors.green),
                textAlign: data.styledData.textStyleData.alignment,
              );
      } else {
        return Text(
          lang.outOfStock,
          style: data.styledData.textStyleData
              .createTextStyle()
              .copyWith(color: Colors.red),
          textAlign: data.styledData.textStyleData.alignment,
        );
      }
    }

    // Renders a widget whose variation is out of stock
    final outOfStockWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lang.outOfStock,
          style: data.styledData.textStyleData
              .createTextStyle()
              .copyWith(color: Colors.red),
          textAlign: data.styledData.textStyleData.alignment,
        ),
        const SizedBox(height: 5),
        Text(
          lang.outOfStockMessage,
          style: const TextStyle(
            color: Color(0xFFa1a1a1),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    if (variation.stockStatus == 'instock') {
      return Text(
        '${lang.inStock} ( ${variation.stockQuantity} )',
        style: data.styledData.textStyleData
            .createTextStyle()
            .copyWith(color: Colors.green),
        textAlign: data.styledData.textStyleData.alignment,
      );
    } else {
      return outOfStockWidget;
    }
  }
}
