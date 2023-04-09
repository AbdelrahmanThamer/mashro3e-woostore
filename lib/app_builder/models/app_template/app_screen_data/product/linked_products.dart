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

part of 'product.dart';

abstract class PSLinkedProductsSectionData extends PSSectionData {
  final ProductListConfig productListConfig;

  const PSLinkedProductsSectionData({
    required this.productListConfig,
    required int id,
    required PSSectionType type,
    StyledData? styledData,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: type,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'productListConfig': productListConfig.toMap(),
    };
  }

  @override
  PSLinkedProductsSectionData copyWith({
    StyledData? styledData,
    ProductListConfig? productListConfig,
  });
}

class PSRelatedProductsSectionData extends PSLinkedProductsSectionData {
  const PSRelatedProductsSectionData({
    required int id,
    ProductListConfig productListConfig = const ProductListConfig(
      listType: ProductListType.list,
    ),
    StyledData? styledData,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          type: PSSectionType.relatedProducts,
          productListConfig: productListConfig,
        );

  factory PSRelatedProductsSectionData.fromMap(Map<String, dynamic> map) {
    return PSRelatedProductsSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      productListConfig: ProductListConfig.fromMap(map['productListConfig']),
      styledData: StyledData.fromMap(map['styledData']),
    );
  }

  @override
  PSRelatedProductsSectionData copyWith({
    ProductListConfig? productListConfig,
    StyledData? styledData,
  }) {
    return PSRelatedProductsSectionData(
      id: id,
      productListConfig: productListConfig ?? this.productListConfig,
      styledData: styledData ?? this.styledData,
    );
  }
}

class PSCrossSellProductsSectionData extends PSLinkedProductsSectionData {
  const PSCrossSellProductsSectionData({
    required int id,
    ProductListConfig productListConfig = const ProductListConfig(
      listType: ProductListType.list,
    ),
    StyledData? styledData,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          type: PSSectionType.crossSellProducts,
          productListConfig: productListConfig,
        );

  factory PSCrossSellProductsSectionData.fromMap(Map<String, dynamic> map) {
    return PSCrossSellProductsSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      productListConfig: ProductListConfig.fromMap(map['productListConfig']),
      styledData: StyledData.fromMap(map['styledData']),
    );
  }

  @override
  PSCrossSellProductsSectionData copyWith({
    ProductListConfig? productListConfig,
    StyledData? styledData,
  }) {
    return PSCrossSellProductsSectionData(
      id: id,
      productListConfig: productListConfig ?? this.productListConfig,
      styledData: styledData ?? this.styledData,
    );
  }
}

class PSUpSellProductsSectionData extends PSLinkedProductsSectionData {
  const PSUpSellProductsSectionData({
    required int id,
    ProductListConfig productListConfig = const ProductListConfig(
      listType: ProductListType.list,
    ),
    StyledData? styledData,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          type: PSSectionType.upSellProducts,
          productListConfig: productListConfig,
        );

  factory PSUpSellProductsSectionData.fromMap(Map<String, dynamic> map) {
    return PSUpSellProductsSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      productListConfig: ProductListConfig.fromMap(map['productListConfig']),
      styledData: StyledData.fromMap(map['styledData']),
    );
  }

  @override
  PSUpSellProductsSectionData copyWith({
    ProductListConfig? productListConfig,
    StyledData? styledData,
  }) {
    return PSUpSellProductsSectionData(
      id: id,
      productListConfig: productListConfig ?? this.productListConfig,
      styledData: styledData ?? this.styledData,
    );
  }
}
