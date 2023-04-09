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
class SearchSectionData extends CustomSectionData {
  const SearchSectionData({
    required int id,
    required String name,
    required bool show,
    required StyledData styledData,
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.search,
          styledData: styledData,
        );

  SearchSectionData.empty()
      : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Search Section',
          show: false,
          sectionType: SectionType.search,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
    };
  }

  factory SearchSectionData.fromMap(Map<String, dynamic> map) {
    try {
      return SearchSectionData(
        id: ModelUtils.createIntProperty(map['id']),
        show: ModelUtils.createBoolProperty(map['show']),
        name: ModelUtils.createStringProperty(map['name']),
        styledData: StyledData.fromMap(map['styledData']),
      );
    } catch (_) {
      return SearchSectionData.empty();
    }
  }

  @override
  SearchSectionData copyWith({
    int? id,
    bool? show,
    String? name,
    StyledData? styledData,
  }) {
    return SearchSectionData(
      id: id ?? this.id,
      show: show ?? this.show,
      name: name ?? this.name,
      styledData: styledData ?? this.styledData,
    );
  }
}
