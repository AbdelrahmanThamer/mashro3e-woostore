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
class NameSectionData extends ProductCardLayoutSectionData {
  final MarginData marginData;
  final TextStyleData textStyleData;

  const NameSectionData({
    this.marginData = const MarginData(left: 10, right: 10, top: 5, bottom: 5),
    this.textStyleData = const TextStyleData(fontSize: 16),
  }) : super(
          show: true,
          sectionType: ProductCardSectionType.name,
        );

  const NameSectionData.horizontal({
    this.marginData = const MarginData(left: 5, right: 5, top: 10, bottom: 5),
    this.textStyleData = const TextStyleData(fontSize: 16),
  }) : super(
          show: true,
          sectionType: ProductCardSectionType.name,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'marginData': marginData.toMap(),
      'textStyleData': textStyleData.toMap(),
    };
  }

  factory NameSectionData.fromMap(Map<String, dynamic> map) {
    return NameSectionData(
      marginData: MarginData.fromMap(map['marginData']),
      textStyleData: TextStyleData.fromMap(map['textStyleData']),
    );
  }

  NameSectionData copyWith({
    MarginData? marginData,
    TextStyleData? textStyleData,
  }) {
    return NameSectionData(
      marginData: marginData ?? this.marginData,
      textStyleData: textStyleData ?? this.textStyleData,
    );
  }
}
