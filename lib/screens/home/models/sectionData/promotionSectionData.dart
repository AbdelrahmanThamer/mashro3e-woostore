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
class PromotionSectionData extends CustomSectionData {
  final WooProductTag tag;
  final SectionLayout layout;
  final int imageCount;
  final int columns;
  final List<String> images;

  const PromotionSectionData({
    @required this.tag,
    @required this.layout,
    @required this.imageCount,
    @required this.columns,
    @required this.images,
    @required bool show,
    @required SectionType sectionType,
  }) : super(
          show: show,
          sectionType: sectionType,
        );

  const PromotionSectionData.empty({
    this.tag,
    this.layout,
    this.imageCount = 0,
    this.columns = 2,
    this.images = const [],
  }) : super(
          show: false,
          sectionType: SectionType.promotion,
        );

  factory PromotionSectionData.fromMap(Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data from of the section type
      final Map<String, dynamic> promoData = map['promotion_data'];

      // Extract the tag from the regular data
      final tagData = promoData['tag'];

      // WooProduct Tag
      final WooProductTag _productTag = WooProductTag(
        id: int.parse(tagData['term_id'].toString()),
        name: tagData['name'] as String,
        slug: tagData['slug'] as String,
        count: int.parse(tagData['count']?.toString() ?? '0'),
      );

      final SectionLayout _layout =
          HomeUtils.convertStringToSectionLayout(promoData['layout']);

      // The number of columns to show in the grid
      int _columns = 2;

      if (_layout == SectionLayout.grid) {
        _columns = int.parse(promoData['columns'].toString() ?? '2');
      }

      if (_layout == SectionLayout.mediumGrid) {
        _columns = int.parse(promoData['columns'].toString() ?? '3');
      }

      final int _imageCount =
          int.parse(promoData['image_count'].toString() ?? '0');

      final List<String> _images = [];

      final List<dynamic> tempList = promoData['images'] != null
          ? promoData['images'].values.toList()
          : const [];

      if (tempList.isNotEmpty) {
        for (var i = 0; i < _imageCount; ++i) {
          _images.add(tempList[i]);
        }
      }

      return PromotionSectionData(
        tag: _productTag,
        layout: _layout,
        columns: _columns,
        imageCount: _imageCount,
        images: _images,
        show: _show,
        sectionType: SectionType.promotion,
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return const PromotionSectionData.empty();
    }
  }
}
