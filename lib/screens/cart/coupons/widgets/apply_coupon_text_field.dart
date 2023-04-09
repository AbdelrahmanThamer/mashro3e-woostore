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
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../locator.dart';

class CouponTextFieldTile extends StatefulWidget {
  const CouponTextFieldTile({Key key}) : super(key: key);

  @override
  State<CouponTextFieldTile> createState() => _CouponTextFieldTileState();
}

class _CouponTextFieldTileState extends State<CouponTextFieldTile> {
  bool isLoading = false;

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
        if (isLoading)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SpinKitCircle(color: Theme.of(context).colorScheme.primary),
          )
        else
          GradientButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                lang.apply,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onPress: () => _applyCoupon(context),
          ),
      ],
    );
  }

  Future<void> _applyCoupon(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await LocatorService.cartViewModel().applyCoupon(context);
      setState(() {
        isLoading = false;
      });
      if (result == true) {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      }
    } catch (e, s) {
      setState(() {
        isLoading = false;
      });
      Dev.error(
        'ApplyCoupon from coupon screen text field',
        error: e,
        stackTrace: s,
      );
    }
  }
}
