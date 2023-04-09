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
class SliderSingleProductSectionData extends CustomSectionData {
  final double height;
  final double borderRadius;
  final double margin;
  final int itemCount;
  final bool autoPlay;
  final List<SliderSingleProductSectionDataItem> items;

  const SliderSingleProductSectionData({
    @required this.height,
    @required this.itemCount,
    @required this.items,
    this.borderRadius = 10,
    this.margin = 10,
    this.autoPlay = false,
    @required bool show,
  }) : super(
          show: show,
          sectionType: SectionType.sliderSingleProduct,
        );

  const SliderSingleProductSectionData.empty({
    this.height = 150.0,
    this.margin = 0,
    this.borderRadius = 0,
    this.itemCount,
    this.items,
    this.autoPlay = false,
  }) : super(
          show: false,
          sectionType: SectionType.sliderSingleProduct,
        );

  factory SliderSingleProductSectionData.fromMap(Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data of the section type
      final Map<String, dynamic> sliderData = map['slider_single_product_data'];

      final double _margin =
          double.parse(sliderData['margin'].toString()) ?? 0.0;
      final double _borderRadius =
          double.parse(sliderData['border_radius'].toString()) ?? 0.0;
      final double _height =
          double.parse(sliderData['height'].toString()) ?? 150.0;

      final int _itemCount =
          int.parse(sliderData['item_count']?.toString() ?? '0');

      final List<SliderSingleProductSectionDataItem> _items = [];

      final List<dynamic> tempList = sliderData['items'] != null
          ? sliderData['items'].values.toList()
          : const [];

      if (_itemCount > 0) {
        if (tempList.isNotEmpty) {
          for (var i = 0; i < _itemCount; ++i) {
            final item =
                SliderSingleProductSectionDataItem.fromMap(tempList[i]);
            _items.add(item);
          }
        }
      }
      final _autoPlay = sliderData['auto_play'] as bool ?? false;

      return SliderSingleProductSectionData(
        height: _height,
        margin: _margin,
        borderRadius: _borderRadius,
        itemCount: _itemCount,
        items: _items,
        show: _show,
        autoPlay: _autoPlay,
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return const SliderSingleProductSectionData.empty();
    }
  }
}

@immutable
class SliderSingleProductSectionDataItem {
  final String imageUrl;
  final String productId;

  const SliderSingleProductSectionDataItem({
    @required this.imageUrl,
    @required this.productId,
  });

  const SliderSingleProductSectionDataItem.empty({
    this.imageUrl = '',
    this.productId,
  });

  factory SliderSingleProductSectionDataItem.fromMap(Map<String, dynamic> map) {
    try {
      final String _imageUrl = map['image'] ?? '';

      /// The product id associated with the section
      final String _productId =
          map['product_id'] != null ? map['product_id'].toString() : '';

      return SliderSingleProductSectionDataItem(
        imageUrl: _imageUrl,
        productId: _productId,
      );
    } catch (e, s) {
      Dev.error(
        'SliderSingleProductSectionDataItem error',
        error: e,
        stackTrace: s,
      );
      return const SliderSingleProductSectionDataItem.empty();
    }
  }
}
