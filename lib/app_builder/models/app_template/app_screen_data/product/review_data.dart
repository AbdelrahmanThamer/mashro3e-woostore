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

class PSReviewSectionData extends PSSectionData {
  final PSReviewSectionLayoutType sectionLayout;

  const PSReviewSectionData({
    required int id,
    this.sectionLayout = PSReviewSectionLayoutType.layout1,
    StyledData? styledData,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: PSSectionType.review,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'sectionLayout': sectionLayout.name,
    };
  }

  factory PSReviewSectionData.fromMap(Map<String, dynamic> map) {
    return PSReviewSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      sectionLayout: convertStringToSectionLayout(map['sectionLayout']),
      styledData: StyledData.fromMap(map['styledData']),
    );
  }

  static PSReviewSectionLayoutType convertStringToSectionLayout(String? value) {
    if (isBlank(value)) {
      return PSReviewSectionLayoutType.layout1;
    }
    switch (value) {
      case 'layout1':
        return PSReviewSectionLayoutType.layout1;
      default:
        return PSReviewSectionLayoutType.layout1;
    }
  }

  @override
  PSReviewSectionData copyWith({
    PSReviewSectionLayoutType? sectionLayout,
    StyledData? styledData,
  }) {
    return PSReviewSectionData(
      id: id,
      sectionLayout: sectionLayout ?? this.sectionLayout,
      styledData: styledData ?? this.styledData,
    );
  }
}

enum PSReviewSectionLayoutType {
  layout1,
}
