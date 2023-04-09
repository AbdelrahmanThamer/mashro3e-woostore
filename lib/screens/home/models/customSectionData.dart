// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

// @dart=2.9

import 'package:flutter/foundation.dart';

import '../../../developer/dev.log.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../utils/homeUtils.dart';
import 'sectionData/utils/sectionDataUtils.dart';

part 'sectionData/advancedPromotionSectionData.dart';
part 'sectionData/bannerSectionData.dart';
part 'sectionData/categories_section_data.dart';
part 'sectionData/external_link/advanced_promotion.dart';
part 'sectionData/external_link/banner.dart';
part 'sectionData/external_link/promotion.dart';
part 'sectionData/external_link/slider.dart';
part 'sectionData/promotionSectionData.dart';
part 'sectionData/regularSectionData.dart';
part 'sectionData/saleSectionData.dart';
part 'sectionData/single_product/advanced_promotion.dart';
part 'sectionData/single_product/banner.dart';
part 'sectionData/single_product/promotion.dart';
part 'sectionData/single_product/slider.dart';
part 'sectionData/sliderSectionData.dart';
part 'sectionData/tags_section_data.dart';

/// Defines the type of section
enum SectionType {
  regular,
  banner,
  bannerExternalLink,
  bannerSingleProduct,
  sale,
  promotion,
  promotionExternalLink,
  promotionSingleProduct,
  slider,
  sliderExternalLink,
  sliderSingleProduct,
  advancedPromotion,
  advancedPromotionExternalLink,
  advancedPromotionSingleProduct,
  categoriesSection,
  tagsSection,
  undefined,
}

/// Layout of the section on the screen
enum SectionLayout {
  list,
  grid,
  mediumGrid,
  wrap,
}

@immutable
class CustomSectionData {
  final bool show;
  final SectionType sectionType;

  const CustomSectionData({
    @required this.show,
    @required this.sectionType,
  });

  /// Return an empty object in case of any error
  const CustomSectionData.empty({
    this.show = false,
    this.sectionType = SectionType.undefined,
  });

  /// Returns a section product variant based on the section type of the data
  /// received from the backend.
  factory CustomSectionData.fromMap(Map<String, dynamic> map) {
    // Extract the 'Advanced Custom Fields' map from the json response
    final Map<String, dynamic> acf = map['acf'];

    final SectionType _sectionType =
        HomeUtils.convertStringToSectionType(acf['section_type' ?? '']);

    switch (_sectionType) {
      case SectionType.regular:
        return RegularSectionData.fromMap(acf);
        break;
      case SectionType.banner:
        return BannerSectionData.fromMap(acf);
        break;
      case SectionType.bannerExternalLink:
        return BannerExternalLinkSectionData.fromMap(acf);
        break;
      case SectionType.bannerSingleProduct:
        return BannerSingleProductSectionData.fromMap(acf);
        break;
      case SectionType.sale:
        return SaleSectionData.fromMap(acf);
        break;
      case SectionType.promotion:
        return PromotionSectionData.fromMap(acf);
        break;
      case SectionType.promotionExternalLink:
        return PromotionExternalLinkSectionData.fromMap(acf);
        break;
      case SectionType.promotionSingleProduct:
        return PromotionSingleProductSectionData.fromMap(acf);
        break;
      case SectionType.slider:
        return SliderSectionData.fromMap(acf);
        break;
      case SectionType.sliderExternalLink:
        return SliderExternalLinkSectionData.fromMap(acf);
        break;
      case SectionType.sliderSingleProduct:
        return SliderSingleProductSectionData.fromMap(acf);
        break;
      case SectionType.advancedPromotion:
        return AdvancedPromotionSectionData.fromMap(acf);
        break;
      case SectionType.advancedPromotionExternalLink:
        return AdvancedPromotionExternalLinkSectionData.fromMap(acf);
        break;
      case SectionType.advancedPromotionSingleProduct:
        return AdvancedPromotionSingleProductSectionData.fromMap(acf);
        break;
      case SectionType.categoriesSection:
        return CategoriesSectionData.fromMap(acf);
        break;
      case SectionType.tagsSection:
        return TagsSectionData.fromMap(acf);
        break;
      default:
        return const CustomSectionData.empty();
    }
  }
}
