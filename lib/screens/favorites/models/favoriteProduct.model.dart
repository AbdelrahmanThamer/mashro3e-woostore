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

import '../../../models/models.dart';

/// Data class to hold required information to display
/// favorite products in the application.
class FavoriteProduct {
  /// The id of the product
  final int? productId;

  /// The id of the variation that is selected
  final int? variationId;

  /// Price of the variation or the product in case of simple product
  final String? price;

  /// The name of the product
  final String? name;

  /// The display image of the product
  final String? displayImage;

  const FavoriteProduct({
    this.productId,
    this.variationId,
    this.price,
    this.name,
    this.displayImage,
  });

  /// Create FavoriteProduct from Product instance
  factory FavoriteProduct.fromProduct(Product product) {
    final int? _variationId = product.selectedVariation != null
        ? product.selectedVariation!.id
        : null;

    return FavoriteProduct(
      productId: product.wooProduct.id,
      variationId: _variationId,
      name: product.wooProduct.name,
      price: product.wooProduct.price,
      displayImage: product.displayImage,
    );
  }

  factory FavoriteProduct.fromMap(Map<String, dynamic> map) {
    final int _variationId = map['variationId'] == null
        ? null
        : map['variationId'] is int
            ? map['variationId']
            : int.parse(map['variationId']);
    return FavoriteProduct(
      productId: map['productId'] is int
          ? map['productId']
          : int.parse(map['productId']),
      variationId: _variationId,
      price: map['price'] as String,
      name: map['name'] as String,
      displayImage: map['displayImage'] as String,
    );
  }

  FavoriteProduct copyWith({
    int? productId,
    int? variationId,
    String? price,
    String? name,
    String? displayImage,
  }) {
    if ((productId == null || identical(productId, this.productId)) &&
        (variationId == null || identical(variationId, this.variationId)) &&
        (price == null || identical(price, this.price)) &&
        (name == null || identical(name, this.name)) &&
        (displayImage == null || identical(displayImage, this.displayImage))) {
      return this;
    }

    return FavoriteProduct(
      productId: productId ?? this.productId,
      variationId: variationId ?? this.variationId,
      price: price ?? this.price,
      name: name ?? this.name,
      displayImage: displayImage ?? this.displayImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'variationId': variationId,
      'price': price,
      'name': name,
      'displayImage': displayImage,
    };
  }
}
