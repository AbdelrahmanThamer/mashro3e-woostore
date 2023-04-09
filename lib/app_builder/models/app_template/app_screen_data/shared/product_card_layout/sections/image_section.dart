// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
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

part of '../product_card_layout.dart';

@immutable
class ImageSectionData extends ProductCardLayoutSectionData {
  final double height;
  final double width;
  final double borderRadius;
  final bool showRating, showLikeButton, showAddToCartButton;
  final BoxFit boxFit;

  const ImageSectionData({
    required this.height,
    required this.width,
    this.borderRadius = 10,
    this.showRating = true,
    this.showLikeButton = true,
    this.showAddToCartButton = true,
    this.boxFit = BoxFit.cover,
  }) : super(
          show: true,
          sectionType: ProductCardSectionType.image,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'height': height,
      'width': width,
      'borderRadius': borderRadius,
      'showRating': showRating,
      'showLikeButton': showLikeButton,
      'showAddToCartButton': showAddToCartButton,
      'boxFit': boxFit.name,
    };
  }

  factory ImageSectionData.fromMap(Map<String, dynamic> map) {
    return ImageSectionData(
      height: ModelUtils.createDoubleProperty(map['height']),
      width: ModelUtils.createDoubleProperty(map['width']),
      borderRadius: ModelUtils.createDoubleProperty(map['borderRadius']),
      showRating: ModelUtils.createBoolProperty(map['showRating']),
      showLikeButton: ModelUtils.createBoolProperty(map['showLikeButton']),
      showAddToCartButton:
          ModelUtils.createBoolProperty(map['showAddToCartButton']),
      boxFit: EnumUtils.convertStringToBoxFit(map['boxFit']),
    );
  }

  ImageSectionData copyWith({
    double? height,
    double? width,
    double? borderRadius,
    bool? showRating,
    bool? showLikeButton,
    bool? showAddToCartButton,
    BoxFit? boxFit,
  }) {
    return ImageSectionData(
      height: height ?? this.height,
      width: width ?? this.width,
      borderRadius: borderRadius ?? this.borderRadius,
      showRating: showRating ?? this.showRating,
      showLikeButton: showLikeButton ?? this.showLikeButton,
      showAddToCartButton: showAddToCartButton ?? this.showAddToCartButton,
      boxFit: boxFit ?? this.boxFit,
    );
  }
}
