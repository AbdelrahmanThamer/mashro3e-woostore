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

class PSProductAddOnSectionData extends PSSectionData {
  const PSProductAddOnSectionData({
    required super.id,
    this.multipleChoiceImageDimensions = const DimensionsData(
      height: 100,
      width: 100,
    ),
    this.allowedExtensions,
    super.styledData = PSSectionData.defaultStyledData,
  }) : super(sectionType: PSSectionType.productAddOns);

  final DimensionsData multipleChoiceImageDimensions;
  final Set<String>? allowedExtensions;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'multipleChoiceImageDimensions': multipleChoiceImageDimensions.toMap(),
      'allowedExtensions': allowedExtensions?.toList(),
    };
  }

  factory PSProductAddOnSectionData.fromMap(Map<String, dynamic> map) {
    return PSProductAddOnSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      styledData: StyledData.fromMap(map['styledData']),
      multipleChoiceImageDimensions:
          DimensionsData.fromMap(map['multipleChoiceImageDimensions']),
      allowedExtensions:
          ModelUtils.createListStrings(map['allowedExtensions']).toSet(),
    );
  }

  @override
  PSProductAddOnSectionData copyWith({
    StyledData? styledData,
    DimensionsData? multipleChoiceImageDimensions,
    Set<String>? allowedExtensions,
  }) {
    return PSProductAddOnSectionData(
      id: id,
      styledData: styledData ?? this.styledData,
      allowedExtensions: allowedExtensions ?? this.allowedExtensions,
      multipleChoiceImageDimensions:
          multipleChoiceImageDimensions ?? this.multipleChoiceImageDimensions,
    );
  }
}
