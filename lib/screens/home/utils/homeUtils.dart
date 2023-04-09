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

import 'package:flutter/cupertino.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../developer/dev.log.dart';
import '../../../locator.dart';
import '../../../models/models.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../constants/config.dart';
import '../models/customSectionData.dart';

class HomeUtils {
  /// Converts a string value to SectionLayout enum
  static SectionLayout convertStringToSectionLayout(String value) {
    if (value == null) {
      return SectionLayout.list;
    }
    final temp = value.toLowerCase();
    switch (temp) {
      case 'list':
        return SectionLayout.list;
        break;
      case 'grid':
        return SectionLayout.grid;
        break;
      case 'medium_grid':
        return SectionLayout.mediumGrid;
        break;
      case 'wrap':
        return SectionLayout.wrap;
        break;
      default:
        return SectionLayout.list;
    }
  }

  /// Converts a SectionLayout value a string
  static String getStringFrom(SectionLayout value) {
    if (value == null) {
      return null;
    }
    switch (value) {
      case SectionLayout.list:
        return 'list';
        break;
      case SectionLayout.grid:
        return 'grid';
        break;
      case SectionLayout.mediumGrid:
        return 'mediumGrid';
        break;
      case SectionLayout.wrap:
        return 'wrap';
        break;
      default:
        return 'list';
    }
  }

  /// Convert string to Section Type
  static SectionType convertStringToSectionType(String value) {
    if (value == null || value == '') {
      return SectionType.regular;
    }

    switch (value) {
      case 'regular':
        return SectionType.regular;
        break;
      case 'banner':
        return SectionType.banner;
        break;
      case 'banner_external_link':
        return SectionType.bannerExternalLink;
        break;
      case 'banner_single_product':
        return SectionType.bannerSingleProduct;
        break;
      case 'sale':
        return SectionType.sale;
        break;
      case 'promotion':
        return SectionType.promotion;
        break;
      case 'promotion_external_link':
        return SectionType.promotionExternalLink;
        break;
      case 'promotion_single_product':
        return SectionType.promotionSingleProduct;
        break;
      case 'slider':
        return SectionType.slider;
        break;
      case 'slider_external_link':
        return SectionType.sliderExternalLink;
        break;
      case 'slider_single_product':
        return SectionType.sliderSingleProduct;
        break;
      case 'advanced_promotion':
        return SectionType.advancedPromotion;
        break;
      case 'advanced_promotion_external_link':
        return SectionType.advancedPromotionExternalLink;
        break;
      case 'advanced_promotion_single_product':
        return SectionType.advancedPromotionSingleProduct;
        break;
      case 'categories_section':
        return SectionType.categoriesSection;
        break;
      case 'tags_section':
        return SectionType.tagsSection;
        break;
      default:
        return SectionType.undefined;
    }
  }

  /// # Description
  ///
  /// Performs some required actions on the data set passed to the function.
  ///
  /// -------------------------------------------------------------------------
  ///
  /// ## Parameters
  ///
  /// * [list] - List of the wooProducts fetched from backend
  ///
  /// * [dataHolder] - List which holds the IDs for the products as a reference
  /// in the specific class
  ///
  /// -------------------------------------------------------------------------
  ///
  /// ## Note
  ///
  /// It automatically adds the product to the all products map for future ref.
  ///
  /// -------------------------------------------------------------------------
  static Set<String> processProductsData({
    @required List<WooProduct> list,
    @required Set<String> dataHolder,
  }) {
    Dev.debugFunction(
      functionName: 'processProductsData',
      className: 'ProductUtils',
      start: true,
      fileName: 'ProductsUtils',
    );
    final Set<String> result = {};
    if (list.isNotEmpty) {
      for (var i = 0; i < list.length; i++) {
        if (dataHolder.contains(list[i].id.toString())) {
          result.add(list[i].id.toString());
          continue;
        }
        final Product p = Product.fromWooProduct(list[i]);
        result.add(p.id.toString());
        LocatorService.productsProvider().addToMap(p);
      }
    }
    Dev.debugFunction(
      functionName: 'processProductsData',
      className: 'ProductUtils',
      start: false,
      fileName: 'ProductsUtils',
    );
    return result;
  }

  static Future<void> handleExternalLinkNavigationEvent({
    BuildContext context,
    String externalLink,
  }) async {
    if (isBlank(externalLink)) {
      Dev.warn('External link is empty or null. Please add a link.');
    } else {
      if (HomeConfig.openExternalLinkScheme == 'browser') {
        if (await canLaunchUrlString(externalLink)) {
          launchUrlString(externalLink);
        } else {
          Dev.warn('External link cannot be launched.');
        }
      } else {
        // UiController.showModal(
        //   context: context,
        //   child: HomeExternalLinkWebView(externalLink: externalLink),
        // );
      }
    }
  }
}
