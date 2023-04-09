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

import '../../../../app_builder/app_builder.dart';
import '../../../shared/vendor_card/vendor_card.dart';
import '../../viewModel/productViewModel.dart';

class PSVendorSectionLayout extends ConsumerWidget {
  const PSVendorSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSVendorSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendor =
        ref.read(providerOfProductViewModel).currentProduct.wooProduct.vendor;
    if (vendor == null || vendor.id == null || vendor.id! <= 0) {
      return const SizedBox();
    }
    Widget result = VendorCardLayout(
      data: vendor,
      layoutData: VendorCardLayoutData(
        styledData: data.styledData.copyWith(
          dimensionsData: const DimensionsData(height: 200),
        ),
      ),
    );

    if (data.sectionLayout == PSVendorSectionLayoutType.original) {
      result = VendorCardLayout(
        layoutData: VendorCardLayoutData(
          layoutType: VendorCardLayoutType.original,
          styledData: data.styledData.copyWith(
            dimensionsData: const DimensionsData(
              height: 200,
              width: 200,
            ),
          ),
        ),
      );
    }

    if (data.sectionLayout == PSVendorSectionLayoutType.originalWithBanner) {
      result = VendorCardLayout(
        layoutData: VendorCardLayoutData(
          styledData: data.styledData.copyWith(
            dimensionsData: const DimensionsData(
              height: 300,
              width: 200,
            ),
          ),
          layoutType: VendorCardLayoutType.originalWithBanner,
        ),
      );
    }

    if (data.sectionLayout == PSVendorSectionLayoutType.horizontal) {
      result = VendorCardLayout(
        layoutData: VendorCardLayoutData(
          styledData: data.styledData.copyWith(
            dimensionsData: const DimensionsData(
              height: 100,
              width: 220,
            ),
          ),
          layoutType: VendorCardLayoutType.horizontal,
        ),
      );
    }

    if (data.sectionLayout == PSVendorSectionLayoutType.horizontalGradient) {
      result = VendorCardLayout(
        layoutData: VendorCardLayoutData(
          styledData: data.styledData.copyWith(
            dimensionsData: const DimensionsData(
              height: 200,
              width: 300,
            ),
          ),
          layoutType: VendorCardLayoutType.horizontalGradient,
        ),
      );
    }
    return GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: NavigationAction(
          navigationData: const NavigationData(
            screenName: AppPrebuiltScreensNames.vendor,
            screenId: AppPrebuiltScreensId.vendor,
          ),
          arguments: {'vendor': vendor},
        ),
      )?.call(),
      child: result,
    );
  }
}
