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

import '../../../../../developer/dev.log.dart';
import '../../../../../services/woocommerce/woocommerce.service.dart';

/// Holds some utility functions used by sections data model classes
abstract class SectionDataUtils {
  /// Creates and extracts the WooProductTag from the given Map
  static WooProductTag extractTag(Map<String, dynamic> tagDataMap) {
    if (tagDataMap == null) {
      Dev.info('dataMap is null, returning');
      return null;
    }

    WooProductTag result;

    // RESPONSE DATA
    // "term_id": 43,
    // "name": "Featured",
    // "slug": "featured",
    // "term_group": 0,
    // "term_taxonomy_id": 43,
    // "taxonomy": "product_tag",
    // "description": "Featured items to be tagged with this particular tag",
    // "parent": 0,
    // "count": 8,
    // "filter": "raw"

    // For ID
    int id;
    try {
      if (tagDataMap['term_id'] != null) {
        if (tagDataMap['term_id'] is int) {
          id = tagDataMap['term_id'];
        } else {
          id = int.parse(tagDataMap['term_id'].toString());
        }
      }
    } catch (e, s) {
      // For any error to get the ID of the tag object, return null as
      // ID is the required param for any tag. Other errors doesn't
      // matter
      Dev.error('', error: e, stackTrace: s);
      return result;
    }

    // For count
    int count;
    try {
      if (tagDataMap['count'] != null) {
        if (tagDataMap['count'] is int) {
          count = tagDataMap['count'];
        } else {
          count = int.parse(tagDataMap['count'].toString());
        }
      }
    } catch (_) {
      count = 0;
    }

    result = WooProductTag(
      id: id,
      name: tagDataMap['name'] ?? '',
      slug: tagDataMap['slug'] ?? '',
      description: tagDataMap['description'] ?? '',
      count: count,
    );

    return result;
  }

  /// Creates and extracts the WooProductCategory from the given Map
  static WooProductCategory extractCategory(
      Map<String, dynamic> categoryDataMap) {
    if (categoryDataMap == null) {
      Dev.info('dataMap is null, returning');
      return null;
    }
    WooProductCategory result;

    // RESPONSE DATA
    // "term_id": 44,
    // "name": "Women",
    // "slug": "women",
    // "term_group": 0,
    // "term_taxonomy_id": 44,
    // "taxonomy": "product_cat",
    // "description": "The category for all women products",
    // "parent": 0,
    // "count": 10,
    // "filter": "raw"

    // For ID
    int id;
    try {
      if (categoryDataMap['term_id'] != null) {
        if (categoryDataMap['term_id'] is int) {
          id = categoryDataMap['term_id'];
        } else {
          id = int.parse(categoryDataMap['term_id'].toString());
        }
      }
    } catch (e, s) {
      // For any error to get the ID of the category object, return null as
      // ID is the required param for any category. Other errors doesn't
      // matter
      Dev.error('', error: e, stackTrace: s);
      return result;
    }

    // For parent id
    int parent;
    try {
      if (categoryDataMap['parent'] != null) {
        if (categoryDataMap['parent'] is int) {
          parent = categoryDataMap['parent'];
        } else {
          parent = int.parse(categoryDataMap['parent'].toString());
        }
      }
    } catch (_) {
      parent = 0;
    }

    // For count
    int count;
    try {
      if (categoryDataMap['count'] != null) {
        if (categoryDataMap['count'] is int) {
          count = categoryDataMap['count'];
        } else {
          count = int.parse(categoryDataMap['count'].toString());
        }
      }
    } catch (_) {
      count = 0;
    }

    result = WooProductCategory(
      id: id,
      name: categoryDataMap['name'] ?? '',
      slug: categoryDataMap['slug'] ?? '',
      description: categoryDataMap['description'] ?? '',
      parent: parent,
      count: count,
    );

    return result;
  }
}
