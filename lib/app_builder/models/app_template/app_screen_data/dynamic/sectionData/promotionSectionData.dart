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

part of '../customSectionData.dart';

@immutable
class PromotionSectionData extends CustomSectionData {
  final SectionLayout layout;
  final DimensionsData itemDimensionsData;
  final List<String> images;
  final double itemBorderRadius;
  final String title;
  final AppAction action;
  final BoxFit itemImageBoxFit;
  final double itemPadding;
  final int columns;

  const PromotionSectionData({
    required int id,
    required String name,
    required this.layout,
    this.itemDimensionsData = const DimensionsData(),
    required this.images,
    required this.title,
    this.itemBorderRadius = 10,
    required bool show,
    required StyledData styledData,
    this.action = const NoAction(),
    this.itemImageBoxFit = BoxFit.cover,
    this.itemPadding = 5,
    this.columns = 2,
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.promotion,
          styledData: styledData,
        );

  PromotionSectionData.empty({
    this.title = '',
    this.itemDimensionsData = const DimensionsData(),
    this.itemBorderRadius = 10,
    this.images = const [],
    this.layout = SectionLayout.horizontalList,
    this.action = const NoAction(),
    this.itemImageBoxFit = BoxFit.cover,
    this.itemPadding = 5,
    this.columns = 2,
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Promotion Section',
          show: false,
          sectionType: SectionType.promotion,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'title': title,
      'layout': layout.name,
      'itemDimensionsData': itemDimensionsData.toMap(),
      'itemBorderRadius': itemBorderRadius,
      'images': images,
      'action': action.toMap(),
      'itemImageBoxFit': itemImageBoxFit.name,
      'itemPadding': itemPadding,
      'columns': columns,
    };
  }

  factory PromotionSectionData.fromMap(Map<String, dynamic> map) {
    try {
      return PromotionSectionData(
        id: ModelUtils.createIntProperty(map['id']),
        title: ModelUtils.createStringProperty(map['title']),
        layout: CustomSectionUtils.convertStringToSectionLayout(map['layout']),
        itemDimensionsData: DimensionsData.fromMap(map['itemDimensionsData']),
        images: ModelUtils.createListStrings(map['images']),
        show: ModelUtils.createBoolProperty(map['show']),
        name: ModelUtils.createStringProperty(map['name']),
        itemBorderRadius:
            ModelUtils.createDoubleProperty(map['itemBorderRadius'], 10),
        itemPadding: ModelUtils.createDoubleProperty(map['itemPadding'], 5),
        styledData: StyledData.fromMap(map['styledData']),
        action: AppAction.createActionFromMap(map['action']),
        itemImageBoxFit:
            EnumUtils.convertStringToBoxFit(map['itemImageBoxFit']),
        columns: ModelUtils.createIntProperty(map['columns'], 2),
      );
    } catch (_) {
      return PromotionSectionData.empty();
    }
  }

  @override
  PromotionSectionData copyWith({
    int? id,
    SectionLayout? layout,
    DimensionsData? itemDimensionsData,
    List<String>? images,
    String? title,
    bool? show,
    double? itemBorderRadius,
    String? name,
    StyledData? styledData,
    AppAction? action,
    BoxFit? itemImageBoxFit,
    double? itemPadding,
    int? columns,
  }) {
    return PromotionSectionData(
      id: id ?? this.id,
      layout: layout ?? this.layout,
      itemDimensionsData: itemDimensionsData ?? this.itemDimensionsData,
      images: images ?? this.images,
      title: title ?? this.title,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      itemImageBoxFit: itemImageBoxFit ?? this.itemImageBoxFit,
      show: show ?? this.show,
      name: name ?? this.name,
      styledData: styledData ?? this.styledData,
      action: action ?? this.action,
      itemPadding: itemPadding ?? this.itemPadding,
      columns: columns ?? this.columns,
    );
  }
}
