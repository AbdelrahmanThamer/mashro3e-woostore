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
class RatingSectionData extends ProductCardLayoutSectionData {
  final MarginData marginData;
  final TextStyleData textStyleData;
  final double iconSize;
  final String iconColor;

  const RatingSectionData({
    this.marginData = const MarginData(left: 10, right: 10, top: 5, bottom: 5),
    this.textStyleData = const TextStyleData(fontSize: 12),
    this.iconColor = '#555500',
    this.iconSize = 12,
  }) : super(
          show: true,
          sectionType: ProductCardSectionType.rating,
        );

  const RatingSectionData.horizontal({
    this.marginData = const MarginData(left: 5, right: 5, top: 5, bottom: 5),
    this.textStyleData = const TextStyleData(fontSize: 12),
    this.iconColor = '#555500',
    this.iconSize = 12,
  }) : super(
          show: true,
          sectionType: ProductCardSectionType.rating,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'marginData': marginData.toMap(),
      'textStyleData': textStyleData.toMap(),
      'iconSize': iconSize,
      'iconColor': iconColor,
    };
  }

  factory RatingSectionData.fromMap(Map<String, dynamic> map) {
    return RatingSectionData(
      marginData: MarginData.fromMap(map['marginData']),
      textStyleData: TextStyleData.fromMap(map['textStyleData']),
      iconSize: ModelUtils.createDoubleProperty(map['iconSize']),
      iconColor: ModelUtils.createStringProperty(map['iconColor']),
    );
  }

  RatingSectionData copyWith({
    MarginData? marginData,
    TextStyleData? textStyleData,
    double? iconSize,
    String? iconColor,
  }) {
    return RatingSectionData(
      marginData: marginData ?? this.marginData,
      textStyleData: textStyleData ?? this.textStyleData,
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor,
    );
  }
}
