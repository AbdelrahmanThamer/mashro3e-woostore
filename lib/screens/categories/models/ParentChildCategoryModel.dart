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

import '../../../services/woocommerce/woocommerce.service.dart';

/// Holds the parent and associated children categories
class ParentChildCategoryModel {
  final WooProductCategory? parentCategory;
  final List<WooProductCategory>? childrenCategories;

  const ParentChildCategoryModel({
    this.parentCategory,
    this.childrenCategories,
  });
}
