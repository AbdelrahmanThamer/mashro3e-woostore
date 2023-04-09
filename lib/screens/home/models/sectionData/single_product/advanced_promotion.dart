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
class AdvancedPromotionSingleProductSectionData extends CustomSectionData {
  final SectionLayout layout;
  final double height;
  final int columns;
  final double borderRadius;
  final int itemCount;
  final bool showLabel;
  final List<AdvancedPromotionSingleProductSectionDataItem> items;

  const AdvancedPromotionSingleProductSectionData({
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
          sectionType: SectionType.advancedPromotionSingleProduct,
        );

  const AdvancedPromotionSingleProductSectionData.empty({
    this.layout,
    this.height,
    this.columns,
    this.borderRadius,
    this.itemCount,
    this.items,
    this.showLabel,
  }) : super(
          show: false,
          sectionType: SectionType.advancedPromotionSingleProduct,
        );

  factory AdvancedPromotionSingleProductSectionData.fromMap(
      Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data form of the section type
      final Map<String, dynamic> advancedPromotionExternalLinkData =
          map['advanced_promotion_single_product_data'];

      if (advancedPromotionExternalLinkData == null) {
        Dev.info(
            'advancedPromotionSingleProductData is null, returning empty object');
        return const AdvancedPromotionSingleProductSectionData.empty();
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

      final List<AdvancedPromotionSingleProductSectionDataItem> _items = [];

      final List<dynamic> tempList =
          advancedPromotionExternalLinkData['items'] != null
              ? advancedPromotionExternalLinkData['items'].values.toList()
              : const [];

      if (_itemCount > 0) {
        if (tempList.isNotEmpty) {
          for (var i = 0; i < _itemCount; ++i) {
            final item = AdvancedPromotionSingleProductSectionDataItem.fromMap(
                tempList[i]);
            _items.add(item);
          }
        }
      }

      return AdvancedPromotionSingleProductSectionData(
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
      Dev.error(
        'AdvancedPromotionSingleProductSectionData',
        error: e,
        stackTrace: s,
      );
      return const AdvancedPromotionSingleProductSectionData.empty();
    }
  }
}

@immutable
class AdvancedPromotionSingleProductSectionDataItem {
  final String imageUrl;
  final String productId;
  final String label;

  const AdvancedPromotionSingleProductSectionDataItem({
    @required this.imageUrl,
    this.productId,
    this.label,
  });

  const AdvancedPromotionSingleProductSectionDataItem.empty({
    this.imageUrl,
    this.productId,
    this.label,
  });

  factory AdvancedPromotionSingleProductSectionDataItem.fromMap(
      Map<String, dynamic> map) {
    try {
      final String _imageUrl = map['image'] ?? '';

      final String _productId =
          map['product_id'] != null ? map['product_id'].toString() : '';

      return AdvancedPromotionSingleProductSectionDataItem(
        imageUrl: _imageUrl,
        productId: _productId,
        label: map['label'],
      );
    } catch (e, s) {
      Dev.error(
        'Advanced Promotion Single Product Section Data Item',
        error: e,
        stackTrace: s,
      );
      return const AdvancedPromotionSingleProductSectionDataItem.empty();
    }
  }
}
