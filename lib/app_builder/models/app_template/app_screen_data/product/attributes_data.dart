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

class PSAttributesSectionData extends PSSectionData {
  final PSAttributesSectionLayoutType sectionLayout;

  const PSAttributesSectionData({
    required int id,
    this.sectionLayout = PSAttributesSectionLayoutType.layout1,
    StyledData? styledData,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: PSSectionType.attributes,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'sectionLayout': sectionLayout.name,
    };
  }

  factory PSAttributesSectionData.fromMap(Map<String, dynamic> map) {
    return PSAttributesSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      sectionLayout: convertStringToSectionLayout(map['sectionLayout']),
      styledData: StyledData.fromMap(map['styledData']),
    );
  }

  static PSAttributesSectionLayoutType convertStringToSectionLayout(
      String? value) {
    if (isBlank(value)) {
      return PSAttributesSectionLayoutType.layout1;
    }
    switch (value) {
      case 'layout1':
        return PSAttributesSectionLayoutType.layout1;
      default:
        return PSAttributesSectionLayoutType.layout1;
    }
  }

  @override
  PSAttributesSectionData copyWith({
    PSAttributesSectionLayoutType? sectionLayout,
    StyledData? styledData,
  }) {
    return PSAttributesSectionData(
      id: id,
      sectionLayout: sectionLayout ?? this.sectionLayout,
      styledData: styledData ?? this.styledData,
    );
  }
}

enum PSAttributesSectionLayoutType {
  layout1,
}
