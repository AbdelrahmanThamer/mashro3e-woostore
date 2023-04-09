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
class BannerSingleProductSectionData extends CustomSectionData {
  final String imageUrl;
  final double margin;
  final double borderRadius;
  final String productId;

  const BannerSingleProductSectionData({
    @required this.imageUrl,
    @required this.margin,
    @required this.borderRadius,
    @required this.productId,
    @required bool show,
  }) : super(
          show: show,
          sectionType: SectionType.bannerSingleProduct,
        );

  const BannerSingleProductSectionData.empty({
    this.imageUrl = '',
    this.productId,
    this.borderRadius = 0,
    this.margin = 0,
  }) : super(
          show: false,
          sectionType: SectionType.bannerSingleProduct,
        );

  factory BannerSingleProductSectionData.fromMap(Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data from of the section type
      final Map<String, dynamic> bannerData = map['banner_single_product_data'];

      if (bannerData == null) {
        Dev.info('bannerSingleProductData is null, returning empty object');
        return const BannerSingleProductSectionData.empty();
      }

      /// The product id associated with the section
      final String _productId = bannerData['product_id'] != null
          ? bannerData['product_id'].toString()
          : '';

      // Image url
      final String _imageUrl =
          bannerData['image'] != null ? bannerData['image'] as String : '';
      final double _margin = bannerData['margin'] != null
          ? double.parse(bannerData['margin'].toString())
          : 0.0;
      final double _borderRadius = bannerData['border_radius'] != null
          ? double.parse(bannerData['border_radius'].toString())
          : 0.0;

      return BannerSingleProductSectionData(
        imageUrl: _imageUrl,
        margin: _margin,
        productId: _productId,
        borderRadius: _borderRadius,
        show: _show,
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return const BannerSingleProductSectionData.empty();
    }
  }
}
