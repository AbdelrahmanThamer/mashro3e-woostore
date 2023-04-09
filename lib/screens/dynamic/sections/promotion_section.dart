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
import 'package:quiver/strings.dart';

import '../../../app_builder/app_builder.dart';
import 'layouts/layouts.dart';
import 'shared/decorator.dart';
import 'shared/section_title.dart';

class PromotionSectionLayout extends StatelessWidget {
  const PromotionSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PromotionSectionData data;

  @override
  Widget build(BuildContext context) {
    final list = data.images;
    Widget listWidget = SliverToBoxAdapter(
      child: HorizontalListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.itemDimensionsData,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: data.itemPadding),
            child: SizedBox(
              width: data.itemDimensionsData.width,
              child: _ItemCard(sectionData: data, imageUrl: list[i]),
            ),
          );
        },
      ),
    );

    if (data.layout == SectionLayout.verticalList) {
      listWidget = VerticalListSectionLayout(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.only(bottom: data.itemPadding),
            height: data.itemDimensionsData.height,
            child: _ItemCard(sectionData: data, imageUrl: list[i]),
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
          return _ItemCard(sectionData: data, imageUrl: list[i]);
        },
      );
    }

    if (isNotBlank(data.title)) {
      return SliverSectionLayoutDecorator(
        styledData: data.styledData,
        sliver: MultiSliver(
          children: [
            SectionTitle(title: data.title),
            listWidget,
          ],
        ),
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
    required this.imageUrl,
  }) : super(key: key);

  final PromotionSectionData sectionData;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: sectionData.action,
      )?.call(),
      child: ExtendedCachedImage(
        imageUrl: imageUrl,
        fit: sectionData.itemImageBoxFit,
        borderRadius: BorderRadius.circular(
          sectionData.itemBorderRadius,
        ),
      ),
    );
  }
}
