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
class PromotionSingleProductSectionData extends CustomSectionData {
  final String productId;
  final String title;
  final SectionLayout layout;
  final int imageCount;
  final int columns;
  final List<String> images;

  const PromotionSingleProductSectionData({
    @required this.productId,
    @required this.layout,
    @required this.imageCount,
    @required this.columns,
    @required this.images,
    this.title,
    @required bool show,
  }) : super(
          show: show,
          sectionType: SectionType.promotionSingleProduct,
        );

  const PromotionSingleProductSectionData.empty({
    this.productId,
    this.layout,
    this.imageCount = 0,
    this.columns = 2,
    this.images = const [],
    this.title,
  }) : super(
          show: false,
          sectionType: SectionType.promotionSingleProduct,
        );

  factory PromotionSingleProductSectionData.fromMap(Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data from of the section type
      final Map<String, dynamic> promoData =
          map['promotion_single_product_data'];

      final SectionLayout _layout =
          HomeUtils.convertStringToSectionLayout(promoData['layout']);

      /// The product id associated with the section
      final String _productId = promoData['product_id'] != null
          ? promoData['product_id'].toString()
          : '';

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

      return PromotionSingleProductSectionData(
        productId: _productId,
        layout: _layout,
        columns: _columns,
        imageCount: _imageCount,
        images: _images,
        show: _show,
        title: promoData['title'],
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return const PromotionSingleProductSectionData.empty();
    }
  }
}
