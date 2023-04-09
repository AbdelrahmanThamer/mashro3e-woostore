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

import 'package:collection/collection.dart';

import '../../../developer/dev.log.dart';
import '../../../locator.dart';
import '../../../providers/utils/baseProvider.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../models/ParentChildCategoryModel.dart';

///
/// ## Description
///
/// Contains all the categories for the products that the application has to
/// offer
class CategoriesProvider extends BaseProvider {
  /// Categories for the products offered in the application
  List<WooProductCategory> _categoryListBig = const [];

  List<WooProductCategory> get categoryListBig => _categoryListBig;

  /// Parent-child relation of the categories as a map with
  /// parent-key and array list of child categories.
  Map<WooProductCategory, List<WooProductCategory>> _categoriesMap = const {};

  Map<WooProductCategory, List<WooProductCategory>> get categoriesMap =>
      _categoriesMap;

  //**********************************************************
  //  Main Functions
  //**********************************************************

  /// Get the categories for the application
  Future<Map<WooProductCategory, List<WooProductCategory>>> getCategories(
      {bool forced = false}) async {
    if (_categoryListBig.isNotEmpty && !forced) {
      return <WooProductCategory, List<WooProductCategory>>{};
    }
    notifyLoading();
    try {
      final List<WooProductCategory> _result =
          await LocatorService.wooService().getCategories();
      _categoryListBig = _result;
      _categoriesMap = WooUtils.sortCategories(_result);
      notifyState(ViewState.DATA_AVAILABLE);
      return _categoriesMap;
    } catch (e, s) {
      Dev.error('Get categories error', error: e, stackTrace: s);
      notifyError(message: '');
      return <WooProductCategory, List<WooProductCategory>>{};
    }
  }

  /// Returns the categories as model classes which hold
  /// parent and associated child categories
  List<ParentChildCategoryModel> getCategoriesAsModels() {
    if (categoriesMap.isEmpty) {
      return const [];
    }
    final List<ParentChildCategoryModel> result = [];
    categoriesMap.forEach((key, value) {
      final temp = ParentChildCategoryModel(
        parentCategory: key,
        childrenCategories: value,
      );

      result.add(temp);
    });
    return result;
  }

  WooProductCategory? findCategoryById(int categoryId) {
    return categoryListBig.firstWhereOrNull((elem) => elem.id == categoryId);
  }
}
