// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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

import 'package:woocommerce/woocommerce.dart';

import '../../../developer/dev.log.dart';
import '../enums/sort_option.dart';

class WooUtils {
  /// Returns a map of categories sorted in to their parent-child
  /// relation
  static Map<WooProductCategory, List<WooProductCategory>> sortCategories(
    List<WooProductCategory> data,
  ) {
    try {
      final d = List<WooProductCategory>.from(data);
      final Map<WooProductCategory, List<WooProductCategory>> result = {};
      // Get the parent categories
      d.removeWhere((element) {
        if (element == null) {
          return true;
        }
        if (element.parent <= 0) {
          result.addAll({element: <WooProductCategory>[]});
          return true;
        }
        return false;
      });

      // Sort child categories with parents
      for (final item in d) {
        // Find the parent key
        final parentKey = result.keys.firstWhere(
          (element) => element.id == item.parent,
          orElse: () => null,
        );

        // There is no parent found, add the item to the map as a parent
        if (parentKey == null) {
          result.addAll({item: []});
          continue;
        }

        result.update(
          parentKey,
          (value) {
            value.add(item);
            return value;
          },
          ifAbsent: () {
            return <WooProductCategory>[];
          },
        );
      }
      return result;
    } catch (e, s) {
      Dev.error('Sort Categories error', error: e, stackTrace: s);
      return {};
    }
  }

  /// Remove all the HTML tags from the text
  static String removeAllHtmlTags(String htmlText) {
    if (htmlText == null) {
      return null;
    }
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  /// Converts the sort option object to string
  static String convertSortOptionToString(SortOption option) {
    switch (option) {
      case SortOption.popularity:
        return 'popularity';
        break;
      case SortOption.rating:
        return 'rating';
        break;
      case SortOption.latest:
        return 'date';
        break;
      case SortOption.lowToHigh:
        return 'price';
        break;
      case SortOption.highToLow:
        return 'price';
        break;
      default:
        return 'date';
    }
  }

  static String setSortOrder(SortOption option) {
    if (option == SortOption.lowToHigh) {
      return 'asc';
    }
    return 'desc';
  }
}
