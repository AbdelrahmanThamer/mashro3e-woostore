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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';

import '../../../../../../models/models.dart';
import '../../../../../../state/state.dart';
import '../../../../../../ui/slivers/multi_sliver.dart';
import '../../../shared/product_card/product_card.dart';
import 'layouts/layouts.dart';
import 'shared/decorator.dart';
import 'shared/secton_title.dart';

class RecentProductsSectionLayout extends StatelessWidget {
  const RecentProductsSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final RecentProductsSectionData data;

  @override
  Widget build(BuildContext context) {
    if (isNotBlank(data.title)) {
      return SliverSectionLayoutDecorator(
        styledData: data.styledData,
        sliver: MultiSliver(
          children: [
            SectionTitle(title: data.title),
            _ProductsContainer(data: data),
          ],
        ),
      );
    }

    return SliverSectionLayoutDecorator(
      styledData: data.styledData,
      sliver: _ProductsContainer(data: data),
    );
  }
}

class _ProductsContainer extends ConsumerWidget {
  const _ProductsContainer({
    Key? key,
    required this.data,
  }) : super(key: key);
  final RecentProductsSectionData data;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final list = List.generate(5, (index) => index + 1);

    var productCardLayoutData = data.productCardLayoutData;
    if (data.useGlobalProductCardLayout) {
      productCardLayoutData = ref
          .read(providerOfAppTemplateState)
          .template
          .globalProductCardLayout;
    }

    Widget listWidget = SliverToBoxAdapter(
      child: HorizontalListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: DimensionsData(
          height: productCardLayoutData.height,
          width: productCardLayoutData.width,
        ),
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: data.itemPadding),
            child: ProductCardLayout(
              layoutData: productCardLayoutData,
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
            child: ProductCardLayout(
              layoutData: productCardLayoutData,
            ),
          );
        },
      );
    }

    if (data.layout == SectionLayout.grid) {
      listWidget = GridListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: DimensionsData(
          height: productCardLayoutData.height,
          width: productCardLayoutData.width,
          aspectRatio: productCardLayoutData.getAspectRatio(),
        ),
        columns: data.columns,
        spacing: data.itemPadding,
        aspectRatio: productCardLayoutData.getAspectRatio(),
        itemBuilder: (context, i) {
          return ProductCardLayout(
            layoutData: productCardLayoutData,
          );
        },
      );
    }
    return listWidget;
  }
}
