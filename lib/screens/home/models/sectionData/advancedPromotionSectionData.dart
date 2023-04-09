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
class AdvancedPromotionSectionData extends CustomSectionData {
  final SectionLayout layout;
  final double height;
  final int columns;
  final double borderRadius;
  final int itemCount;
  final bool showLabel;
  final List<AdvancedPromotionSectionDataItem> items;

  const AdvancedPromotionSectionData({
    @required this.layout,
    @required bool show,
    @required SectionType sectionType,
    this.height = 100,
    this.columns = 3,
    this.borderRadius = 10,
    this.showLabel = false,
    @required this.itemCount,
    @required this.items,
  }) : super(
          show: show,
          sectionType: sectionType,
        );

  const AdvancedPromotionSectionData.empty({
    this.layout,
    this.height,
    this.columns,
    this.borderRadius,
    this.itemCount,
    this.items,
    this.showLabel,
  }) : super(
          show: false,
          sectionType: SectionType.advancedPromotion,
        );

  factory AdvancedPromotionSectionData.fromMap(Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data from of the section type
      final Map<String, dynamic> advancedPromotionData =
          map['advanced_promotion_data'];

      if (advancedPromotionData == null) {
        Dev.info('advancedPromotionData is null, returning empty object');
        return const AdvancedPromotionSectionData.empty();
      }

      // The layout of the section
      final SectionLayout _layout = HomeUtils.convertStringToSectionLayout(
          advancedPromotionData['layout']);

      final double _borderRadius =
          double.parse(advancedPromotionData['border_radius'].toString()) ??
              0.0;

      final double _height =
          double.parse(advancedPromotionData['height'].toString()) ?? 100.0;

      final int _columns =
          int.parse(advancedPromotionData['columns'].toString()) ?? 3;

      final int _itemCount =
          int.parse(advancedPromotionData['item_count']?.toString() ?? '0');

      final List<AdvancedPromotionSectionDataItem> _items = [];

      final List<dynamic> tempList = advancedPromotionData['items'] != null
          ? advancedPromotionData['items'].values.toList()
          : const [];

      if (_itemCount > 0) {
        if (tempList.isNotEmpty) {
          for (var i = 0; i < _itemCount; ++i) {
            final item = AdvancedPromotionSectionDataItem.fromMap(tempList[i]);
            _items.add(item);
          }
        }
      }

      return AdvancedPromotionSectionData(
        show: _show,
        layout: _layout,
        sectionType: SectionType.advancedPromotion,
        itemCount: _itemCount,
        items: _items,
        borderRadius: _borderRadius,
        height: _height,
        columns: _columns,
        showLabel: advancedPromotionData['show_label'] as bool ?? false,
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return const AdvancedPromotionSectionData.empty();
    }
  }
}

@immutable
class AdvancedPromotionSectionDataItem {
  final String imageUrl;
  final WooProductTag tag;
  final WooProductCategory category;

  const AdvancedPromotionSectionDataItem({
    @required this.imageUrl,
    this.tag,
    this.category,
  });

  const AdvancedPromotionSectionDataItem.empty({
    this.imageUrl = '',
    this.tag,
    this.category,
  });

  factory AdvancedPromotionSectionDataItem.fromMap(Map<String, dynamic> map) {
    try {
      final String _imageUrl = map['image'] ?? '';

      final _tag =
          map['tag'] is Map ? SectionDataUtils.extractTag(map['tag']) : null;
      final _category = map['category'] is Map
          ? SectionDataUtils.extractCategory(map['category'])
          : null;

      return AdvancedPromotionSectionDataItem(
        imageUrl: _imageUrl,
        tag: _tag,
        category: _category,
      );
    } catch (e) {
      Dev.error(e);
      return const AdvancedPromotionSectionDataItem.empty();
    }
  }
}
