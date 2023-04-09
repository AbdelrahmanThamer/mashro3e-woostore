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

import 'package:flutter/foundation.dart';

import '../developer/dev.log.dart';

/// ## Description
///
/// Holds the custom data from WordPress to show products, layout and other
/// properties.
///
@immutable
class CustomProductSectionData {
  /// The ID of the tag which will be used to fetch the products as filter.
  /// Must be an INT
  final int tagId;

  /// The type of layout that this particular section must set which will be
  /// used to render the items on the screen.
  ///
  /// Currently only supported layouts are:
  ///
  /// 1. `list
  /// 2. `grid`
  ///
  /// By default the type `list` is used
  final ProductSectionLayoutType layoutType;

  /// Flag to decide if Flutter should build Widget related to this data
  /// If this flag is `FALSE`, application must not even call the fetch
  /// method on this data information
  final bool show;

  /// Tag name to display as a heading
  final String tagName;

  /// The ID for a specific section from the backend
  final int sectionId;

  /// The position of the section in the home page
  final int position;

  //<editor-fold desc="Data Methods">

  const CustomProductSectionData({
    @required this.tagId,
    this.layoutType,
    this.show,
    this.tagName,
    this.sectionId,
    this.position,
  });

  const CustomProductSectionData.empty({
    this.tagId = 0,
    this.layoutType = ProductSectionLayoutType.list,
    this.show = false,
    this.tagName = '',
    this.sectionId = 0,
    this.position = 0,
  });

  CustomProductSectionData copyWith({
    int tagId,
    ProductSectionLayoutType layoutType,
    bool show,
    String tagName,
    int sectionId,
    int position,
  }) {
    if ((tagId == null || identical(tagId, this.tagId)) &&
        (layoutType == null || identical(layoutType, this.layoutType)) &&
        (show == null || identical(show, this.show)) &&
        (tagName == null || identical(tagName, this.tagName)) &&
        (sectionId == null || identical(sectionId, this.sectionId)) &&
        (position == null || identical(position, this.position))) {
      return this;
    }

    return CustomProductSectionData(
      tagId: tagId ?? this.tagId,
      layoutType: layoutType ?? this.layoutType,
      show: show ?? this.show,
      tagName: tagName ?? this.tagName,
      sectionId: sectionId ?? this.sectionId,
      position: position ?? this.position,
    );
  }

  @override
  String toString() {
    return 'CustomProductSection{tagId: $tagId, layoutType: $layoutType, show: $show, tagName: $tagName, sectionId: $sectionId, position: $position}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomProductSectionData &&
          runtimeType == other.runtimeType &&
          tagId == other.tagId &&
          layoutType == other.layoutType &&
          show == other.show &&
          tagName == other.tagName &&
          sectionId == other.sectionId &&
          position == other.position);

  @override
  int get hashCode =>
      tagId.hashCode ^
      layoutType.hashCode ^
      show.hashCode ^
      tagName.hashCode ^
      sectionId.hashCode ^
      position.hashCode;

  factory CustomProductSectionData.fromMap(Map<String, dynamic> map) {
    try {
      return CustomProductSectionData(
        tagId: int.parse(map['acf']['tag']['term_id'].toString()),
        tagName: map['acf']['tag']['name'] as String,
        layoutType: _convertStringToPSLT(map['acf']['layout_type']),
        show: map['acf']['show'] as bool,
        position: int.parse(map['acf']['position']),
        sectionId: int.parse(map['id'].toString()),
      );
    } catch (e) {
      Dev.error(e);
      return const CustomProductSectionData.empty();
    }
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'tagId': tagId,
      'layoutType': _getStringFrom(layoutType),
      'show': show,
      'tagName': tagName,
      'sectionId': sectionId,
      'position': position,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  /// Converts a string value to ProductSectionLayoutType enum
  static ProductSectionLayoutType _convertStringToPSLT(String value) {
    if (value == null) {
      return ProductSectionLayoutType.list;
    }
    final temp = value.toLowerCase();
    switch (temp) {
      case 'list':
        return ProductSectionLayoutType.list;
        break;
      case 'grid':
        return ProductSectionLayoutType.grid;
        break;
      default:
        return ProductSectionLayoutType.list;
    }
  }

  /// Converts a ProductSectionLayoutType value a string
  static String _getStringFrom(ProductSectionLayoutType value) {
    if (value == null) {
      return null;
    }
    switch (value) {
      case ProductSectionLayoutType.list:
        return 'list';
        break;
      case ProductSectionLayoutType.grid:
        return 'grid';
        break;
      default:
        return 'list';
    }
  }
}

/// ## Description
///
/// Layout type which decides which design of the related widget should
/// be rendered
enum ProductSectionLayoutType {
  list,
  grid,
}
