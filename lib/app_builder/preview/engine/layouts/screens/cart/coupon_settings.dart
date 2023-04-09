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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../models/models.dart';

class CouponLayout extends StatelessWidget {
  const CouponLayout({
    Key? key,
    this.layout = CartCouponLayout.original,
  }) : super(key: key);
  final CartCouponLayout layout;

  @override
  Widget build(BuildContext context) {
    if (layout == CartCouponLayout.textField) {
      return const CouponTextFieldTile();
    }

    return const CouponDefaultTile();
  }
}

/// The cart coupon layout
class CouponDefaultTile extends StatelessWidget {
  const CouponDefaultTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: ThemeGuide.padding5,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: ListTile(
        horizontalTitleGap: 0,
        leading: Icon(
          FontAwesomeIcons.certificate,
          color: theme.colorScheme.primary,
        ),
        title: const Text(
          'Apply Coupon',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      ),
    );
  }
}

class CouponTextFieldTile extends StatelessWidget {
  const CouponTextFieldTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            children: const [
              Flexible(
                child: Text(
                  'Coupon',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Flexible(
                child: TextButton(
                  child: Text('See All'),
                  onPressed: seeAll,
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

  static void seeAll() {}
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Coupon Code',
              fillColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        const SizedBox(width: 10),
        GradientButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Apply',
              style: TextStyle(color: Colors.white),
            ),
          ),
          onPress: () {},
        ),
      ],
    );
  }
}
