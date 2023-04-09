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

import '../../../../../models/app_template/app_template.dart';
import '../../app_bar/app_bar.dart';
import 'coupon_settings.dart';

class CartScreenLayout extends StatelessWidget {
  const CartScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppCartScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBarLayout(
              overrideTitle: 'Cart',
              data: screenData.appBarData,
            ),
            const SliverToBoxAdapter(child: _TestCartProduct()),
            const SliverToBoxAdapter(child: _TestCartProduct()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            if (screenData.enableCoupon)
              SliverToBoxAdapter(
                child: CouponLayout(layout: screenData.couponData.layout),
              ),
            if (screenData.enableCustomerNote)
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            if (screenData.enableCustomerNote)
              SliverToBoxAdapter(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Customer Note'),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

class _TestCartProduct extends StatelessWidget {
  const _TestCartProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: ThemeGuide.borderRadius10,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/placeholder-image.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Product Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Quantity: 1',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 5),
                Text(
                  'Size: X',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 5),
                Text(
                  'Color: Red',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
