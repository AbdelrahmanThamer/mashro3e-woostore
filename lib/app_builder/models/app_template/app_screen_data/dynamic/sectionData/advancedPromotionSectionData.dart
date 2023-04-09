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

@immutable
class AdvancedPromotionSectionData extends CustomSectionData {
  final SectionLayout layout;
  final DimensionsData itemDimensionsData;
  final double itemPadding;
  final double itemBorderRadius;
  final bool showLabel;
  final List<AdvancedPromotionSectionDataItem> items;
  final BoxFit itemImageBoxFit;
  final int columns;

  const AdvancedPromotionSectionData({
    required int id,
    required String name,
    required this.layout,
    required bool show,
    required this.items,
    this.itemDimensionsData = const DimensionsData(),
    this.itemBorderRadius = 10,
    this.showLabel = false,
    this.itemPadding = 5,
    this.itemImageBoxFit = BoxFit.cover,
    required StyledData styledData,
    this.columns = 2,
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.advancedPromotion,
          styledData: styledData,
        );

  AdvancedPromotionSectionData.empty({
    this.items = const [],
    this.layout = SectionLayout.horizontalList,
    this.itemDimensionsData = const DimensionsData(),
    this.itemBorderRadius = 10,
    this.showLabel = false,
    this.itemImageBoxFit = BoxFit.cover,
    this.itemPadding = 5,
    this.columns = 2,
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          show: false,
          name: 'Advanced Promotion Section',
          sectionType: SectionType.advancedPromotion,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'items': items.map((e) => e.toMap()).toList(),
      'layout': layout.name,
      'itemDimensionsData': itemDimensionsData.toMap(),
      'itemBorderRadius': itemBorderRadius,
      'showLabel': showLabel,
      'itemImageBoxFit': itemImageBoxFit.name,
      'itemPadding': itemPadding,
      'columns': columns,
    };
  }

  factory AdvancedPromotionSectionData.fromMap(Map<String, dynamic> map) {
    try {
      return AdvancedPromotionSectionData(
        id: ModelUtils.createIntProperty(map['id']),
        layout: CustomSectionUtils.convertStringToSectionLayout(map['layout']),
        itemDimensionsData: DimensionsData.fromMap(map['itemDimensionsData']),
        itemBorderRadius:
            ModelUtils.createDoubleProperty(map['itemBorderRadius']),
        showLabel: ModelUtils.createBoolProperty(map['showLabel']),
        items: ModelUtils.createListOfType<AdvancedPromotionSectionDataItem>(
          map['items'],
          (elem) => AdvancedPromotionSectionDataItem.fromMap(elem),
        ),
        show: ModelUtils.createBoolProperty(map['show']),
        name: ModelUtils.createStringProperty(map['name']),
        styledData: StyledData.fromMap(map['styledData']),
        itemImageBoxFit:
            EnumUtils.convertStringToBoxFit(map['itemImageBoxFit']),
        itemPadding: ModelUtils.createDoubleProperty(map['itemPadding'], 5),
        columns: ModelUtils.createIntProperty(map['columns'], 2),
      );
    } catch (_) {
      return AdvancedPromotionSectionData.empty();
    }
  }

  @override
  AdvancedPromotionSectionData copyWith({
    int? id,
    List<AdvancedPromotionSectionDataItem>? items,
    bool? show,
    DimensionsData? itemDimensionsData,
    double? itemBorderRadius,
    bool? showLabel,
    SectionLayout? layout,
    String? name,
    StyledData? styledData,
    BoxFit? itemImageBoxFit,
    double? itemPadding,
    int? columns,
  }) {
    return AdvancedPromotionSectionData(
      id: id ?? this.id,
      items: items ?? this.items,
      show: show ?? this.show,
      itemDimensionsData: itemDimensionsData ?? this.itemDimensionsData,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      showLabel: showLabel ?? this.showLabel,
      layout: layout ?? this.layout,
      name: name ?? this.name,
      styledData: styledData ?? this.styledData,
      itemImageBoxFit: itemImageBoxFit ?? this.itemImageBoxFit,
      itemPadding: itemPadding ?? this.itemPadding,
      columns: columns ?? this.columns,
    );
  }
}

@immutable
class AdvancedPromotionSectionDataItem {
  final int id;
  final String imageUrl;
  final String title;
  final AppAction action;

  const AdvancedPromotionSectionDataItem({
    required this.id,
    required this.imageUrl,
    this.title = '',
    this.action = const NoAction(),
  });

  AdvancedPromotionSectionDataItem.empty({
    this.imageUrl = '',
    this.title = '',
    this.action = const NoAction(),
  }) : id = CustomSectionUtils.generateUUID();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'action': action.toMap(),
    };
  }

  factory AdvancedPromotionSectionDataItem.fromMap(Map<String, dynamic> map) {
    return AdvancedPromotionSectionDataItem(
      id: ModelUtils.createIntProperty(map['id']),
      imageUrl: ModelUtils.createStringProperty(map['imageUrl']),
      title: ModelUtils.createStringProperty(map['title']),
      action: AppAction.createActionFromMap(map['action']),
    );
  }

  AdvancedPromotionSectionDataItem copyWith({
    String? imageUrl,
    String? title,
    AppAction? action,
  }) {
    return AdvancedPromotionSectionDataItem(
      id: id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      action: action ?? this.action,
    );
  }
}
