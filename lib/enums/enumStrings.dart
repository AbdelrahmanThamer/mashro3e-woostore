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

import 'enums.dart';

///
/// `Description`
///
/// File holds the functions to convert `ENUM` to `Strings`
///
class ConvertEnum {
  /// Convert `CardType` to `String`
  static String cardTypeToString(CardType type) {
    switch (type) {
      case CardType.MASTER:
        return 'Master';
        break;

      case CardType.VISA:
        return 'Visa';
        break;

      case CardType.NOT_DEFINED:
        return 'Not Defined';
        break;

      default:
        return 'Not Defined';
    }
  }

  /// Convert `Search Product For` to `String`
  static String searchProductForToString(SearchProductFor type) {
    switch (type) {
      case SearchProductFor.Men:
        return 'men';
        break;

      case SearchProductFor.Women:
        return 'women';
        break;

      case SearchProductFor.Kids:
        return 'kids';
        break;

      case SearchProductFor.All:
        return 'all';
        break;

      case SearchProductFor.Not_Defined:
        return 'not_defined';
        break;

      default:
        return 'all';
    }
  }

  static String productCategoryTypeToString(ProductCategoryType type) {
    switch (type) {
      case ProductCategoryType.Clothing:
        return 'clothing';
        break;
      case ProductCategoryType.Bags:
        return 'bags';
        break;
      case ProductCategoryType.Accessories:
        return 'accessories';
        break;
      case ProductCategoryType.Footwear:
        return 'footwear';
        break;
      case ProductCategoryType.Jeans:
        return 'jeans';
        break;
      case ProductCategoryType.Shirts:
        return 'shirts';
        break;
      case ProductCategoryType.Shoes:
        return 'shoes';
        break;
      case ProductCategoryType.T_Shirts:
        return 't_shirts';
        break;
      case ProductCategoryType.Watch:
        return 'watch';
        break;
      default:
        return 'clothing';
    }
  }
}
