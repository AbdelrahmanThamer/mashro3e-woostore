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

import '../../../locator.dart';

///
/// ## `Description`
///
/// Creates the `Remove` (from cart) button for the favorites list item.
///
class FIRemoveButton extends StatelessWidget {
  const FIRemoveButton({
    Key? key,
    required this.productId,
    this.iconSize = 26,
    this.icon,
  }) : super(key: key);
  final String productId;
  final double iconSize;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: icon ??
          Icon(
            Icons.close_rounded,
            color: _theme.errorColor,
            size: iconSize,
          ),
      onPressed: _removeItem,
    );
  }

  void _removeItem() {
    LocatorService.productsProvider().toggleStatus(
      productId,
      status: false,
    );
  }
}
