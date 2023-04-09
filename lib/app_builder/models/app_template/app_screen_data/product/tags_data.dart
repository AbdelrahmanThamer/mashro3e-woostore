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

class PSTagsSectionData extends PSSectionData {
  final ItemListConfig itemListConfig;
  final bool showTitle;

  const PSTagsSectionData({
    required int id,
    this.itemListConfig = const ItemListConfig(),
    StyledData? styledData,
    this.showTitle = true,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: PSSectionType.tags,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'itemListConfig': itemListConfig.toMap(),
      'showTitle': showTitle,
    };
  }

  factory PSTagsSectionData.fromMap(Map<String, dynamic> map) {
    return PSTagsSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      itemListConfig: ItemListConfig.fromMap(map['sectionLayout']),
      styledData: StyledData.fromMap(map['styledData']),
      showTitle: ModelUtils.createBoolProperty(map['showTitle']),
    );
  }

  @override
  PSTagsSectionData copyWith({
    StyledData? styledData,
    ItemListConfig? itemListConfig,
    bool? showTitle,
  }) {
    return PSTagsSectionData(
      id: id,
      itemListConfig: itemListConfig ?? this.itemListConfig,
      styledData: styledData ?? this.styledData,
      showTitle: showTitle ?? this.showTitle,
    );
  }
}
