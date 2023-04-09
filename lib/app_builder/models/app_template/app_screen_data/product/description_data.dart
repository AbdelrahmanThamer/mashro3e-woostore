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

class PSDescriptionSectionData extends PSSectionData {
  final bool expanded;
  final bool showTitle;

  const PSDescriptionSectionData({
    required int id,
    StyledData? styledData,
    this.expanded = false,
    this.showTitle = true,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: PSSectionType.description,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'expanded': expanded,
      'showTitle': showTitle,
    };
  }

  factory PSDescriptionSectionData.fromMap(Map<String, dynamic> map) {
    return PSDescriptionSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      styledData: StyledData.fromMap(map['styledData']),
      expanded: ModelUtils.createBoolProperty(map['expanded']),
      showTitle: ModelUtils.createBoolProperty(map['showTitle']),
    );
  }

  @override
  PSDescriptionSectionData copyWith({
    StyledData? styledData,
    bool? expanded,
    bool? showTitle,
  }) {
    return PSDescriptionSectionData(
      id: id,
      styledData: styledData ?? this.styledData,
      expanded: expanded ?? this.expanded,
      showTitle: showTitle ?? this.showTitle,
    );
  }
}

class PSShortDescriptionSectionData extends PSSectionData {
  final bool expanded;
  final bool showTitle;

  const PSShortDescriptionSectionData({
    required int id,
    StyledData? styledData,
    this.expanded = false,
    this.showTitle = true,
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: PSSectionType.shortDescription,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'expanded': expanded,
      'showTitle': showTitle,
    };
  }

  factory PSShortDescriptionSectionData.fromMap(Map<String, dynamic> map) {
    return PSShortDescriptionSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      styledData: StyledData.fromMap(map['styledData']),
      expanded: ModelUtils.createBoolProperty(map['expanded']),
      showTitle: ModelUtils.createBoolProperty(map['showTitle']),
    );
  }

  @override
  PSShortDescriptionSectionData copyWith({
    StyledData? styledData,
    bool? expanded,
    bool? showTitle,
  }) {
    return PSShortDescriptionSectionData(
      id: id,
      styledData: styledData ?? this.styledData,
      expanded: expanded ?? this.expanded,
      showTitle: showTitle ?? this.showTitle,
    );
  }
}
