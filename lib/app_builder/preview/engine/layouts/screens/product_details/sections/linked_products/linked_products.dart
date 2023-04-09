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

import '../../../../../../../models/app_template/app_template.dart';
import '../../../../shared/product_card/product_card.dart';
import '../shared.dart';

class PSLinkedProductsSectionLayout extends StatelessWidget {
  const PSLinkedProductsSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSLinkedProductsSectionData data;

  @override
  Widget build(BuildContext context) {
    String title = 'More Products';

    if (data.runtimeType == PSRelatedProductsSectionData) {
      title = 'Related Products';
    }

    if (data.runtimeType == PSUpSellProductsSectionData) {
      title = 'Up Sell Products';
    }

    if (data.runtimeType == PSCrossSellProductsSectionData) {
      title = 'Cross Sell Products';
    }
    Widget w = _HorizontalList(data: data);

    if (data.productListConfig.listType == ProductListType.grid) {
      w = _GridList(data: data);
    }
    if (data.productListConfig.listType == ProductListType.verticalList) {
      w = _VerticalList(data: data);
    }
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          w,
        ],
      ),
    );
  }
}

class _HorizontalList extends StatelessWidget {
  const _HorizontalList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PSLinkedProductsSectionData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: data.productListConfig.layoutData.height + 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(right: data.productListConfig.itemPadding),
            child: ProductCardLayout(
              layoutData: data.productListConfig.layoutData,
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}

class _GridList extends StatelessWidget {
  const _GridList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PSLinkedProductsSectionData data;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: data.productListConfig.layoutData.getAspectRatio(),
      crossAxisSpacing: data.productListConfig.itemPadding,
      mainAxisSpacing: data.productListConfig.itemPadding,
      crossAxisCount: data.productListConfig.gridColumns,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        5,
        (i) {
          return ProductCardLayout(
            layoutData: data.productListConfig.layoutData,
          );
        },
      ),
    );
  }
}

class _VerticalList extends StatelessWidget {
  const _VerticalList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PSLinkedProductsSectionData data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return Padding(
          padding: EdgeInsets.only(bottom: data.productListConfig.itemPadding),
          child: ProductCardLayout(
            layoutData: data.productListConfig.layoutData,
          ),
        );
      },
      itemCount: 5,
    );
  }
}
