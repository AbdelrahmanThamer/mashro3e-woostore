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
import 'package:quiver/strings.dart';

import '../../../../../../actions/actions.dart';
import '../../../../../../models/models.dart';
import '../../../../../../ui/slivers/multi_sliver.dart';
import '../../../../engine.dart';
import '../../../shared/vendor_card/vendor_card.dart';
import 'layouts/layouts.dart';
import 'shared/decorator.dart';
import 'shared/secton_title.dart';

class VendorSectionLayout extends StatelessWidget {
  const VendorSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final VendorSectionData data;

  @override
  Widget build(BuildContext context) {
    List<VendorData> list = data.vendors;

    if (list.isEmpty) {
      list = List.generate(5, (index) => const VendorData());
    }

    Widget listWidget = SliverToBoxAdapter(
      child: HorizontalListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.vendorCardLayoutData.styledData.dimensionsData,
        itemBuilder: (context, i) {
          return _ItemCard(sectionData: data, vendorData: list[i]);
        },
      ),
    );

    if (data.layout == SectionLayout.verticalList) {
      listWidget = VerticalListSectionLayout(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return _ItemCard(sectionData: data, vendorData: list[i]);
        },
      );
    }

    if (data.layout == SectionLayout.grid) {
      listWidget = GridListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.vendorCardLayoutData.styledData.dimensionsData,
        columns: data.columns,
        spacing: 0,
        itemBuilder: (context, i) {
          return _ItemCard(sectionData: data, vendorData: list[i]);
        },
      );
    }

    if (isNotBlank(data.title)) {
      return SliverSectionLayoutDecorator(
        styledData: data.styledData,
        sliver: MultiSliver(
          children: [
            SectionTitle(title: data.title!),
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
    required this.vendorData,
  }) : super(key: key);

  final VendorSectionData sectionData;
  final VendorData vendorData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: NavigationAction(
          navigationData: const NavigationData(
            screenName: AppPrebuiltScreensNames.vendor,
            screenId: AppPrebuiltScreensId.vendor,
          ),
          arguments: {'vendorData': vendorData},
        ),
      )?.call(),
      child: VendorCardLayout(
        layoutData: sectionData.vendorCardLayoutData,
        data: vendorData,
      ),
    );
  }
}
