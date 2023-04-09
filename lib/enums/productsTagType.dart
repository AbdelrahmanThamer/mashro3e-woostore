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

part of 'enums.dart';

/// Different types of pre-defined tags to fetch products data
enum ProductsTagType {
  POPULAR,
  FEATURED,
  BEST_SELLERS,
  DEAL_OF_THE_DAY,
  FLASH_SALE,
  SUMMER,
  TRENDING,
  WEEK_PROMOTIONS,
  WINTER,
  @Deprecated('No longer has any meaning')
  RELATED,

  /// Use to show related products based on user preferences.
  RECOMMENDED,
}

///
/// ## `Description`
///
/// Converts the popular products data type to string of ID for
/// woocommerce api tags.
///
String convertProductsTypeToTagId(ProductsTagType type) {
  switch (type) {
    case ProductsTagType.POPULAR:
      return 'Popular';
    case ProductsTagType.FEATURED:
      return 'featured';
    default:
      return 'Popular';
  }
}
