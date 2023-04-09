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
class SliderSectionData extends CustomSectionData {
  final double height;
  final double borderRadius;
  final double margin;
  final int itemCount;
  final bool autoPlay;
  final List<SliderSectionDataItem> items;

  const SliderSectionData({
    @required this.height,
    @required this.itemCount,
    @required this.items,
    this.borderRadius = 10,
    this.margin = 10,
    this.autoPlay = false,
    @required bool show,
    @required SectionType sectionType,
  }) : super(
          show: show,
          sectionType: sectionType,
        );

  const SliderSectionData.empty({
    this.height = 150.0,
    this.margin = 0,
    this.borderRadius = 0,
    this.itemCount,
    this.items,
    this.autoPlay = false,
  }) : super(
          show: false,
          sectionType: SectionType.slider,
        );

  factory SliderSectionData.fromMap(Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data from of the section type
      final Map<String, dynamic> sliderData = map['slider_data'];

      final double _margin =
          double.parse(sliderData['margin'].toString()) ?? 0.0;
      final double _borderRadius =
          double.parse(sliderData['border_radius'].toString()) ?? 0.0;
      final double _height =
          double.parse(sliderData['height'].toString()) ?? 150.0;

      final int _itemCount =
          int.parse(sliderData['item_count']?.toString() ?? '0');

      final List<SliderSectionDataItem> _items = [];

      final List<dynamic> tempList = sliderData['items'] != null
          ? sliderData['items'].values.toList()
          : const [];

      if (_itemCount > 0) {
        if (tempList.isNotEmpty) {
          for (var i = 0; i < _itemCount; ++i) {
            final item = SliderSectionDataItem.fromMap(tempList[i]);
            _items.add(item);
          }
        }
      }
      final _autoPlay = sliderData['auto_play'] as bool ?? false;

      return SliderSectionData(
        height: _height,
        margin: _margin,
        borderRadius: _borderRadius,
        itemCount: _itemCount,
        items: _items,
        show: _show,
        autoPlay: _autoPlay,
        sectionType: SectionType.slider,
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return const SliderSectionData.empty();
    }
  }
}

@immutable
class SliderSectionDataItem {
  final String imageUrl;
  final WooProductTag tag;

  const SliderSectionDataItem({
    @required this.imageUrl,
    @required this.tag,
  });

  const SliderSectionDataItem.empty({
    this.imageUrl = '',
    this.tag,
  });

  factory SliderSectionDataItem.fromMap(Map<String, dynamic> map) {
    try {
      final String _imageUrl = map['image'] ?? '';

      // Extract the tag from the regular data
      final Map<String, dynamic> tagData = map['tag'];

      // WooProduct Tag
      final WooProductTag _productTag = WooProductTag(
        id: int.parse(tagData['term_id'].toString()),
        name: tagData['name'] as String,
        slug: tagData['slug'] as String,
        count: int.parse(tagData['count']?.toString() ?? '0'),
      );

      return SliderSectionDataItem(
        imageUrl: _imageUrl,
        tag: _productTag,
      );
    } catch (e) {
      Dev.error(e);
      return const SliderSectionDataItem.empty();
    }
  }
}
