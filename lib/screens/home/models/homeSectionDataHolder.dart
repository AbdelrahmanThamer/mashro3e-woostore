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

import 'package:flutter/cupertino.dart';

import '../../../services/woocommerce/woocommerce.service.dart';

/// Data holder to identify the home section object in the map based on
/// these entries
class HomeSectionDataHolder {
  final int id;
  final WooProductCategory category;
  final WooProductTag tag;

  factory HomeSectionDataHolder({
    WooProductTag wooProductTag,
    WooProductCategory wooProductCategory,
  }) {
    if (wooProductTag == null && wooProductCategory == null) {
      return const HomeSectionDataHolder.empty();
    }

    // Create an ID instance
    int _id = 0;
    String idString = '0';

    if (wooProductTag != null) {
      idString += wooProductTag.id.toString();
    }

    if (wooProductCategory != null) {
      idString += wooProductCategory.id.toString();
    }

    _id = int.parse(idString);

    return HomeSectionDataHolder._(
      id: _id,
      category: wooProductCategory,
      tag: wooProductTag,
    );
  }

  @protected
  const HomeSectionDataHolder._({
    this.id,
    this.category,
    this.tag,
  });

  const HomeSectionDataHolder.empty({
    this.id,
    this.category,
    this.tag,
  });

  @override
  String toString() {
    return 'HomeSectionDataHolder{id: $id, category: $category, tag: $tag}';
  }
}
