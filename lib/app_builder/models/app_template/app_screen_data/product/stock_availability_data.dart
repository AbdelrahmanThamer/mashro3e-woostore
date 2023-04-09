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

class PSStockAvailabilitySectionData extends PSSectionData {
  final PSStockAvailabilityLayoutType sectionLayout;

  const PSStockAvailabilitySectionData({
    required int id,
    this.sectionLayout = PSStockAvailabilityLayoutType.layout1,
    StyledData? styledData,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: PSSectionType.stockAvailability,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'sectionLayout': sectionLayout.name,
    };
  }

  factory PSStockAvailabilitySectionData.fromMap(Map<String, dynamic> map) {
    return PSStockAvailabilitySectionData(
      id: ModelUtils.createIntProperty(map['id']),
      sectionLayout: convertStringToSectionLayout(map['sectionLayout']),
      styledData: StyledData.fromMap(map['styledData']),
    );
  }

  static PSStockAvailabilityLayoutType convertStringToSectionLayout(
      String? value) {
    if (isBlank(value)) {
      return PSStockAvailabilityLayoutType.layout1;
    }
    switch (value) {
      case 'layout1':
        return PSStockAvailabilityLayoutType.layout1;
      default:
        return PSStockAvailabilityLayoutType.layout1;
    }
  }

  @override
  PSStockAvailabilitySectionData copyWith({
    PSStockAvailabilityLayoutType? sectionLayout,
    StyledData? styledData,
  }) {
    return PSStockAvailabilitySectionData(
      id: id,
      sectionLayout: sectionLayout ?? this.sectionLayout,
      styledData: styledData ?? this.styledData,
    );
  }
}

enum PSStockAvailabilityLayoutType {
  layout1,
}
