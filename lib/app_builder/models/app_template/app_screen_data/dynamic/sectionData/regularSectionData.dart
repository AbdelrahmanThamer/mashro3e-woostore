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
class RegularSectionData extends CustomSectionData {
  final LoadProductsConfigData loadProductsConfigData;
  final SectionLayout layout;
  final String? title;
  final bool enableShowAllButton;

  final bool useGlobalProductCardLayout;
  final ProductCardLayoutData productCardLayoutData;

  final double itemPadding;
  final int columns;

  const RegularSectionData({
    required int id,
    required String name,
    this.loadProductsConfigData = const LoadProductsConfigData(),
    required this.layout,
    this.title,
    required bool show,
    this.useGlobalProductCardLayout = true,
    this.productCardLayoutData = const ProductCardLayoutData(),
    required StyledData styledData,
    this.itemPadding = 5,
    this.columns = 2,
    this.enableShowAllButton = false,
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.regular,
          styledData: styledData,
        );

  RegularSectionData.empty({
    this.layout = SectionLayout.horizontalList,
    this.title,
    this.loadProductsConfigData = const LoadProductsConfigData(),
    this.useGlobalProductCardLayout = true,
    this.productCardLayoutData = const ProductCardLayoutData(),
    this.itemPadding = 5,
    this.columns = 2,
    this.enableShowAllButton = false,
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Regular Section',
          show: false,
          sectionType: SectionType.regular,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'loadProductsConfigData': loadProductsConfigData.toMap(),
      'layout': layout.name,
      'title': title,
      'useGlobalProductCardLayout': useGlobalProductCardLayout,
      'productCardLayoutData': productCardLayoutData.toMap(),
      'itemPadding': itemPadding,
      'columns': columns,
      'enableShowAllButton': enableShowAllButton,
    };
  }

  factory RegularSectionData.fromMap(Map<String, dynamic> map) {
    return RegularSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      loadProductsConfigData:
          LoadProductsConfigData.fromMap(map['loadProductsConfigData']),
      layout: CustomSectionUtils.convertStringToSectionLayout(map['layout']),
      show: ModelUtils.createBoolProperty(map['show']),
      title: ModelUtils.createStringProperty(map['title']),
      itemPadding: ModelUtils.createDoubleProperty(map['itemPadding'], 5),
      name: ModelUtils.createStringProperty(map['name']),
      useGlobalProductCardLayout: ModelUtils.createBoolProperty(
        map['useGlobalProductCardLayout'],
        true,
      ),
      productCardLayoutData:
          ProductCardLayoutData.fromMap(map['productCardLayoutData']),
      styledData: StyledData.fromMap(map['styledData']),
      columns: ModelUtils.createIntProperty(map['columns'], 2),
      enableShowAllButton: ModelUtils.createBoolProperty(
        map['enableShowAllButton'],
        false,
      ),
    );
  }

  @override
  RegularSectionData copyWith({
    int? id,
    SectionLayout? layout,
    String? title,
    bool? show,
    String? name,
    bool? useGlobalProductCardLayout,
    ProductCardLayoutData? productCardLayoutData,
    StyledData? styledData,
    LoadProductsConfigData? loadProductsConfigData,
    double? itemPadding,
    int? columns,
    bool? enableShowAllButton,
  }) {
    return RegularSectionData(
      id: id ?? this.id,
      loadProductsConfigData:
          loadProductsConfigData ?? this.loadProductsConfigData,
      layout: layout ?? this.layout,
      title: title ?? this.title,
      show: show ?? this.show,
      name: name ?? this.name,
      enableShowAllButton: enableShowAllButton ?? this.enableShowAllButton,
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
