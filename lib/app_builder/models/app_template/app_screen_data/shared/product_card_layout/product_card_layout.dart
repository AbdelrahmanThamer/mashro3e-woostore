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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/material.dart';

import '../../../../utils.dart';
import '../edge_insets.dart';
import '../text_style_data.dart';

part 'sections/image_section.dart';
part 'sections/name_section.dart';
part 'sections/price_section.dart';
part 'sections/rating_section.dart';

enum ProductCardLayoutType {
  horizontal,
  vertical,
}

@immutable
class ProductCardLayoutData {
  final ProductCardLayoutType layoutType;
  final double width;
  final double height;
  final List<ProductCardLayoutSectionData> sections;
  final double borderRadius;

  /// Needs to be a HEX color
  final String? backgroundColor;

  const ProductCardLayoutData({
    this.layoutType = ProductCardLayoutType.vertical,
    this.width = 225,
    this.height = 355,
    this.sections = const [
      ImageSectionData(height: 355 / 1.5, width: 225),
      NameSectionData(),
      PriceSectionData(),
      RatingSectionData(),
    ],
    this.backgroundColor,
    this.borderRadius = 10,
  });

  const ProductCardLayoutData.horizontal({
    this.layoutType = ProductCardLayoutType.horizontal,
    this.width = 350,
    this.height = 120,
    this.sections = const [
      ImageSectionData(height: 120, width: 120),
      NameSectionData.horizontal(),
      PriceSectionData.horizontal(),
      RatingSectionData.horizontal(),
    ],
    this.backgroundColor,
    this.borderRadius = 10,
  });

  Map<String, dynamic> toMap() {
    return {
      'layoutType': layoutType.name,
      'width': width,
      'height': height,
      'sections': sections.map((e) => e.toMap()).toList(),
      'backgroundColor': backgroundColor,
      'borderRadius': borderRadius,
    };
  }

  factory ProductCardLayoutData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      Dev.warn('Product Card Layout Data.fromMap - Map is empty');
      return const ProductCardLayoutData();
    }
    try {
      return ProductCardLayoutData(
        layoutType: getLayoutType(map['layoutType']),
        width: ModelUtils.createDoubleProperty(map['width']),
        height: ModelUtils.createDoubleProperty(map['height']),
        sections: ModelUtils.createListOfType<ProductCardLayoutSectionData>(
          map['sections'],
          (elem) => ProductCardLayoutSectionData.fromMap(elem),
        ),
        backgroundColor:
            ModelUtils.createStringProperty(map['backgroundColor']),
        borderRadius: ModelUtils.createDoubleProperty(map['borderRadius']),
      );
    } catch (e, s) {
      Dev.error('Error', error: e, stackTrace: s);
      return const ProductCardLayoutData();
    }
  }

  static ProductCardLayoutType getLayoutType(String? val) {
    switch (val) {
      case 'vertical':
        return ProductCardLayoutType.vertical;
      case 'horizontal':
        return ProductCardLayoutType.horizontal;
      default:
        return ProductCardLayoutType.vertical;
    }
  }

  ProductCardLayoutData copyWith({
    ProductCardLayoutType? layoutType,
    double? width,
    double? height,
    List<ProductCardLayoutSectionData>? sections,
    double? borderRadius,
    String? backgroundColor,
  }) {
    return ProductCardLayoutData(
      layoutType: layoutType ?? this.layoutType,
      width: width ?? this.width,
      height: height ?? this.height,
      sections: sections ?? this.sections,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  double getAspectRatio() {
    return width / height;
  }
}

abstract class ProductCardLayoutSectionData {
  final bool show;
  final ProductCardSectionType sectionType;

  const ProductCardLayoutSectionData({
    this.show = false,
    this.sectionType = ProductCardSectionType.undefined,
  });

  Map<String, dynamic> toMap() {
    return {
      'show': show,
      'sectionType': sectionType.name,
    };
  }

  factory ProductCardLayoutSectionData.fromMap(Map<String, dynamic> map) {
    final ProductCardSectionType type = getSectionType(map['sectionType']);

    switch (type) {
      case ProductCardSectionType.image:
        return ImageSectionData.fromMap(map);
      case ProductCardSectionType.name:
        return NameSectionData.fromMap(map);
      case ProductCardSectionType.price:
        return PriceSectionData.fromMap(map);
      case ProductCardSectionType.rating:
        return RatingSectionData.fromMap(map);
      default:
        return const EmptySectionData();
    }
  }

  static ProductCardSectionType getSectionType(String? val) {
    switch (val) {
      case 'image':
        return ProductCardSectionType.image;
      case 'name':
        return ProductCardSectionType.name;
      case 'price':
        return ProductCardSectionType.price;
      case 'rating':
        return ProductCardSectionType.rating;
      default:
        return ProductCardSectionType.undefined;
    }
  }
}

class EmptySectionData extends ProductCardLayoutSectionData {
  const EmptySectionData() : super();
}

enum ProductCardSectionType {
  image,
  name,
  price,
  rating,
  undefined,
}
