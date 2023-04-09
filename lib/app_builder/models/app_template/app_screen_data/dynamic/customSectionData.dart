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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../actions/actions.dart';
import '../../../models.dart';
import '../../../utils.dart';
import 'utils/custom_sections_utils.dart';

part 'sectionData/advancedPromotionSectionData.dart';
part 'sectionData/advanced_banner_section_data.dart';
part 'sectionData/bannerSectionData.dart';
part 'sectionData/categories_section_data.dart';
part 'sectionData/divider_section_data.dart';
part 'sectionData/promotionSectionData.dart';
part 'sectionData/recent_products_section_data.dart';
part 'sectionData/regularSectionData.dart';
part 'sectionData/saleSectionData.dart';
part 'sectionData/search_section_data.dart';
part 'sectionData/sliderSectionData.dart';
part 'sectionData/tags_section_data.dart';
part 'sectionData/text_section_data.dart';
part 'sectionData/vendor_section_data.dart';
part 'sectionData/video_section_data.dart';

/// Defines the type of section
enum SectionType {
  regular,
  banner,
  advancedBanner,
  advancedBannerList,
  sale,
  promotion,
  slider,
  advancedPromotion,
  categories,
  tags,
  recentProducts,
  vendor,
  video,
  text,
  divider,
  search,
  undefined,
}

/// Layout of the section on the screen
enum SectionLayout {
  horizontalList,
  verticalList,
  grid,
}

@immutable
class CustomSectionData {
  final int id;
  final bool show;

  /// To identify the section in the editor home page
  final String name;
  final SectionType sectionType;
  final StyledData styledData;

  const CustomSectionData({
    required this.id,
    required this.show,
    required this.name,
    required this.sectionType,
    this.styledData = const StyledData(
      marginData: MarginData(bottom: 10),
      paddingData: PaddingData(left: 10, top: 10, right: 10, bottom: 10),
    ),
  });

  /// Return an empty object in case of any error
  const CustomSectionData.empty({
    this.id = -1,
    this.name = 'NA',
    this.show = false,
    this.sectionType = SectionType.undefined,
    this.styledData = const StyledData(
      marginData: MarginData(left: 16, right: 16, bottom: 16),
      paddingData: PaddingData(),
    ),
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sectionType': sectionType.name,
      'show': show,
      'styledData': styledData.toMap(),
    };
  }

  /// Returns a section product variant based on the section type of the data
  /// received from the backend.
  factory CustomSectionData.fromMap(Map<String, dynamic> map) {
    final SectionType _sectionType =
        CustomSectionUtils.convertStringToSectionType(map['sectionType']);

    switch (_sectionType) {
      case SectionType.regular:
        return RegularSectionData.fromMap(map);

      case SectionType.banner:
        return BannerSectionData.fromMap(map);

      case SectionType.sale:
        return SaleSectionData.fromMap(map);

      case SectionType.promotion:
        return PromotionSectionData.fromMap(map);

      case SectionType.slider:
        return SliderSectionData.fromMap(map);

      case SectionType.advancedPromotion:
        return AdvancedPromotionSectionData.fromMap(map);

      case SectionType.categories:
        return CategoriesSectionData.fromMap(map);

      case SectionType.tags:
        return TagsSectionData.fromMap(map);

      case SectionType.advancedBanner:
        return AdvancedBannerSectionData.fromMap(map);

      case SectionType.advancedBannerList:
        return AdvancedBannerListSectionData.fromMap(map);

      case SectionType.recentProducts:
        return RecentProductsSectionData.fromMap(map);

      case SectionType.vendor:
        return VendorSectionData.fromMap(map);
      case SectionType.video:
        return VideoSectionData.fromMap(map);
      case SectionType.text:
        return TextSectionData.fromMap(map);

      case SectionType.divider:
        return DividerSectionData.fromMap(map);

      case SectionType.search:
        return SearchSectionData.fromMap(map);

      default:
        return const CustomSectionData.empty();
    }
  }

  CustomSectionData copyWith({
    int? id,
    bool? show,
    String? name,
    StyledData? styledData,
  }) {
    return CustomSectionData(
      id: id ?? this.id,
      sectionType: sectionType,
      show: show ?? this.show,
      name: name ?? this.name,
      styledData: styledData ?? this.styledData,
    );
  }
}
