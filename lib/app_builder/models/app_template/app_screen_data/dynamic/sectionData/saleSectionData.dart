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
class SaleSectionData extends CustomSectionData {
  final LoadProductsConfigData loadProductsConfigData;
  final SectionLayout layout;
  final bool showTimer;
  final String saleEndTime;
  final String title;
  final bool showPromotionalImages;
  final double imageBorderRadius;
  final List<String> images;
  final bool useGlobalProductCardLayout;
  final ProductCardLayoutData productCardLayoutData;
  final DimensionsData itemDimensionsData;
  final BoxFit itemImageBoxFit;
  final double itemBorderRadius;
  final double itemPadding;
  final int columns;

  const SaleSectionData({
    required int id,
    required String name,
    this.imageBorderRadius = 10,
    this.loadProductsConfigData = const LoadProductsConfigData(onSale: true),
    this.useGlobalProductCardLayout = true,
    this.productCardLayoutData = const ProductCardLayoutData(),
    required this.title,
    required this.layout,
    required this.showTimer,
    required this.saleEndTime,
    required this.showPromotionalImages,
    required this.images,
    required bool show,
    required StyledData styledData,
    this.itemDimensionsData = const DimensionsData(),
    this.itemImageBoxFit = BoxFit.cover,
    this.itemBorderRadius = 10,
    this.itemPadding = 5,
    this.columns = 2,
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.sale,
          styledData: styledData,
        );

  SaleSectionData.empty({
    this.title = '',
    this.imageBorderRadius = 10,
    this.layout = SectionLayout.horizontalList,
    this.showTimer = false,
    this.saleEndTime = '',
    this.showPromotionalImages = false,
    this.images = const [],
    this.loadProductsConfigData = const LoadProductsConfigData(onSale: true),
    this.useGlobalProductCardLayout = true,
    this.productCardLayoutData = const ProductCardLayoutData(),
    this.itemDimensionsData = const DimensionsData(),
    this.itemImageBoxFit = BoxFit.cover,
    this.itemBorderRadius = 10,
    this.itemPadding = 5,
    this.columns = 2,
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Sale Section',
          show: false,
          sectionType: SectionType.sale,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'title': title,
      'loadProductsConfigData': loadProductsConfigData.toMap(),
      'layout': layout.name,
      'showTimer': showTimer,
      'saleEndTime': saleEndTime,
      'showPromotionalImages': showPromotionalImages,
      'images': images,
      'imageBorderRadius': imageBorderRadius,
      'useGlobalProductCardLayout': useGlobalProductCardLayout,
      'productCardLayoutData': productCardLayoutData.toMap(),
      'itemDimensionsData': itemDimensionsData.toMap(),
      'itemImageBoxFit': itemImageBoxFit.name,
      'itemBorderRadius': itemBorderRadius,
      'itemPadding': itemPadding,
      'columns': columns,
    };
  }

  factory SaleSectionData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return SaleSectionData.empty();
    }
    return SaleSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      loadProductsConfigData:
          LoadProductsConfigData.fromMap(map['loadProductsConfigData']),
      title: ModelUtils.createStringProperty(map['title']),
      layout: CustomSectionUtils.convertStringToSectionLayout(map['layout']),
      showTimer: ModelUtils.createBoolProperty(map['showTimer']),
      saleEndTime: ModelUtils.createStringProperty(map['saleEndTime']),
      showPromotionalImages:
          ModelUtils.createBoolProperty(map['showPromotionalImages']),
      images: ModelUtils.createListStrings(map['images']),
      show: ModelUtils.createBoolProperty(map['show']),
      name: ModelUtils.createStringProperty(map['name']),
      useGlobalProductCardLayout: ModelUtils.createBoolProperty(
        map['useGlobalProductCardLayout'],
        true,
      ),
      productCardLayoutData:
          ProductCardLayoutData.fromMap(map['productCardLayoutData']),
      styledData: StyledData.fromMap(map['styledData']),
      imageBorderRadius:
          ModelUtils.createDoubleProperty(map['imageBorderRadius']),
      itemDimensionsData: DimensionsData.fromMap(map['itemDimensionsData']),
      itemImageBoxFit: EnumUtils.convertStringToBoxFit(map['itemImageBoxFit']),
      itemBorderRadius:
          ModelUtils.createDoubleProperty(map['itemBorderRadius'], 10),
      itemPadding: ModelUtils.createDoubleProperty(map['itemPadding'], 5),
      columns: ModelUtils.createIntProperty(map['columns'], 2),
    );
  }

  @override
  SaleSectionData copyWith({
    int? id,
    LoadProductsConfigData? loadProductsConfigData,
    String? title,
    SectionLayout? layout,
    bool? showTimer,
    String? saleEndTime,
    bool? showPromotionalImages,
    List<String>? images,
    bool? show,
    String? name,
    bool? useGlobalProductCardLayout,
    ProductCardLayoutData? productCardLayoutData,
    StyledData? styledData,
    double? imageBorderRadius,
    DimensionsData? itemDimensionsData,
    BoxFit? itemImageBoxFit,
    double? itemBorderRadius,
    double? itemPadding,
    int? columns,
  }) {
    return SaleSectionData(
      id: id ?? this.id,
      show: show ?? this.show,
      loadProductsConfigData:
          loadProductsConfigData ?? this.loadProductsConfigData,
      title: title ?? this.title,
      layout: layout ?? this.layout,
      showTimer: showTimer ?? this.showTimer,
      saleEndTime: saleEndTime ?? this.saleEndTime,
      showPromotionalImages:
          showPromotionalImages ?? this.showPromotionalImages,
      images: images ?? this.images,
      name: name ?? this.name,
      useGlobalProductCardLayout:
          useGlobalProductCardLayout ?? this.useGlobalProductCardLayout,
      productCardLayoutData:
          productCardLayoutData ?? this.productCardLayoutData,
      styledData: styledData ?? this.styledData,
      imageBorderRadius: imageBorderRadius ?? this.imageBorderRadius,
      itemDimensionsData: itemDimensionsData ?? this.itemDimensionsData,
      itemImageBoxFit: itemImageBoxFit ?? this.itemImageBoxFit,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      itemPadding: itemPadding ?? this.itemPadding,
      columns: columns ?? this.columns,
    );
  }
}
