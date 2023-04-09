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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../locator.dart';
import '../../../coupons/coupons.dart';

class CouponTextFieldTile extends StatelessWidget {
  const CouponTextFieldTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
        top: 6,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  lang.coupon,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: () {
                    // Navigate to the Coupon Screen
                    Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const CouponsScreen(),
                    ));
                  },
                  child: Text(lang.seeAll),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _Body(),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: LocatorService.cartViewModel().couponTextController,
            focusNode: LocatorService.cartViewModel().couponFocusNode,
            decoration: InputDecoration(
              hintText: lang.coupon,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ValueListenableBuilder<bool>(
          valueListenable: LocatorService.cartViewModel().couponLoadingNotifier,
          builder: (context, isLoading, w) {
            if (isLoading) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child:
                    SpinKitCircle(color: Theme.of(context).colorScheme.primary),
              );
            } else {
              return w;
            }
          },
          child: GradientButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                lang.apply,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onPress: () => _applyCoupon(context),
          ),
        ),
      ],
    );
  }

  Future<void> _applyCoupon(BuildContext context) async {
    await LocatorService.cartViewModel().applyCoupon(context);
  }
}
