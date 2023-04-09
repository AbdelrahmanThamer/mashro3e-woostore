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

import 'dart:ui';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/app_template/app_template.dart';
import '../../app_bar/app_bar.dart';
import 'sections/sections.dart';

class ProductDetailsScreenLayout extends StatelessWidget {
  const ProductDetailsScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppProductScreenData screenData;

  @override
  Widget build(BuildContext context) {
    Widget main = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (screenData.appBarData.show)
          SliverAppBarLayout(data: screenData.appBarData),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 120),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                return renderLayout(screenData.sections[i]);
              },
              childCount: screenData.sections.length,
            ),
          ),
        )
      ],
    );

    if (screenData.screenLayout == PSLayout.expandable) {
      main = _ExpandableLayout(screenData: screenData);
    }
    return Provider<AppProductScreenData>(
      key: ValueKey(screenData.hashCode),
      create: (context) => screenData,
      child: Scaffold(
        body: Stack(
          children: [
            main,
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: _Blur(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: renderBottomButtonsLayout(screenData),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget renderBottomButtonsLayout(AppProductScreenData data) {
    switch (data.bottomButtonsLayout) {
      case PSBottomButtonsLayout.layout1:
        return const _Layout1();
      case PSBottomButtonsLayout.layout2:
        return const _Layout2();
      case PSBottomButtonsLayout.layout3:
        return const _Layout3();
      default:
        return const _Layout1();
    }
  }

  static Widget renderLayout(PSSectionData data) {
    switch (data.runtimeType) {
      case PSImageSectionData:
        return PSImageSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSImageSectionData,
        );

      case PSTextSectionData:
        return PSTextSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSTextSectionData,
        );
      case PSBannerSectionData:
        return PSBannerSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSBannerSectionData,
        );
      case PSAdvancedBannerSectionData:
        return PSAdvancedBannerSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSAdvancedBannerSectionData,
        );
      case PSProductNameSectionData:
        return PSProductNameSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSProductNameSectionData,
        );
      case PSPriceSectionData:
        return PSPriceSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSPriceSectionData,
        );
      case PSPointsAndRewardsSectionData:
        return PSPointsAndRewardsSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSPointsAndRewardsSectionData,
        );
      case PSStockAvailabilitySectionData:
        return PSStockAvailabilitySectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSStockAvailabilitySectionData,
        );

      case PSVendorSectionData:
        return PSVendorSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSVendorSectionData,
        );

      case PSDescriptionSectionData:
        return PSDescriptionSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSDescriptionSectionData,
        );

      case PSShortDescriptionSectionData:
        return PSShortDescriptionSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSShortDescriptionSectionData,
        );

      case PSAttributesSectionData:
        return PSAttributesSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSAttributesSectionData,
        );
      case PSQuantitySectionData:
        return PSQuantitySectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSQuantitySectionData,
        );
      case PSReviewSectionData:
        return PSReviewSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSReviewSectionData,
        );

      case PSCategoriesSectionData:
        return PSCategoriesSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSCategoriesSectionData,
        );
      case PSTagsSectionData:
        return PSTagsSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSTagsSectionData,
        );
      case PSRelatedProductsSectionData:
        return PSLinkedProductsSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSRelatedProductsSectionData,
        );
      case PSUpSellProductsSectionData:
        return PSLinkedProductsSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSUpSellProductsSectionData,
        );
      case PSCrossSellProductsSectionData:
        return PSLinkedProductsSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PSCrossSellProductsSectionData,
        );
      default:
        return Text(data.runtimeType.toString());
    }
  }
}

class _ExpandableLayout extends StatelessWidget {
  const _ExpandableLayout({Key? key, required this.screenData})
      : super(key: key);
  final AppProductScreenData screenData;

  @override
  Widget build(BuildContext context) {
    final PSImageSectionData isd = screenData.sections
            .firstWhere((element) => element.sectionType == PSSectionType.image)
        as PSImageSectionData;
    double expandedHeight = MediaQuery.of(context).size.width / isd.aspectRatio;
    if (isd.showImageGallery) {
      expandedHeight += 150;
    }
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (screenData.appBarData.show)
          SliverAppBarLayout(data: screenData.appBarData),
        SliverAppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: ProductDetailsScreenLayout.renderLayout(isd),
          expandedHeight: expandedHeight,
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 120),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                if (screenData.sections[i].sectionType == PSSectionType.image) {
                  return const SizedBox();
                }
                return ProductDetailsScreenLayout.renderLayout(
                  screenData.sections[i],
                );
              },
              childCount: screenData.sections.length,
            ),
          ),
        )
      ],
    );
  }
}

class _Layout1 extends StatelessWidget {
  const _Layout1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _BackgroundDecorator(
          child: Icon(EvaIcons.shoppingCartOutline),
        ),
        SizedBox(width: 5),
        Expanded(child: _BuyNowButton()),
      ],
    );
  }
}

class _Layout2 extends StatelessWidget {
  const _Layout2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppProductScreenData>(context, listen: false);
    return Row(
      children: [
        Expanded(
          child: _BackgroundDecorator(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(EvaIcons.shoppingCartOutline),
                const SizedBox(width: 5),
                Text(
                  'Add to cart',
                  style: TextStyle(
                    fontSize: state.bottomButtonTextStyle.fontSize,
                    fontWeight: state.bottomButtonTextStyle.getFontWeight(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
        const Expanded(child: _BuyNowButton()),
      ],
    );
  }
}

class _Layout3 extends StatelessWidget {
  const _Layout3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppProductScreenData>(context, listen: false);
    return Row(
      children: [
        Expanded(
          child: _BackgroundDecorator(
            child: Text(
              'Add to cart',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: state.bottomButtonTextStyle.fontSize,
                fontWeight: state.bottomButtonTextStyle.getFontWeight(),
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        const Expanded(child: _BuyNowButton()),
      ],
    );
  }
}

class _BuyNowButton extends StatelessWidget {
  const _BuyNowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppProductScreenData>(context, listen: false);
    return _BackgroundDecorator(
      useGradient: true,
      child: Text(
        'Buy Now',
        style: state.bottomButtonTextStyle.createTextStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _BackgroundDecorator extends StatelessWidget {
  const _BackgroundDecorator({
    Key? key,
    required this.child,
    this.useGradient = false,
  }) : super(key: key);
  final Widget child;
  final bool useGradient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (useGradient) {
      return GradientButton(child: child, onPress: () {});
    }
    return Container(
      padding: ThemeGuide.padding16,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: child,
    );
  }
}

class _Blur extends StatelessWidget {
  const _Blur({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: child,
      ),
    );
  }
}
