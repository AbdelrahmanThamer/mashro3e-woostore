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
class SaleSectionData extends CustomSectionData {
  final WooProductTag tag;
  final SectionLayout layout;
  final bool showTimer;
  final String saleEndTime;
  final bool showPromotionalImages;
  final int imageCount;
  final List<String> images;

  const SaleSectionData({
    @required this.tag,
    @required this.layout,
    @required this.showTimer,
    @required this.saleEndTime,
    @required this.showPromotionalImages,
    @required this.imageCount,
    @required this.images,
    @required bool show,
    @required SectionType sectionType,
  }) : super(
          show: show,
          sectionType: sectionType,
        );

  const SaleSectionData.empty({
    this.tag,
    this.layout,
    this.showTimer,
    this.saleEndTime,
    this.showPromotionalImages,
    this.imageCount,
    this.images,
  }) : super(
          show: false,
          sectionType: SectionType.sale,
        );

  factory SaleSectionData.fromMap(Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data from of the section type
      final Map<String, dynamic> saleData = map['sale_data'];

      // Extract the tag from the regular data
      final tagData = saleData['tag'];

      // WooProduct Tag
      final WooProductTag _productTag = WooProductTag(
        id: int.parse(tagData['term_id'].toString()),
        name: tagData['name'] as String,
        slug: tagData['slug'] as String,
        count: int.parse(tagData['count']?.toString() ?? '0'),
      );

      // Layout type of the section
      final SectionLayout _layout =
          HomeUtils.convertStringToSectionLayout(saleData['layout']);

      // Information about the sale timer
      final bool _showTimer = saleData['show_timer'] as bool;
      String _saleEndTime = '';
      if (_showTimer) {
        _saleEndTime = saleData['sale_end_time'];
      }

      // Information about the promotional images
      final bool _showImages = saleData['show_images'] as bool;
      int _imageCount = 0;
      final List<String> _images = [];

      if (_showImages) {
        _imageCount = int.parse(saleData['image_count']?.toString() ?? '0');

        final List<dynamic> tempList = saleData['images'] != null
            ? saleData['images'].values.toList()
            : const [];

        if (_imageCount > 0) {
          if (tempList.isNotEmpty) {
            for (var i = 0; i < _imageCount; ++i) {
              _images.add(tempList[i]);
            }
          }
        }
      }

      return SaleSectionData(
        tag: _productTag,
        layout: _layout,
        showTimer: _showTimer,
        saleEndTime: _saleEndTime,
        showPromotionalImages: _showImages,
        imageCount: _imageCount,
        images: _images,
        show: _show,
        sectionType: SectionType.sale,
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return const SaleSectionData.empty();
    }
  }
}
