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

part of '../../customSectionData.dart';

@immutable
class AdvancedPromotionExternalLinkSectionData extends CustomSectionData {
  final SectionLayout layout;
  final double height;
  final int columns;
  final double borderRadius;
  final int itemCount;
  final bool showLabel;
  final List<AdvancedPromotionExternalLinkSectionDataItem> items;

  const AdvancedPromotionExternalLinkSectionData({
    @required this.layout,
    @required bool show,
    this.height = 100,
    this.columns = 3,
    this.borderRadius = 10,
    this.showLabel = false,
    @required this.itemCount,
    @required this.items,
  }) : super(
          show: show,
          sectionType: SectionType.advancedPromotionExternalLink,
        );

  const AdvancedPromotionExternalLinkSectionData.empty({
    this.layout,
    this.height,
    this.columns,
    this.borderRadius,
    this.itemCount,
    this.items,
    this.showLabel,
  }) : super(
          show: false,
          sectionType: SectionType.advancedPromotionExternalLink,
        );

  factory AdvancedPromotionExternalLinkSectionData.fromMap(
      Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data from of the section type
      final Map<String, dynamic> advancedPromotionExternalLinkData =
          map['advanced_promotion_external_link_data'];

      if (advancedPromotionExternalLinkData == null) {
        Dev.info(
            'advancedPromotionExternalLinkData is null, returning empty object');
        return const AdvancedPromotionExternalLinkSectionData.empty();
      }

      // The layout of the section
      final SectionLayout _layout = HomeUtils.convertStringToSectionLayout(
          advancedPromotionExternalLinkData['layout']);

      final double _borderRadius = double.parse(
              advancedPromotionExternalLinkData['border_radius'].toString()) ??
          0.0;

      final double _height = double.parse(
              advancedPromotionExternalLinkData['height'].toString()) ??
          100.0;

      final int _columns =
          int.parse(advancedPromotionExternalLinkData['columns'].toString()) ??
              3;

      final int _itemCount = int.parse(
          advancedPromotionExternalLinkData['item_count']?.toString() ?? '0');

      final List<AdvancedPromotionExternalLinkSectionDataItem> _items = [];

      final List<dynamic> tempList =
          advancedPromotionExternalLinkData['items'] != null
              ? advancedPromotionExternalLinkData['items'].values.toList()
              : const [];

      if (_itemCount > 0) {
        if (tempList.isNotEmpty) {
          for (var i = 0; i < _itemCount; ++i) {
            final item = AdvancedPromotionExternalLinkSectionDataItem.fromMap(
                tempList[i]);
            _items.add(item);
          }
        }
      }

      return AdvancedPromotionExternalLinkSectionData(
        show: _show,
        layout: _layout,
        itemCount: _itemCount,
        items: _items,
        borderRadius: _borderRadius,
        height: _height,
        columns: _columns,
        showLabel:
            advancedPromotionExternalLinkData['show_label'] as bool ?? false,
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return const AdvancedPromotionExternalLinkSectionData.empty();
    }
  }
}

@immutable
class AdvancedPromotionExternalLinkSectionDataItem {
  final String imageUrl;
  final String externalLink;
  final String label;

  const AdvancedPromotionExternalLinkSectionDataItem({
    @required this.imageUrl,
    this.externalLink,
    this.label,
  });

  const AdvancedPromotionExternalLinkSectionDataItem.empty({
    this.imageUrl = '',
    this.externalLink,
    this.label,
  });

  factory AdvancedPromotionExternalLinkSectionDataItem.fromMap(
      Map<String, dynamic> map) {
    try {
      final String _imageUrl = map['image'] ?? '';

      /// The external link for the section
      final String _externalLink =
          map['external_link'] != null ? map['external_link'] as String : '';

      return AdvancedPromotionExternalLinkSectionDataItem(
        imageUrl: _imageUrl,
        externalLink: _externalLink,
        label: map['label'],
      );
    } catch (e) {
      Dev.error(e);
      return const AdvancedPromotionExternalLinkSectionDataItem.empty();
    }
  }
}
