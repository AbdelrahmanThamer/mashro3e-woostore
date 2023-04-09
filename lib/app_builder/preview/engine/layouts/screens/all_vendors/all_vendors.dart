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
import '../../shared/vendor_card/vendor_card.dart';

class AllVendorsScreenLayout extends StatelessWidget {
  const AllVendorsScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppAllVendorsScreenData screenData;

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
              overrideTitle: 'All Vendors',
            ),
          if (screenData.itemListConfig.listType == ItemListType.grid)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100, left: 10, right: 10),
              sliver: _Grid(screenData: screenData),
            ),
          if (screenData.itemListConfig.listType == ItemListType.list)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100, left: 10, right: 10),
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
  final AppAllVendorsScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenData.itemListConfig.gridColumns,
        childAspectRatio: screenData.itemListConfig.aspectRatio,
        crossAxisSpacing: screenData.itemListConfig.itemPadding,
        mainAxisSpacing: screenData.itemListConfig.itemPadding,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return _ItemCard(layoutData: screenData.vendorCardLayoutData);
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
  final AppAllVendorsScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: screenData.itemListConfig.itemPadding,
            ),
            child: _ItemCard(layoutData: screenData.vendorCardLayoutData),
          );
        },
        childCount: 5,
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    Key? key,
    required this.layoutData,
  }) : super(key: key);

  final VendorCardLayoutData layoutData;

  @override
  Widget build(BuildContext context) {
    return VendorCardLayout(layoutData: layoutData);
  }
}
