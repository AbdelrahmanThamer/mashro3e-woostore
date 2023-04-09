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

import '../../generated/l10n.dart';

class StockStatusBuilder extends StatelessWidget {
  const StockStatusBuilder({Key? key, required this.inStock, this.textStyle})
      : super(key: key);

  final bool inStock;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    if (inStock) {
      return Text(
        S.of(context).inStock,
        style: textStyle ??
            const TextStyle(
              color: Color(0xFF388E3C),
              fontWeight: FontWeight.bold,
            ),
      );
    } else {
      return Text(
        S.of(context).outOfStock,
        style: textStyle ??
            const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
      );
    }
  }
}
