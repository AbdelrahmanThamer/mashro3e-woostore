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

part of '../customSectionData.dart';

@immutable
class DividerSectionData extends CustomSectionData {
  const DividerSectionData({
    required int id,
    required String name,
    required bool show,
    StyledData styledData = const StyledData(
      backgroundColor: '#FFC8C8C8',
      borderRadius: 10,
    ),
    this.height = 20,
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.divider,
          styledData: styledData,
        );

  final double height;

  DividerSectionData.empty({
    this.height = 20,
    StyledData styledData = const StyledData(
      backgroundColor: '#FFC8C8C8',
      borderRadius: 10,
    ),
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Divider Section',
          show: false,
          sectionType: SectionType.divider,
          styledData: styledData,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'height': height,
    };
  }

  factory DividerSectionData.fromMap(Map<String, dynamic> map) {
    try {
      return DividerSectionData(
        id: ModelUtils.createIntProperty(map['id']),
        height: ModelUtils.createDoubleProperty(map['height'], 20),
        show: ModelUtils.createBoolProperty(map['show']),
        name: ModelUtils.createStringProperty(map['name']),
        styledData: StyledData.fromMap(map['styledData']),
      );
    } catch (_) {
      return DividerSectionData.empty();
    }
  }

  @override
  DividerSectionData copyWith({
    int? id,
    double? height,
    bool? show,
    String? name,
    StyledData? styledData,
    AppAction? action,
  }) {
    return DividerSectionData(
      id: id ?? this.id,
      height: height ?? this.height,
      show: show ?? this.show,
      name: name ?? this.name,
      styledData: styledData ?? this.styledData,
    );
  }
}
