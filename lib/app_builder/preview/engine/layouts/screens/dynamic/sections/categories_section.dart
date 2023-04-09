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
import '../../../../../../utils.dart';
import 'layouts/layouts.dart';
import 'shared/decorator.dart';

class CategoriesSectionLayout extends StatelessWidget {
  const CategoriesSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final CategoriesSectionData data;

  @override
  Widget build(BuildContext context) {
    List<CategoryData> list = data.categories;
    if (data.showAll) {
      list = List.generate(10, (index) => const CategoryData());
    }

    Widget listWidget = SliverToBoxAdapter(
      child: HorizontalListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.itemDimensionsData,
        itemBuilder: (context, i) {
          return SizedBox(
            width: data.itemDimensionsData.width,
            height: data.itemDimensionsData.height,
            child: _ItemCard(sectionData: data, itemData: list[i]),
          );
        },
      ),
    );

    if (data.layout == CategorySectionLayoutType.verticalList) {
      listWidget = VerticalListSectionLayout(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return SizedBox(
            width: double.infinity,
            height: data.itemDimensionsData.height,
            child: _ItemCard(sectionData: data, itemData: list[i]),
          );
        },
      );
    }

    if (data.layout == CategorySectionLayoutType.grid) {
      listWidget = GridListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.itemDimensionsData,
        columns: data.columns,
        spacing: 0,
        itemBuilder: (context, i) {
          return AspectRatio(
            aspectRatio: data.itemDimensionsData.aspectRatio,
            child: _ItemCard(sectionData: data, itemData: list[i]),
          );
        },
      );
    }

    if (data.layout == CategorySectionLayoutType.wrap) {
      listWidget = SliverToBoxAdapter(
        child: Wrap(
          children: list
              .map<Widget>((e) => SizedBox(
                    width: data.itemDimensionsData.width,
                    height: data.itemDimensionsData.height,
                    child: _ItemCard(sectionData: data, itemData: e),
                  ))
              .toList(),
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
    required this.itemData,
  }) : super(key: key);

  final CategoriesSectionData sectionData;
  final CategoryData itemData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: sectionData.itemStyledData.paddingData.createEdgeInsets(),
      margin: sectionData.itemStyledData.marginData.createEdgeInsets(),
      decoration: BoxDecoration(
        color: HexColor.fromHex(
          sectionData.itemStyledData.backgroundColor,
          Theme.of(context).colorScheme.background,
        ),
        borderRadius:
            BorderRadius.circular(sectionData.itemStyledData.borderRadius),
      ),
      child: sectionData.showLabel
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ExtendedCachedImage(
                      imageUrl: itemData.imageUrl,
                      borderRadius: BorderRadius.circular(
                        sectionData.itemStyledData.borderRadius,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(
                      itemData.title,
                      style: sectionData.itemStyledData.textStyleData
                          .createTextStyle(
                        forcedColor:
                            Theme.of(context).textTheme.bodyText2?.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            )
          : ExtendedCachedImage(
              imageUrl: itemData.imageUrl,
              borderRadius: BorderRadius.circular(
                sectionData.itemStyledData.borderRadius,
              ),
            ),
    );
  }
}
