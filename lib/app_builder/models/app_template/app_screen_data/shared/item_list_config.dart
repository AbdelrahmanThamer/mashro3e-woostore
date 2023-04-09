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

enum ItemListType {
  grid,
  list,
  verticalList,
  wrap,
}

@immutable
class ItemListConfig {
  final double itemPadding;
  final ItemListType listType;
  final int gridColumns;
  final double aspectRatio;

  const ItemListConfig({
    this.itemPadding = 5,
    this.listType = ItemListType.list,
    this.gridColumns = 2,
    this.aspectRatio = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemPadding': itemPadding,
      'listType': listType.name,
      'gridColumn': gridColumns,
      'aspectRatio': aspectRatio,
    };
  }

  factory ItemListConfig.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const ItemListConfig();
    }
    return ItemListConfig(
      itemPadding: ModelUtils.createDoubleProperty(map['itemPadding'], 5),
      listType: _getListType(map['listType']),
      gridColumns: ModelUtils.createIntProperty(map['gridColumns'], 2),
      aspectRatio: ModelUtils.createDoubleProperty(map['aspectRatio'], 1),
    );
  }

  ItemListConfig copyWith({
    double? itemPadding,
    double? aspectRatio,
    ItemListType? listType,
    int? gridColumns,
  }) {
    return ItemListConfig(
      itemPadding: itemPadding ?? this.itemPadding,
      listType: listType ?? this.listType,
      gridColumns: gridColumns ?? this.gridColumns,
      aspectRatio: aspectRatio ?? this.aspectRatio,
    );
  }

  //**********************************************************
  // Helpers
  //**********************************************************

  static ItemListType _getListType(String? name) {
    switch (name) {
      case 'list':
        return ItemListType.list;

      case 'grid':
        return ItemListType.grid;

      case 'wrap':
        return ItemListType.wrap;

      case 'verticalList':
        return ItemListType.verticalList;

      default:
        return ItemListType.list;
    }
  }
}
