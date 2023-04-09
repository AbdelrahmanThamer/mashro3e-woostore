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
import 'package:provider/provider.dart' as legacy;
import 'package:quiver/strings.dart';

import '../../../../app_builder/app_builder.dart';
import '../../../../locator.dart';
import '../../../../providers/products/products.provider.dart';
import '../../viewModel/productViewModel.dart';
import '../shared.dart';

class PSQuantitySectionLayout extends ConsumerWidget {
  const PSQuantitySectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSQuantitySectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.read(providerOfProductViewModel).currentProduct;
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: Row(
        children: [
          Text(
            'Quantity',
            style: data.styledData.textStyleData.createTextStyle(),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => LocatorService.productsProvider()
                .decreaseProductQuantity(product.id),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: SizedBox(
              width: 70,
              child: legacy.Selector<ProductsProvider, int>(
                selector: (context, d) => d.productsMap[product.id]!.quantity,
                builder: (context, quantity, _) {
                  final c = TextEditingController(
                    text: quantity.toString(),
                  );
                  return TextFormField(
                    controller: c,
                    enabled: !(product.wooProduct.soldIndividually ?? false),
                    textAlign: TextAlign.center,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: false,
                    ),
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      if (isBlank(c.text)) {
                        product.setQuantity = 1;
                        return;
                      }

                      final int? intValue = int.tryParse(c.text);
                      if (intValue == null || intValue == 0) {
                        product.setQuantity = 1;
                      } else {
                        product.setQuantity = intValue;
                      }
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () => LocatorService.productsProvider()
                .increaseProductQuantity(product.id),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
