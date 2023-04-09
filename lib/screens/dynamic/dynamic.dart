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

import '../../app_builder/app_builder.dart';
import '../../shared/customLoader.dart';
import '../shared/app_bar/app_bar.dart';
import 'sections/advanced_banner_section.dart';
import 'sections/advanced_promotion_section.dart';
import 'sections/banner_section.dart';
import 'sections/categories_section.dart';
import 'sections/divider_section.dart';
import 'sections/promotion_section.dart';
import 'sections/recent_products_section.dart';
import 'sections/regular_section.dart';
import 'sections/sale_section.dart';
import 'sections/search_section.dart';
import 'sections/slider_section.dart';
import 'sections/tags_section.dart';
import 'sections/text_section.dart';
import 'sections/vendor_section.dart';
import 'sections/video_section.dart';

class DynamicScreenLayout extends StatelessWidget {
  const DynamicScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppDynamicScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          if (screenData.appBarData.show)
            SliverAppBarLayout(data: screenData.appBarData),
          if (screenData.sections.isEmpty)
            const SliverToBoxAdapter(
              child: SizedBox(child: CustomLoader(), height: 200),
            ),
          ...screenData.sections
              .where((e) => e.show)
              .toList()
              .map<Widget>((e) => _renderLayout(e))
              .toList(),
        ],
      ),
    );
  }

  Widget _renderLayout(CustomSectionData data) {
    switch (data.runtimeType) {
      case AdvancedBannerSectionData:
        return AdvancedBannerSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as AdvancedBannerSectionData,
        );

      case AdvancedBannerListSectionData:
        return AdvancedBannerListSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as AdvancedBannerListSectionData,
        );

      case SliderSectionData:
        return SliderSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as SliderSectionData,
        );

      case AdvancedPromotionSectionData:
        return AdvancedPromotionSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as AdvancedPromotionSectionData,
        );

      case SaleSectionData:
        return SaleSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as SaleSectionData,
        );

      case CategoriesSectionData:
        return CategoriesSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as CategoriesSectionData,
        );

      case BannerSectionData:
        return BannerSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as BannerSectionData,
        );

      case PromotionSectionData:
        return PromotionSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as PromotionSectionData,
        );

      case RegularSectionData:
        return RegularSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as RegularSectionData,
        );

      case RecentProductsSectionData:
        return RecentProductsSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as RecentProductsSectionData,
        );

      case TagsSectionData:
        return TagsSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as TagsSectionData,
        );

      case VendorSectionData:
        return VendorSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as VendorSectionData,
        );

      case SearchSectionData:
        return SearchSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as SearchSectionData,
        );

      case TextSectionData:
        return TextSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as TextSectionData,
        );

      case VideoSectionData:
        return VideoSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as VideoSectionData,
        );

      case DividerSectionData:
        return DividerSectionLayout(
          key: ValueKey(data.hashCode),
          data: data as DividerSectionData,
        );
      default:
        return _PlaceHolder(data: data);
    }
  }
}

class _PlaceHolder extends StatelessWidget {
  const _PlaceHolder({Key? key, required this.data}) : super(key: key);
  final CustomSectionData data;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          data.runtimeType.toString(),
          style: TextStyle(color: Theme.of(context).textTheme.bodyText2?.color),
        ),
      ),
    );
  }
}
