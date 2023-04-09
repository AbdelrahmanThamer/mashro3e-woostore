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
class RecentProductsSectionData extends CustomSectionData {
  final SectionLayout layout;
  final String title;
  final bool showTitle;

  final bool useGlobalProductCardLayout;
  final ProductCardLayoutData productCardLayoutData;
  final double itemPadding;
  final int columns;

  const RecentProductsSectionData({
    required int id,
    required String name,
    required this.layout,
    this.title = 'Recent Products',
    this.showTitle = true,
    required bool show,
    this.useGlobalProductCardLayout = true,
    this.productCardLayoutData = const ProductCardLayoutData(),
    required StyledData styledData,
    this.itemPadding = 5,
    this.columns = 2,
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.recentProducts,
          styledData: styledData,
        );

  RecentProductsSectionData.empty({
    this.layout = SectionLayout.horizontalList,
    this.title = 'Recent Products',
    this.showTitle = false,
    this.useGlobalProductCardLayout = true,
    this.productCardLayoutData = const ProductCardLayoutData(),
    this.itemPadding = 5,
    this.columns = 2,
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Recent Products Section',
          show: false,
          sectionType: SectionType.recentProducts,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'layout': layout.name,
      'title': title,
      'showTitle': showTitle,
      'useGlobalProductCardLayout': useGlobalProductCardLayout,
      'productCardLayoutData': productCardLayoutData.toMap(),
      'itemPadding': itemPadding,
      'columns': columns,
    };
  }

  factory RecentProductsSectionData.fromMap(Map<String, dynamic> map) {
    return RecentProductsSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      layout: CustomSectionUtils.convertStringToSectionLayout(map['layout']),
      show: ModelUtils.createBoolProperty(map['show']),
      showTitle: ModelUtils.createBoolProperty(map['showTitle']),
      title: ModelUtils.createStringProperty(map['title']),
      name: ModelUtils.createStringProperty(map['name']),
      useGlobalProductCardLayout: ModelUtils.createBoolProperty(
        map['useGlobalProductCardLayout'],
        true,
      ),
      productCardLayoutData:
          ProductCardLayoutData.fromMap(map['productCardLayoutData']),
      styledData: StyledData.fromMap(map['styledData']),
      itemPadding: ModelUtils.createDoubleProperty(map['itemPadding'], 5),
      columns: ModelUtils.createIntProperty(map['columns'], 2),
    );
  }

  @override
  RecentProductsSectionData copyWith({
    int? id,
    SectionLayout? layout,
    String? title,
    bool? showTitle,
    bool? show,
    String? name,
    bool? useGlobalProductCardLayout,
    ProductCardLayoutData? productCardLayoutData,
    StyledData? styledData,
    double? itemPadding,
    int? columns,
  }) {
    return RecentProductsSectionData(
      id: id ?? this.id,
      layout: layout ?? this.layout,
      title: title ?? this.title,
      showTitle: showTitle ?? this.showTitle,
      show: show ?? this.show,
      name: name ?? this.name,
      useGlobalProductCardLayout:
          useGlobalProductCardLayout ?? this.useGlobalProductCardLayout,
      productCardLayoutData:
          productCardLayoutData ?? this.productCardLayoutData,
      styledData: styledData ?? this.styledData,
      itemPadding: itemPadding ?? this.itemPadding,
      columns: columns ?? this.columns,
    );
  }
}
