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

class PSPointsAndRewardsSectionData extends PSSectionData {
  const PSPointsAndRewardsSectionData({
    required int id,
    StyledData? styledData,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: PSSectionType.pointsAndRewards,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
    };
  }

  factory PSPointsAndRewardsSectionData.fromMap(Map<String, dynamic> map) {
    return PSPointsAndRewardsSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      styledData: StyledData.fromMap(map['styledData']),
    );
  }

  @override
  PSPointsAndRewardsSectionData copyWith({
    StyledData? styledData,
  }) {
    return PSPointsAndRewardsSectionData(
      id: id,
      styledData: styledData ?? this.styledData,
    );
  }
}
