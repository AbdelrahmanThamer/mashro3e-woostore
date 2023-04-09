// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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
class TagsSectionData extends CustomSectionData {
  final SectionLayout layout;
  final double borderRadius;
  final int columns;
  final double height;
  final List<WooProductTag> tags;

  const TagsSectionData({
    @required this.layout,
    @required bool show,
    @required SectionType sectionType,
    this.borderRadius,
    this.columns = 3,
    this.height = 100,
    this.tags,
  }) : super(
          show: show,
          sectionType: sectionType,
        );

  const TagsSectionData.empty({
    this.layout,
    this.borderRadius,
    this.columns,
    this.height,
    this.tags = const [],
  }) : super(
          show: false,
          sectionType: SectionType.tagsSection,
        );

  factory TagsSectionData.fromMap(Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data from of the section type
      final Map<String, dynamic> tagsSectionData = map['tags_section_data'];

      if (tagsSectionData == null) {
        Dev.info('tagsSectionData is null, returning empty object');
        return const TagsSectionData.empty();
      }

      // The layout of the section
      final SectionLayout _layout =
          HomeUtils.convertStringToSectionLayout(tagsSectionData['layout']);

      final double _borderRadius =
          double.parse(tagsSectionData['border_radius'].toString()) ?? 8.0;

      final List<WooProductTag> _tags = [];
      if (tagsSectionData['tags'] != null &&
          tagsSectionData['tags'] is List &&
          (tagsSectionData['tags'] as List).isNotEmpty) {
        for (final elem in tagsSectionData['tags']) {
          try {
            final WooProductTag obj = SectionDataUtils.extractTag(
              Map<String, dynamic>.from(elem),
            );
            _tags.add(obj);
          } catch (e, s) {
            Dev.error(
              'Cannot Create WooProductTag',
              error: e,
              stackTrace: s,
            );
          }
        }
      }

      if (_layout == SectionLayout.list) {
        final double _height =
            double.parse(tagsSectionData['height'].toString()) ?? 40.0;
        return TagsSectionData(
          show: _show,
          layout: _layout,
          sectionType: SectionType.tagsSection,
          borderRadius: _borderRadius,
          height: _height,
          tags: _tags,
        );
      }

      if (_layout == SectionLayout.grid) {
        final int _columns =
            int.parse(tagsSectionData['columns'].toString()) ?? 5;

        return TagsSectionData(
          show: _show,
          layout: _layout,
          sectionType: SectionType.tagsSection,
          borderRadius: _borderRadius,
          columns: _columns,
          tags: _tags,
        );
      }

      // Else layout is wrap
      return TagsSectionData(
        show: _show,
        layout: _layout,
        sectionType: SectionType.tagsSection,
        borderRadius: _borderRadius,
        tags: _tags,
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return const TagsSectionData.empty();
    }
  }
}
