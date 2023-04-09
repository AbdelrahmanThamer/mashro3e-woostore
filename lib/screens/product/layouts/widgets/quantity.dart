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

import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../providers/products/products.provider.dart';
import '../../../../shared/widgets/quantityButtons/quantityButtons.dart';
import 'shared/subHeading.dart';

class Quantity extends StatelessWidget {
  const Quantity({Key key, this.productId}) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(child: SubHeading(title: S.of(context).quantity)),
        const Spacer(),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              QuantityButtonNegative(
                productId: productId,
                onPressed:
                    LocatorService.productsProvider().decreaseProductQuantity,
              ),
              Selector<ProductsProvider, int>(
                selector: (context, d) => d.productsMap[productId].quantity,
                builder: (context, quantity, _) {
                  return Text(
                    '$quantity',
                    style: _theme.textTheme.subtitle1,
                  );
                },
              ),
              QuantityButtonPositive(
                productId: productId,
                onPressed:
                    LocatorService.productsProvider().increaseProductQuantity,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
