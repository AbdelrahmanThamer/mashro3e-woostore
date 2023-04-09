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

class AdvancedBannerListSectionData extends CustomSectionData {
  final List<AdvancedBannerSectionData> items;
  final String title;
  final DimensionsData itemDimensionsData;

  final SectionLayout layout;
  final double itemPadding;
  final int columns;

  const AdvancedBannerListSectionData({
    required int id,
    required this.items,
    required this.title,
    required String name,
    required bool show,
    required StyledData styledData,
    required this.layout,
    this.itemDimensionsData = const DimensionsData(
      height: 350,
      width: 300,
      aspectRatio: 0.7,
    ),
    this.itemPadding = 5,
    this.columns = 2,
  }) : super(
          id: id,
          show: show,
          name: name,
          sectionType: SectionType.advancedBannerList,
          styledData: styledData,
        );

  AdvancedBannerListSectionData.empty({
    this.items = const [],
    this.title = '',
    this.layout = SectionLayout.horizontalList,
    this.itemDimensionsData = const DimensionsData(
      height: 300,
      width: 250,
      aspectRatio: 0.7,
    ),
    this.itemPadding = 5,
    this.columns = 2,
  }) : super(
          id: CustomSectionUtils.generateUUID(),
          name: 'Advanced Banner List Section',
          show: false,
          sectionType: SectionType.advancedBannerList,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'title': title,
      'items': items.map((e) => e.toMap()).toList(),
      'layout': layout.name,
      'itemDimensionsData': itemDimensionsData.toMap(),
      'itemPadding': itemPadding,
      'columns': columns,
    };
  }

  factory AdvancedBannerListSectionData.fromMap(Map<String, dynamic> map) {
    return AdvancedBannerListSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      show: ModelUtils.createBoolProperty(map['show']),
      name: ModelUtils.createStringProperty(map['name']),
      title: ModelUtils.createStringProperty(map['title']),
      items: ModelUtils.createListOfType<AdvancedBannerSectionData>(
        map['items'],
        (e) => AdvancedBannerSectionData.fromMap(e),
      ),
      styledData: StyledData.fromMap(map['styledData']),
      layout: CustomSectionUtils.convertStringToSectionLayout(map['layout']),
      itemDimensionsData: DimensionsData.fromMap(map['itemDimensionsData']),
      itemPadding: ModelUtils.createDoubleProperty(map['itemPadding'], 5),
      columns: ModelUtils.createIntProperty(map['columns'], 2),
    );
  }

  @override
  AdvancedBannerListSectionData copyWith({
    int? id,
    List<AdvancedBannerSectionData>? items,
    String? title,
    bool? show,
    String? name,
    StyledData? styledData,
    DimensionsData? itemDimensionsData,
    SectionLayout? layout,
    double? itemPadding,
    int? columns,
  }) {
    return AdvancedBannerListSectionData(
      id: id ?? this.id,
      show: show ?? this.show,
      columns: columns ?? this.columns,
      name: name ?? this.name,
      items: items ?? this.items,
      title: title ?? this.title,
      styledData: styledData ?? this.styledData,
      itemDimensionsData: itemDimensionsData ?? this.itemDimensionsData,
      layout: layout ?? this.layout,
      itemPadding: itemPadding ?? this.itemPadding,
    );
  }
}

class AdvancedBannerSectionData extends CustomSectionData {
  final bool showNewLabel;
  final String? heading;
  final TextStyleData headingTextStyleData;
  final double? imageBorderRadius;
  final String? imageUrl;
  final String? description;
  final String? bottomDescription;
  final String? actionButtonText;
  final AppAction action;
  final BoxFit itemImageBoxFit;

  const AdvancedBannerSectionData({
    required int id,
    required String name,
    this.action = const NoAction(),
    this.showNewLabel = false,
    this.heading = '',
    this.headingTextStyleData = const TextStyleData(
      fontSize: 28,
      fontWeight: 6,
    ),
    this.imageUrl,
    this.description,
    this.imageBorderRadius = 0,
    this.bottomDescription,
    this.actionButtonText,
    required bool show,
    required StyledData styledData,
    this.itemImageBoxFit = BoxFit.cover,
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.advancedBanner,
          styledData: styledData,
        );

  AdvancedBannerSectionData.empty({
    this.showNewLabel = false,
    this.action = const NoAction(),
    this.heading,
    this.headingTextStyleData = const TextStyleData(
      fontSize: 28,
      fontWeight: 6,
    ),
    this.imageUrl,
    this.description,
    this.imageBorderRadius = 0,
    this.bottomDescription,
    this.actionButtonText,
    this.itemImageBoxFit = BoxFit.cover,
  }) : super(
          id: CustomSectionUtils.generateUUID(),
          name: 'Advanced Banner Section',
          show: false,
          sectionType: SectionType.advancedBanner,
        );

  factory AdvancedBannerSectionData.fromMap(Map<String, dynamic> map) {
    return AdvancedBannerSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      show: ModelUtils.createBoolProperty(map['show']),
      showNewLabel: ModelUtils.createBoolProperty(map['showNewLabel']),
      heading: ModelUtils.createStringProperty(map['heading']),
      headingTextStyleData: TextStyleData.fromMap(map['headingTextStyleData']),
      imageUrl: ModelUtils.createStringProperty(map['imageUrl']),
      description: ModelUtils.createStringProperty(map['description']),
      imageBorderRadius:
          ModelUtils.createDoubleProperty(map['imageBorderRadius']),
      bottomDescription:
          ModelUtils.createStringProperty(map['bottomDescription']),
      actionButtonText:
          ModelUtils.createStringProperty(map['actionButtonText']),
      styledData: StyledData.fromMap(map['styledData']),
      action: AppAction.createActionFromMap(map['action']),
      itemImageBoxFit: EnumUtils.convertStringToBoxFit(map['itemImageBoxFit']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'showNewLabel': showNewLabel,
      'heading': heading,
      'headingTextStyleData': headingTextStyleData.toMap(),
      'imageBorderRadius': imageBorderRadius,
      'imageUrl': imageUrl,
      'description': description,
      'bottomDescription': bottomDescription,
      'actionButtonText': actionButtonText,
      'action': action.toMap(),
      'itemImageBoxFit': itemImageBoxFit.name,
    };
  }

  @override
  AdvancedBannerSectionData copyWith({
    int? id,
    bool? showNewLabel,
    String? heading,
    double? imageBorderRadius,
    String? imageUrl,
    String? description,
    String? bottomDescription,
    String? actionButtonText,
    bool? show,
    String? name,
    StyledData? styledData,
    AppAction? action,
    BoxFit? itemImageBoxFit,
    TextStyleData? headingTextStyleData,
  }) {
    return AdvancedBannerSectionData(
      id: id ?? this.id,
      show: show ?? this.show,
      name: name ?? this.name,
      showNewLabel: showNewLabel ?? this.showNewLabel,
      heading: heading ?? this.heading,
      headingTextStyleData: headingTextStyleData ?? this.headingTextStyleData,
      imageBorderRadius: imageBorderRadius ?? this.imageBorderRadius,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      bottomDescription: bottomDescription ?? this.bottomDescription,
      actionButtonText: actionButtonText ?? this.actionButtonText,
      styledData: styledData ?? this.styledData,
      action: action ?? this.action,
      itemImageBoxFit: itemImageBoxFit ?? this.itemImageBoxFit,
    );
  }
}
