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

class PSImageSectionData extends PSSectionData {
  final double aspectRatio;
  final bool showImageGallery;

  const PSImageSectionData({
    required int id,
    this.aspectRatio = 1,
    this.showImageGallery = false,
    StyledData styledData = const StyledData(
      borderRadius: 10,
      marginData: PSSectionData.defaultMarginData,
    ),
  }) : super(
          id: id,
          styledData: styledData,
          sectionType: PSSectionType.image,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'aspectRatio': aspectRatio,
      'showImageGallery': showImageGallery,
    };
  }

  factory PSImageSectionData.fromMap(Map<String, dynamic> map) {
    return PSImageSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      aspectRatio: ModelUtils.createDoubleProperty(map['aspectRatio'], 1),
      showImageGallery:
          ModelUtils.createBoolProperty(map['showImageGallery'], false),
      styledData: StyledData.fromMap(map['styledData']),
    );
  }

  @override
  PSImageSectionData copyWith({
    double? aspectRatio,
    bool? showImageGallery,
    StyledData? styledData,
  }) {
    return PSImageSectionData(
      id: id,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      showImageGallery: showImageGallery ?? this.showImageGallery,
      styledData: styledData ?? this.styledData,
    );
  }
}
