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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/foundation.dart';

@immutable
class FilterConfigData {
  final double minPrice;
  final double maxPrice;
  final int priceRangeDivisions;
  final int itemsPerPage;

  const FilterConfigData({
    this.minPrice = 0,
    this.maxPrice = 10000,
    this.priceRangeDivisions = 10,
    this.itemsPerPage = 10,
  });

  factory FilterConfigData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const FilterConfigData();
    }
    return FilterConfigData(
      minPrice: ModelUtils.createDoubleProperty(map['minPrice'], 0),
      maxPrice: ModelUtils.createDoubleProperty(map['maxPrice'], 10000),
      priceRangeDivisions:
          ModelUtils.createIntProperty(map['priceRangeDivisions'], 10),
      itemsPerPage: ModelUtils.createIntProperty(map['itemsPerPage'], 10),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'priceRangeDivisions': priceRangeDivisions,
      'itemsPerPage': itemsPerPage,
    };
  }

  FilterConfigData copyWith({
    double? minPrice,
    double? maxPrice,
    int? priceRangeDivisions,
    int? itemsPerPage,
  }) {
    return FilterConfigData(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      priceRangeDivisions: priceRangeDivisions ?? this.priceRangeDivisions,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
    );
  }
}
