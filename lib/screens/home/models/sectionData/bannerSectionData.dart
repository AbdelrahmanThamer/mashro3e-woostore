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
class BannerSectionData extends CustomSectionData {
  final String imageUrl;
  final WooProductTag tag;
  final WooProductCategory category;
  final double margin;
  final double borderRadius;

  const BannerSectionData({
    @required this.imageUrl,
    @required this.tag,
    @required this.category,
    @required this.margin,
    @required this.borderRadius,
    @required bool show,
    @required SectionType sectionType,
  }) : super(
          show: show,
          sectionType: sectionType,
        );

  const BannerSectionData.empty({
    this.imageUrl = '',
    this.tag,
    this.category,
    this.borderRadius = 0,
    this.margin = 0,
  }) : super(
          show: false,
          sectionType: SectionType.banner,
        );

  factory BannerSectionData.fromMap(Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data from of the section type
      final Map<String, dynamic> bannerData = map['banner_data'];

      if (bannerData == null) {
        Dev.info('bannerData is null, returning empty object');
        return const BannerSectionData.empty();
      }

      final _tag = bannerData['tag'] is Map
          ? SectionDataUtils.extractTag(bannerData['tag'])
          : null;

      final _category = bannerData['category'] is Map
          ? SectionDataUtils.extractCategory(bannerData['category'])
          : null;

      if (_tag == null && _category == null) {
        Dev.info('_tag and _category both are null, returning empty object');
        return const BannerSectionData.empty();
      }

      // Image url
      final String _imageUrl =
          bannerData['image'] != null ? bannerData['image'] as String : '';
      final double _margin = bannerData['margin'] != null
          ? double.parse(bannerData['margin'].toString())
          : 0.0;
      final double _borderRadius = bannerData['border_radius'] != null
          ? double.parse(bannerData['border_radius'].toString())
          : 0.0;

      return BannerSectionData(
        imageUrl: _imageUrl,
        tag: _tag,
        category: _category,
        margin: _margin,
        borderRadius: _borderRadius,
        show: _show,
        sectionType: SectionType.banner,
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return const BannerSectionData.empty();
    }
  }
}
