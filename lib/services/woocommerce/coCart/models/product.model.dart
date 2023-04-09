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

import 'package:flutter/foundation.dart';

import '../../../../developer/dev.log.dart';

class CoCartProductItem {
  /// If variation id is greater than 0, it means that this is a
  /// variable product and the variation must be the main product
  /// hence the unique [id] should be the variation id. If variation id
  /// is less than or equal to 0 then the product is simple and
  /// only the product id must be the unique [id] of this data class
  final int id;
  String key;
  String name;
  String slug;
  int productId;
  int variationId;
  Map variationData;
  bool isVariable;
  int quantity;
  String price;
  String dataHash;
  String subTotal;
  String total;
  double tax;

  CoCartProductItem({
    this.id,
    @required this.productId,
    this.variationId,
    this.key,
    this.name,
    this.slug,
    this.variationData,
    this.isVariable,
    this.quantity = 1,
    this.price,
    this.dataHash,
    this.total,
    this.subTotal,
    this.tax,
  });

  factory CoCartProductItem.fromMap(Map<String, dynamic> map) {
    // Set the Id
    int _id;

    final int _productId = map['product_id'] as int;
    final int _variationId = map['variation_id'] as int;

    final bool _isVariable = _variationId != null && _variationId > 0;

    if (_isVariable) {
      _id = _variationId;
    } else {
      _id = _productId;
    }

    String _price;
    try {
      if (map['price'] != null) {
        _price = map['price'];
      } else if (map['product_price'] != null) {
        _price = map['product_price'];
        _price.substring(0, 1);
      }
    } catch (e, s) {
      Dev.error(
        'Cannot find price for CoCartProductItem.fromMap',
        error: e,
        stackTrace: s,
      );
    }

    Map _variationData = {};

    try {
      if (map['variation_data'] is Map) {
        _variationData = map['variation_data'];
      }
    } catch (_) {}

    final p = CoCartProductItem(
      id: _id,
      key: map['key'] as String,
      name: map['product_title'] as String,
      slug: map['slug'] as String,
      productId: _productId,
      variationId: _variationId,
      isVariable: _isVariable,
      variationData: _variationData,
      quantity: map['quantity'] as int,
      price: _price,
      dataHash: map['data_hash'] as String,
      total: map['line_total'].toString(),
      subTotal: map['line_subtotal'].toString(),
      tax: double.tryParse(map['line_tax'].toString()),
    );

    return p;
  }

  CoCartProductItem copyWith({
    int id,
    String key,
    String name,
    String slug,
    int productId,
    int variationId,
    String productType,
    bool isVariable,
    int quantity,
    String price,
    String dataHash,
    int subTotal,
    int total,
    int tax,
  }) {
    return CoCartProductItem(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      productId: productId ?? this.productId,
      variationId: variationId ?? this.variationId,
      isVariable: isVariable ?? this.isVariable,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      dataHash: dataHash ?? this.dataHash,
      subTotal: subTotal ?? this.subTotal,
      total: total ?? this.total,
      tax: tax ?? this.tax,
    );
  }

  @override
  String toString() {
    return 'CoCartProductItem{id: $id, key: $key, productId: $productId, variationId: $variationId, quantity: $quantity, price: $price, variationData: $variationData}';
  }
}

// Add Item Response - with variation

// {
//   "key": "db6928c1dd7282dbe32b2d2f52f84f45",
//   "product_id": 377,
//   "variation_id": 663,
//   "variation": {
//     "attribute_colour": "Red",
//     "attribute_size": "M"
//   },
//   "quantity": 9,
//   "data_hash": "35a7dff21f3320daf8d2874e2d155cc9",
//   "line_tax_data": {
//     "subtotal": [],
//     "total": []
//   },
//   "line_subtotal": 90,
//   "line_subtotal_tax": 0,
//   "line_total": 90,
//   "line_tax": 0,
//   "data": {},
//   "product_name": "Legends are born in march - Tshirt - Red, M",
//   "product_title": "Legends are born in march - Tshirt",
//   "product_price": "$10.00",
//   "slug": "legends-are-born-in-march-tshirt",
//   "product_type": "variation",
//   "categories": false,
//   "tags": false,
//   "sku": "",
//   "weight": [],
//   "dimensions": {
//     "length": "",
//     "width": "",
//     "height": "",
//     "unit": "cm"
//   },
//   "price_raw": "10",
//   "price": "10.00",
//   "line_price": "90.00",
//   "variation_data": {
//     "Colour": "Red",
//     "Size": "M"
//   },
//   "stock_status": {
//     "status": "In Stock",
//     "stock_quantity": 10,
//     "hex_color": "#7ad03a"
//   },
//   "min_purchase_quantity": 1,
//   "max_purchase_quantity": 10,
//   "virtual": false,
//   "downloadable": false,
//   "gallery": [],
//   "permalink": "http://ecommercestore.local/product/legends-are-born-in-march-tshirt/?attribute_colour=Red&attribute_size=M"
// }
