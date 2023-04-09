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

import 'dart:math';

import '../customSectionData.dart';

class CustomSectionUtils {
  /// Converts a string value to SectionLayout enum
  static SectionLayout convertStringToSectionLayout(
    String? value, [
    SectionLayout? defaultValue,
  ]) {
    if (value == null) {
      return SectionLayout.horizontalList;
    }
    switch (value) {
      case 'horizontalList':
        return SectionLayout.horizontalList;

      case 'verticalList':
        return SectionLayout.verticalList;

      case 'grid':
        return SectionLayout.grid;

      default:
        return defaultValue ?? SectionLayout.horizontalList;
    }
  }

  /// Convert string to Section Type
  static SectionType convertStringToSectionType(String? value) {
    if (value == null || value == '') {
      return SectionType.regular;
    }

    switch (value) {
      case 'regular':
        return SectionType.regular;

      case 'banner':
        return SectionType.banner;

      case 'sale':
        return SectionType.sale;

      case 'promotion':
        return SectionType.promotion;

      case 'slider':
        return SectionType.slider;

      case 'advancedPromotion':
        return SectionType.advancedPromotion;

      case 'categoriesSection':
        return SectionType.categories;

      case 'tagsSection':
        return SectionType.tags;

      case 'categories':
        return SectionType.categories;

      case 'tags':
        return SectionType.tags;

      case 'advancedBanner':
        return SectionType.advancedBanner;

      case 'advancedBannerList':
        return SectionType.advancedBannerList;

      case 'recentProducts':
        return SectionType.recentProducts;

      case 'vendor':
        return SectionType.vendor;

      case 'video':
        return SectionType.video;

      case 'text':
        return SectionType.text;

      case 'search':
        return SectionType.search;

      case 'divider':
        return SectionType.divider;

      default:
        return SectionType.undefined;
    }
  }

  static int generateUUID({int? max}) {
    return Random().nextInt(max ?? 100000);
  }
}
