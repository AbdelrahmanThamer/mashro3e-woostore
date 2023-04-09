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
import 'package:woocommerce/models/coupon.dart';

import '../../../../../app_builder/app_builder.dart';
import '../../../../../locator.dart';
import '../../../../../themes/theme.dart';

class AppliedCoupon extends StatelessWidget {
  const AppliedCoupon({Key key, this.coupon})
      : showRemoveButton = true,
        super(key: key);

  const AppliedCoupon.withoutRemoveButton({Key key, this.coupon})
      : showRemoveButton = false,
        super(key: key);
  final WooCoupon coupon;
  final bool showRemoveButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: showRemoveButton ? ThemeGuide.padding10 : ThemeGuide.padding20,
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor.withAlpha(10),
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  _BuildDiscountContainer(coupon: coupon),
                  const SizedBox(width: 10),
                  const Text(
                    '|',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      coupon.code?.toUpperCase() ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showRemoveButton) const SizedBox(width: 10),
          if (showRemoveButton)
            IconButton(
              onPressed: LocatorService.cartViewModel().clearCoupon,
              icon: const Icon(Icons.clear, color: Colors.red),
            ),
        ],
      ),
    );
  }
}

class _BuildDiscountContainer extends StatelessWidget {
  const _BuildDiscountContainer({Key key, this.coupon}) : super(key: key);
  final WooCoupon coupon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (coupon.couponType == WooCouponType.percentDiscount) {
      return Text(
        '${coupon.amount} %',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
      );
    } else {
      return Text(
        '${ParseEngine.currencySymbol} ${coupon.amount}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: theme.colorScheme.primary,
        ),
      );
    }
  }
}
