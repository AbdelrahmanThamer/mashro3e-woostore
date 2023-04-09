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

import '../../../../../models/app_template/app_template.dart';
import '../../app_bar/app_bar.dart';
import '../../shared/product_card/product_card.dart';

class WishlistScreenLayout extends StatelessWidget {
  const WishlistScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppWishlistScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (screenData.appBarData.show)
            SliverAppBarLayout(
              data: screenData.appBarData,
              overrideTitle: 'Wishlist',
            ),
          if (screenData.productListConfig.listType == ProductListType.grid)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100),
              sliver: _Grid(screenData: screenData),
            ),
          if (screenData.productListConfig.listType == ProductListType.list)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100),
              sliver: _VerticalList(screenData: screenData),
            ),
        ],
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppWishlistScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenData.productListConfig.gridColumns,
        childAspectRatio:
            screenData.productListConfig.layoutData.getAspectRatio(),
        crossAxisSpacing: screenData.productListConfig.itemPadding,
        mainAxisSpacing: screenData.productListConfig.itemPadding,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return ProductCardLayout(
            layoutData: screenData.productListConfig.layoutData,
          );
        },
        childCount: 5,
      ),
    );
  }
}

class _VerticalList extends StatelessWidget {
  const _VerticalList({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppWishlistScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: screenData.productListConfig.itemPadding,
            ),
            child: ProductCardLayout(
              layoutData: screenData.productListConfig.layoutData,
            ),
          );
        },
        childCount: 5,
      ),
    );
  }
}
