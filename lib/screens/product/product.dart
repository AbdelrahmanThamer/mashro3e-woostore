// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_builder/app_builder.dart';
import '../../locator.dart';
import 'layouts/expandable.dart';
import 'layouts/widgets/app_bar.dart';
import 'layouts/widgets/buyNowContainer.dart';
import 'productNotFound.dart';
import 'sections/product_add_ons/product_add_ons.dart';
import 'sections/sections.dart';
import 'viewModel/productViewModel.dart';

class ProductDetailsScreenLayout extends StatelessWidget {
  const ProductDetailsScreenLayout({
    Key? key,
    this.screenData,
    required this.id,
  }) : super(key: key);
  final AppProductScreenData? screenData;
  final String id;

  @override
  Widget build(BuildContext context) {
    final AppProductScreenData _screenData = screenData ??
        ParseEngine.getScreenData(
          screenId: AppPrebuiltScreensId.product,
          screenType: AppScreenType.preBuilt,
        ) as AppProductScreenData;
    final productData = LocatorService.productsProvider().productsMap[id];
    if (productData == null) {
      return ProductNotFound(productId: id, screenData: _screenData);
    }
    Widget main = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (_screenData.appBarData.show) const PSAppbar(),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 120),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                return renderLayout(_screenData.sections[i]);
              },
              childCount: _screenData.sections.length,
            ),
          ),
        )
      ],
    );

    providerOfProductViewModel = ChangeNotifierProvider.autoDispose(
      (ref) => ProductViewModel(
        context: context,
        currentProduct: productData,
        screenData: _screenData,
      ),
    );

    if (_screenData.screenLayout == PSLayout.expandable) {
      main = const ExpandableLayout();
    }

    return ProviderScope(
      overrides: [
        providerOfProductViewModel.overrideWithValue(
          ProductViewModel(
            context: context,
            currentProduct: productData,
            screenData: _screenData,
          ),
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            main,
            const Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: BuyNowContainer(),
            ),
          ],
        ),
      ),
    );
  }

  static Widget renderLayout(PSSectionData data) {
    switch (data.runtimeType) {
      case PSImageSectionData:
        return PSImageSectionLayout(
          data: data as PSImageSectionData,
        );

      case PSTextSectionData:
        return PSTextSectionLayout(
          data: data as PSTextSectionData,
        );
      case PSBannerSectionData:
        return PSBannerSectionLayout(
          data: data as PSBannerSectionData,
        );
      case PSAdvancedBannerSectionData:
        return PSAdvancedBannerSectionLayout(
          data: data as PSAdvancedBannerSectionData,
        );
      case PSProductNameSectionData:
        return PSProductNameSectionLayout(
          data: data as PSProductNameSectionData,
        );
      case PSPriceSectionData:
        return PSPriceSectionLayout(
          data: data as PSPriceSectionData,
        );
      case PSPointsAndRewardsSectionData:
        return PSPointsAndRewardsSectionLayout(
          data: data as PSPointsAndRewardsSectionData,
        );
      case PSStockAvailabilitySectionData:
        return PSStockAvailabilitySectionLayout(
          data: data as PSStockAvailabilitySectionData,
        );

      case PSVendorSectionData:
        return PSVendorSectionLayout(
          data: data as PSVendorSectionData,
        );

      case PSDescriptionSectionData:
        return PSDescriptionSectionLayout(
          data: data as PSDescriptionSectionData,
        );

      case PSShortDescriptionSectionData:
        return PSShortDescriptionSectionLayout(
          data: data as PSShortDescriptionSectionData,
        );

      case PSAttributesSectionData:
        return PSAttributesSectionLayout(
          data: data as PSAttributesSectionData,
        );
      case PSQuantitySectionData:
        return PSQuantitySectionLayout(
          data: data as PSQuantitySectionData,
        );
      case PSReviewSectionData:
        return PSReviewSectionLayout(
          data: data as PSReviewSectionData,
        );

      case PSCategoriesSectionData:
        return PSCategoriesSectionLayout(
          data: data as PSCategoriesSectionData,
        );
      case PSTagsSectionData:
        return PSTagsSectionLayout(
          data: data as PSTagsSectionData,
        );
      case PSRelatedProductsSectionData:
        return PSLinkedProductsSectionLayout(
          data: data as PSRelatedProductsSectionData,
        );
      case PSUpSellProductsSectionData:
        return PSLinkedProductsSectionLayout(
          data: data as PSUpSellProductsSectionData,
        );
      case PSCrossSellProductsSectionData:
        return PSLinkedProductsSectionLayout(
          data: data as PSCrossSellProductsSectionData,
        );

      case PSProductAddOnSectionData:
        return PSProductAddOnSectionLayout(
          data: data as PSProductAddOnSectionData,
        );
      default:
        return Text(data.runtimeType.toString());
    }
  }
}
