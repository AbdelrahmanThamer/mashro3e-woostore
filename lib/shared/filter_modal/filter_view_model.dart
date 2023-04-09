// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:flutter/foundation.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../locator.dart';
import '../../services/woocommerce/mixins/filter_mixin.dart';
import '../../services/woocommerce/models/models.dart';

class FilterViewModel with ChangeNotifier, WooFiltersMixin {
  /// This getter depends on `CategoriesProvider` to get the categories
  /// for the Filter modal
  Map<WooProductCategory, List<WooProductCategory>> get categoriesMap =>
      LocatorService.categoriesProvider().categoriesMap;

  /// Getter for tags for filtering
  List<WooProductTag> get tags => LocatorService.tagsViewModel().tags;

  final String? tagId;
  final String? categoryId;
  final Function onApplyFilters;

  FilterViewModel({
    this.tagId,
    this.categoryId,
    required this.onApplyFilters,
  }) {
    init();
  }

  void init() {
    if (isNotBlank(tagId)) {
      filters = filters.copyWith(tagId: int.tryParse(tagId!) ?? 0);
    }
    if (isNotBlank(categoryId)) {
      setCategoryOnInstantiation(categoryId!);
    }

    // start fetching the categories
    if (LocatorService.categoriesProvider().categoriesMap.isEmpty) {
      LocatorService.categoriesProvider().getCategories();
    }

    // start fetching the tags
    if (LocatorService.tagsViewModel().tags.isEmpty) {
      LocatorService.tagsViewModel().getTags();
    }
  }

  void setCategoryOnInstantiation(String categoryId) {
    int resultParentCatId = 0;
    int resultChildCatId = 0;
    for (var i = 0; i < categoriesMap.keys.length; ++i) {
      final parentCat = categoriesMap.keys.elementAt(i);
      // Find for the parent id
      if (parentCat.id.toString() == categoryId) {
        resultParentCatId = int.tryParse(categoryId) ?? 0;

        // If you find a match then break out of the loop as
        // action.categoryData.categoryId can be associated with
        // only a single category
        break;
      }

      // Find for the child category
      if (categoriesMap[parentCat] != null &&
          categoriesMap[parentCat]!.isNotEmpty) {
        for (final childCat in categoriesMap[parentCat]!) {
          if (childCat.id.toString() == categoryId) {
            resultParentCatId = parentCat.id ?? 0;
            resultChildCatId = int.tryParse(categoryId) ?? 0;

            // Break out of this loop as both parent and child
            // categories have been found
            break;
          }
        }
      }
      if (resultParentCatId > 0) {
        // break out of the parent loop if parent id has been found
        break;
      }
    }

    // Set the parent category to be the passed category if you do no find
    // any matching category
    filters = filters.copyWith(
      parentCategoryId:
          resultParentCatId <= 0 ? int.tryParse(categoryId) : resultParentCatId,
      childCategoryId: resultChildCatId,
    );
  }

  @override
  void dispose() {
    super.dispose();
    filters = const WooStoreFilters();
  }
}
