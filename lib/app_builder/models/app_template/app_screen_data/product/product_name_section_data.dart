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

class PSProductNameSectionData extends PSSectionData {
  const PSProductNameSectionData({
    required int id,
    StyledData styledData = const StyledData(
      textStyleData: TextStyleData(fontSize: 16, fontWeight: 6),
      paddingData: PSSectionData.defaultPaddingData,
      marginData: PSSectionData.defaultMarginData,
      borderRadius: 10,
    ),
  }) : super(
          id: id,
          styledData: styledData,
          sectionType: PSSectionType.productName,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
    };
  }

  factory PSProductNameSectionData.fromMap(Map<String, dynamic> map) {
    return PSProductNameSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      styledData: StyledData.fromMap(map['styledData']),
    );
  }

  @override
  PSProductNameSectionData copyWith({
    StyledData? styledData,
  }) {
    return PSProductNameSectionData(
      id: id,
      styledData: styledData ?? this.styledData,
    );
  }
}
