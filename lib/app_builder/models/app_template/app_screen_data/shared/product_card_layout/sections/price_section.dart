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

part of '../product_card_layout.dart';

@immutable
class PriceSectionData extends ProductCardLayoutSectionData {
  final MarginData marginData;
  final TextStyleData textStyleData;

  const PriceSectionData({
    this.marginData = const MarginData(left: 10, right: 10, top: 5, bottom: 5),
    this.textStyleData = const TextStyleData(),
  }) : super(
          show: true,
          sectionType: ProductCardSectionType.price,
        );

  const PriceSectionData.horizontal({
    this.marginData = const MarginData(left: 5, right: 5, top: 5, bottom: 5),
    this.textStyleData = const TextStyleData(),
  }) : super(
          show: true,
          sectionType: ProductCardSectionType.price,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'marginData': marginData.toMap(),
      'textStyleData': textStyleData.toMap(),
    };
  }

  factory PriceSectionData.fromMap(Map<String, dynamic> map) {
    return PriceSectionData(
      marginData: MarginData.fromMap(map['marginData']),
      textStyleData: TextStyleData.fromMap(map['textStyleData']),
    );
  }

  PriceSectionData copyWith({
    MarginData? marginData,
    TextStyleData? textStyleData,
  }) {
    return PriceSectionData(
      marginData: marginData ?? this.marginData,
      textStyleData: textStyleData ?? this.textStyleData,
    );
  }
}
