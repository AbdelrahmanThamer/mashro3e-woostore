// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

// @dart=2.9

part of '../customSectionData.dart';

@immutable
class RegularSectionData extends CustomSectionData {
  final WooProductTag tag;
  final WooProductCategory category;
  final SectionLayout layout;

  const RegularSectionData({
    @required this.tag,
    @required this.category,
    @required this.layout,
    @required bool show,
    @required SectionType sectionType,
  }) : super(
          show: show,
          sectionType: sectionType,
        );

  const RegularSectionData.empty({
    this.tag,
    this.category,
    this.layout,
  }) : super(
          show: false,
          sectionType: SectionType.regular,
        );

  factory RegularSectionData.fromMap(Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data from of the section type
      final Map<String, dynamic> regularData = map['regular_data'];

      if (regularData == null) {
        Dev.info('regularData is null, returning empty object');
        return const RegularSectionData.empty();
      }

      final _tag = regularData['tag'] is Map
          ? SectionDataUtils.extractTag(regularData['tag'])
          : null;
      final _category = regularData['category'] is Map
          ? SectionDataUtils.extractCategory(regularData['category'])
          : null;

      if (_tag == null && _category == null) {
        Dev.info('Both _tag and _category are null, returning empty object');
        return const RegularSectionData.empty();
      }

      // The layout of the section
      final SectionLayout _layout =
          HomeUtils.convertStringToSectionLayout(regularData['layout']);

      return RegularSectionData(
        tag: _tag,
        category: _category,
        layout: _layout,
        show: _show,
        sectionType: SectionType.regular,
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return const RegularSectionData.empty();
    }
  }
}
