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

import '../../../../../../models/models.dart';
import '../../../../engine.dart';
import 'layouts/layouts.dart';
import 'shared/decorator.dart';

class AdvancedPromotionSectionLayout extends StatelessWidget {
  const AdvancedPromotionSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final AdvancedPromotionSectionData data;

  @override
  Widget build(BuildContext context) {
    final list = data.items;
    Widget listWidget = SliverToBoxAdapter(
      child: HorizontalListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.itemDimensionsData,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: data.itemPadding),
            child: SizedBox(
              width: data.itemDimensionsData.width,
              child: _ItemCard(sectionData: data, itemData: list[i]),
            ),
          );
        },
      ),
    );

    if (data.layout == SectionLayout.verticalList) {
      listWidget = VerticalListSectionLayout(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(bottom: data.itemPadding),
            child: SizedBox(
              height: data.itemDimensionsData.height,
              child: _ItemCard(sectionData: data, itemData: list[i]),
            ),
          );
        },
      );
    }

    if (data.layout == SectionLayout.grid) {
      listWidget = GridListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.itemDimensionsData,
        columns: data.columns,
        spacing: data.itemPadding,
        itemBuilder: (context, i) {
          return _ItemCard(sectionData: data, itemData: list[i]);
        },
      );
    }

    return SliverSectionLayoutDecorator(
      styledData: data.styledData,
      sliver: listWidget,
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    Key? key,
    required this.sectionData,
    required this.itemData,
  }) : super(key: key);

  final AdvancedPromotionSectionData sectionData;
  final AdvancedPromotionSectionDataItem itemData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: itemData.action,
      )?.call(),
      child: sectionData.showLabel
          ? Column(
              children: [
                Expanded(
                  child: ExtendedCachedImage(
                    imageUrl: itemData.imageUrl,
                    fit: sectionData.itemImageBoxFit,
                    borderRadius: BorderRadius.circular(
                      sectionData.itemBorderRadius,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  itemData.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            )
          : ExtendedCachedImage(
              imageUrl: itemData.imageUrl,
              fit: sectionData.itemImageBoxFit,
              borderRadius: BorderRadius.circular(
                sectionData.itemBorderRadius,
              ),
            ),
    );
  }
}
