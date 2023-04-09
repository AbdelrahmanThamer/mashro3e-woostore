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

part of '../customSectionData.dart';

enum CategorySectionLayoutType {
  horizontalList,
  verticalList,
  grid,
  wrap,
}

@immutable
class CategoriesSectionData extends CustomSectionData {
  final CategorySectionLayoutType layout;
  final int columns;
  final DimensionsData itemDimensionsData;
  final bool showAll;
  final List<CategoryData> categories;
  final StyledData itemStyledData;
  final bool showLabel;

  const CategoriesSectionData({
    required int id,
    required String name,
    required this.layout,
    required bool show,
    this.columns = 3,
    this.itemDimensionsData = const DimensionsData(
      height: 100,
      width: 100,
      aspectRatio: 1,
    ),
    this.showAll = false,
    this.showLabel = false,
    required this.categories,
    required StyledData styledData,
    this.itemStyledData = const StyledData(
      marginData: MarginData(left: 2, right: 2),
    ),
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.categories,
          styledData: styledData,
        );

  CategoriesSectionData.empty({
    this.layout = CategorySectionLayoutType.horizontalList,
    this.columns = 3,
    this.itemDimensionsData = const DimensionsData(
      height: 100,
      width: 100,
      aspectRatio: 1,
    ),
    this.categories = const [],
    this.showAll = false,
    this.showLabel = false,
    this.itemStyledData = const StyledData(),
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Categories Section',
          show: false,
          sectionType: SectionType.categories,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'layout': layout.name,
      'columns': columns,
      'categories': _createCategoriesMap(),
      'showAll': showAll,
      'showLabel': showLabel,
      'itemDimensionsData': itemDimensionsData.toMap(),
      'itemStyledData': itemStyledData.toMap(),
    };
  }

  List<Map> _createCategoriesMap() {
    final temp = <Map>[];
    for (final obj in categories) {
      temp.add(obj.toMap());
    }
    return temp;
  }

  factory CategoriesSectionData.fromMap(Map<String, dynamic> map) {
    return CategoriesSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      layout: convertStringToSectionLayout(map['layout']),
      columns: ModelUtils.createIntProperty(map['columns']),
      itemDimensionsData: DimensionsData.fromMap(map['itemDimensionsData']),
      show: ModelUtils.createBoolProperty(map['show']),
      categories: createList(map['categories']),
      name: ModelUtils.createStringProperty(map['name']),
      showAll: ModelUtils.createBoolProperty(map['showAll']),
      showLabel: ModelUtils.createBoolProperty(map['showLabel'], false),
      styledData: StyledData.fromMap(map['styledData']),
      itemStyledData: StyledData.fromMap(map['itemStyledData']),
    );
  }

  static List<CategoryData> createList(dynamic list) {
    if (list == null || list is! List) {
      return const [];
    }

    try {
      final temp = <CategoryData>[];
      for (final e in List<Map<String, dynamic>>.from(list)) {
        temp.add(CategoryData.fromMap(e));
      }

      return temp;
    } catch (_) {
      return const [];
    }
  }

  @override
  CategoriesSectionData copyWith({
    int? id,
    CategorySectionLayoutType? layout,
    int? columns,
    List<CategoryData>? categories,
    bool? show,
    bool? showAll,
    bool? showLabel,
    String? name,
    StyledData? styledData,
    MarginData? marginData,
    StyledData? itemStyledData,
    DimensionsData? itemDimensionsData,
  }) {
    return CategoriesSectionData(
      id: id ?? this.id,
      layout: layout ?? this.layout,
      columns: columns ?? this.columns,
      itemDimensionsData: itemDimensionsData ?? this.itemDimensionsData,
      categories: categories ?? this.categories,
      show: show ?? this.show,
      showAll: showAll ?? this.showAll,
      showLabel: showLabel ?? this.showLabel,
      name: name ?? this.name,
      styledData: styledData ?? this.styledData,
      itemStyledData: itemStyledData ?? this.itemStyledData,
    );
  }

  /// Converts a string value to SectionLayout enum
  static CategorySectionLayoutType convertStringToSectionLayout(String? value) {
    if (value == null) {
      return CategorySectionLayoutType.horizontalList;
    }
    switch (value) {
      case 'horizontalList':
        return CategorySectionLayoutType.horizontalList;

      case 'verticalList':
        return CategorySectionLayoutType.verticalList;

      case 'grid':
        return CategorySectionLayoutType.grid;

      case 'wrap':
        return CategorySectionLayoutType.wrap;

      default:
        return CategorySectionLayoutType.horizontalList;
    }
  }
}
