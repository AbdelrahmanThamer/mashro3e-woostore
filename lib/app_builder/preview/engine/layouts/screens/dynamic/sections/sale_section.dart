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
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';

import '../../../../../../models/models.dart';
import '../../../../../../state/state.dart';
import '../../../../../../ui/slivers/multi_sliver.dart';
import '../../../shared/product_card/product_card.dart';
import 'layouts/layouts.dart';
import 'shared/decorator.dart';

class SaleSectionLayout extends StatelessWidget {
  const SaleSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final SaleSectionData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget widget = _ProductsContainer(data: data);
    if (data.showPromotionalImages) {
      widget = _PromotionalImages(
        data: data,
        theme: theme,
      );
    }

    return SliverSectionLayoutDecorator(
      styledData: data.styledData,
      sliver: MultiSliver(
        children: [
          SliverToBoxAdapter(child: _Title(sectionData: data)),
          widget,
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key, required this.sectionData}) : super(key: key);
  final SaleSectionData sectionData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LimitedBox(
      maxHeight: 60,
      child: isNotBlank(sectionData.title)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    sectionData.title,
                    style: theme.textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 8),
                _SaleEndTimer(
                  saleEndTime: sectionData.saleEndTime,
                  theme: theme,
                  mainAxisAlignment: MainAxisAlignment.start,
                )
              ],
            )
          : _SaleEndTimer(
              saleEndTime: sectionData.saleEndTime,
              theme: theme,
              mainAxisAlignment: MainAxisAlignment.start,
            ),
    );
  }
}

class _ProductsContainer extends ConsumerWidget {
  const _ProductsContainer({
    Key? key,
    required this.data,
  }) : super(key: key);
  final SaleSectionData data;

  @override
  Widget build(BuildContext context, ref) {
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
        itemDimensionsData: data.itemDimensionsData,
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

class _PromotionalImages extends StatelessWidget {
  const _PromotionalImages({
    Key? key,
    required this.data,
    required this.theme,
  }) : super(key: key);

  final SaleSectionData data;

  /// Send the theme from parent widget so save an inherited widget lookup.
  final ThemeData theme;

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
              child: ExtendedCachedImage(
                imageUrl: list[i],
                borderRadius: BorderRadius.circular(data.itemBorderRadius),
                fit: data.itemImageBoxFit,
              ),
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
              child: ExtendedCachedImage(
                imageUrl: list[i],
                borderRadius: BorderRadius.circular(data.itemBorderRadius),
                fit: data.itemImageBoxFit,
              ),
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
          return AspectRatio(
            aspectRatio: data.itemDimensionsData.aspectRatio,
            child: ExtendedCachedImage(
              imageUrl: list[i],
              borderRadius: BorderRadius.circular(data.itemBorderRadius),
              fit: data.itemImageBoxFit,
            ),
          );
        },
      );
    }

    return listWidget;
  }
}

class _SaleEndTimer extends StatelessWidget {
  const _SaleEndTimer({
    Key? key,
    required this.saleEndTime,
    required this.theme,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  final String saleEndTime;

  /// Send the theme from parent widget so save an inherited widget lookup.
  final ThemeData theme;

  /// Alignment for the row which holds timer and text
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final int now = DateTime.now().millisecondsSinceEpoch;
    final int endTime = DateTime.parse(saleEndTime).millisecondsSinceEpoch;
    final remainingSeconds = endTime - now;

    if (remainingSeconds < 0) {
      return Text(
        'Sale Ended',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: theme.brightness == Brightness.light
              ? const Color(0xFF616161)
              : const Color(0xFFBDBDBD),
        ),
      );
    }

    if (remainingSeconds > 0) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          const Text('Ends In'),
          const SizedBox(width: 10),
          CountdownTimer(
            endTime: endTime,
            endWidget: Text(
              'Sale Ended',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.brightness == Brightness.light
                    ? const Color(0xFF616161)
                    : const Color(0xFFBDBDBD),
              ),
            ),
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: theme.brightness == Brightness.light
                  ? const Color(0xFF7D7D7D)
                  : const Color(0xFFBDBDBD),
            ),
          ),
        ],
      );
    } else {
      return Text(
        'Sale Ended : ' + saleEndTime,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      );
    }
  }
}
