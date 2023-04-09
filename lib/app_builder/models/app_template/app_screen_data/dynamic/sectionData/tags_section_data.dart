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

part of '../customSectionData.dart';

enum TagsSectionLayoutType {
  horizontalList,
  verticalList,
  grid,
  wrap,
}

@immutable
class TagsSectionData extends CustomSectionData {
  final TagsSectionLayoutType layout;
  final int columns;
  final double height;
  final List<TagData> items;
  final StyledData itemStyledData;

  const TagsSectionData({
    required int id,
    required String name,
    required this.layout,
    required this.items,
    this.columns = 3,
    this.height = 100,
    required bool show,
    required StyledData styledData,
    this.itemStyledData = const StyledData(
      marginData: MarginData(left: 5, top: 5),
      paddingData: PaddingData(left: 5, right: 5, top: 5, bottom: 5),
    ),
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.tags,
          styledData: styledData,
        );

  TagsSectionData.empty({
    this.layout = TagsSectionLayoutType.horizontalList,
    this.columns = 3,
    this.height = 100,
    this.items = const [],
    this.itemStyledData = const StyledData(
      marginData: MarginData(left: 5, top: 5),
      paddingData: PaddingData(left: 5, right: 5, top: 5, bottom: 5),
    ),
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Tag Section',
          show: false,
          sectionType: SectionType.tags,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'layout': layout.name,
      'columns': columns,
      'height': height,
      'items': items.map((e) => e.toMap()).toList(),
      'itemStyledData': itemStyledData.toMap(),
    };
  }

  factory TagsSectionData.fromMap(Map<String, dynamic> map) {
    return TagsSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      layout: convertStringToSectionLayout(map['layout']),
      columns: ModelUtils.createIntProperty(map['columns']),
      height: ModelUtils.createDoubleProperty(map['height']),
      items: ModelUtils.createListOfType<TagData>(
        map['items'],
        (elem) => TagData.fromMap(elem),
      ),
      show: ModelUtils.createBoolProperty(map['show']),
      name: ModelUtils.createStringProperty(map['name']),
      styledData: StyledData.fromMap(map['styledData']),
      itemStyledData: StyledData.fromMap(map['itemStyledData']),
    );
  }

  @override
  TagsSectionData copyWith({
    int? id,
    TagsSectionLayoutType? layout,
    int? columns,
    double? height,
    List<TagData>? items,
    bool? show,
    String? name,
    StyledData? styledData,
    StyledData? itemStyledData,
  }) {
    return TagsSectionData(
      id: id ?? this.id,
      layout: layout ?? this.layout,
      columns: columns ?? this.columns,
      height: height ?? this.height,
      items: items ?? this.items,
      show: show ?? this.show,
      name: name ?? this.name,
      styledData: styledData ?? this.styledData,
      itemStyledData: itemStyledData ?? this.itemStyledData,
    );
  }

  /// Converts a string value to SectionLayout enum
  static TagsSectionLayoutType convertStringToSectionLayout(String? value) {
    if (value == null) {
      return TagsSectionLayoutType.horizontalList;
    }
    switch (value) {
      case 'horizontalList':
        return TagsSectionLayoutType.horizontalList;

      case 'verticalList':
        return TagsSectionLayoutType.verticalList;

      case 'grid':
        return TagsSectionLayoutType.grid;

      case 'wrap':
        return TagsSectionLayoutType.wrap;

      default:
        return TagsSectionLayoutType.horizontalList;
    }
  }
}
