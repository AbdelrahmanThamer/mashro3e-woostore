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

import '../../../../../../models/models.dart';
import '../../../../../../utils.dart';
import 'layouts/layouts.dart';
import 'shared/decorator.dart';

class TagsSectionLayout extends StatelessWidget {
  const TagsSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final TagsSectionData data;

  @override
  Widget build(BuildContext context) {
    final List<TagData> list = data.items;

    Widget listWidget = SliverToBoxAdapter(
      child: HorizontalListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: DimensionsData(
          height: data.height,
          width: double.infinity,
        ),
        itemBuilder: (context, i) {
          return SizedBox(
            height: data.height,
            child: _ItemCard(sectionData: data, itemData: list[i]),
          );
        },
      ),
    );

    if (data.layout == TagsSectionLayoutType.verticalList) {
      listWidget = VerticalListSectionLayout(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return SizedBox(
            width: double.infinity,
            height: data.height,
            child: _ItemCard(sectionData: data, itemData: list[i]),
          );
        },
      );
    }

    if (data.layout == TagsSectionLayoutType.grid) {
      listWidget = GridListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: DimensionsData(
          height: data.height,
          width: double.infinity,
        ),
        columns: data.columns,
        spacing: 0,
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

  final TagsSectionData sectionData;
  final TagData itemData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: sectionData.itemStyledData.paddingData.createEdgeInsets(),
      margin: sectionData.itemStyledData.marginData.createEdgeInsets(),
      decoration: BoxDecoration(
        color: HexColor.fromHex(
          sectionData.itemStyledData.backgroundColor,
          theme.colorScheme.background,
        ),
        borderRadius:
            BorderRadius.circular(sectionData.itemStyledData.borderRadius),
      ),
      child: Center(
        child: Text(
          itemData.title,
          style: sectionData.itemStyledData.textStyleData.createTextStyle(
            forcedColor: theme.textTheme.bodyText2?.color,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
