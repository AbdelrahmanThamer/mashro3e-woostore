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

import 'product_card_layout/product_card_layout.dart';

enum ProductListType {
  grid,
  list,
  verticalList,
}

@immutable
class ProductListConfig {
  final ProductCardLayoutData layoutData;
  final double itemPadding;
  final bool useGlobalProductCardLayout;
  final ProductListType listType;
  final int gridColumns;

  const ProductListConfig({
    this.layoutData = const ProductCardLayoutData(),
    this.itemPadding = 5,
    this.useGlobalProductCardLayout = true,
    this.listType = ProductListType.grid,
    this.gridColumns = 2,
  });

  Map<String, dynamic> toMap() {
    return {
      'layoutData': layoutData.toMap(),
      'itemPadding': itemPadding,
      'useGlobalProductCardLayout': useGlobalProductCardLayout,
      'listType': listType.name,
      'gridColumn': gridColumns,
    };
  }

  factory ProductListConfig.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const ProductListConfig();
    }
    return ProductListConfig(
      layoutData: ProductCardLayoutData.fromMap(map['layoutData']),
      itemPadding: ModelUtils.createDoubleProperty(map['itemPadding'], 5),
      useGlobalProductCardLayout: ModelUtils.createBoolProperty(
        map['useGlobalProductCardLayout'],
        true,
      ),
      listType: _getListType(map['listType']),
      gridColumns: ModelUtils.createIntProperty(map['gridColumns'], 2),
    );
  }

  ProductListConfig copyWith({
    ProductCardLayoutData? layoutData,
    double? itemPadding,
    bool? useGlobalProductCardLayout,
    ProductListType? listType,
    int? gridColumns,
  }) {
    return ProductListConfig(
      layoutData: layoutData ?? this.layoutData,
      itemPadding: itemPadding ?? this.itemPadding,
      useGlobalProductCardLayout:
          useGlobalProductCardLayout ?? this.useGlobalProductCardLayout,
      listType: listType ?? this.listType,
      gridColumns: gridColumns ?? this.gridColumns,
    );
  }

  //**********************************************************
  // Helpers
  //**********************************************************

  static ProductListType _getListType(String? name) {
    switch (name) {
      case 'list':
        return ProductListType.list;

      case 'grid':
        return ProductListType.grid;

      case 'verticalList':
        return ProductListType.verticalList;

      default:
        return ProductListType.grid;
    }
  }
}
