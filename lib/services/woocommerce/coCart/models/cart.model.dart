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

// CART WITH ENHANCEMENTS PLUGIN

import 'product.model.dart';

class CoCartEnhanced {
  String cartKey;
  String cartHash;
  List<CoCartProductItem> items = [];
  int itemCount;
  bool needsShipping;
  bool needsPayment;

  CoCartEnhanced({
    this.cartKey,
    this.cartHash,
    this.items,
    this.itemCount,
    this.needsShipping,
    this.needsPayment,
  });

  factory CoCartEnhanced.fromMap(Map<String, dynamic> map) {
    // Create items
    final List<CoCartProductItem> items = [];
    final List<Map<String, dynamic>> _rawItems =
        List<Map<String, dynamic>>.from(map['items']) ??
            const <Map<String, dynamic>>[];
    for (final obj in _rawItems) {
      final CoCartProductItem cip = CoCartProductItem.fromMap(obj);
      items.add(cip);
    }

    return CoCartEnhanced(
      cartKey: map['cart_key'] as String,
      cartHash: map['cart_hash'] as String,
      items: items,
      itemCount: map['item_count'] as int,
      needsShipping: map['needs_shipping'] as bool,
      needsPayment: map['needs_payment'] as bool,
    );
  }
}

// {
//   "currency": "USD",
//   "cart_key": "460bf2d0d0dadaedb1be8c5b9977a8f4",
//   "cart_hash": "87084bd1eb9841d843d4952fac7d6459",

//   "item_count": 1,
//   "needs_shipping": true,
//   "needs_payment": true,
//   "shipping_methods": {
//     "flat_rate:2": {
//       "key": "flat_rate:2",
//       "method_id": "flat_rate",
//       "instance_id": 2,
//       "label": "Flat rate",
//       "cost": "2.00",
//       "html": "Flat rate: $2.00",
//       "taxes": [],
//       "chosen_method": true
//     }
//   },
//   "coupons": [],
//   "totals": {
//     "subtotal": "$50.00",
//     "subtotal_tax": "$0.00",
//     "shipping_total": "$2.00",
//     "shipping_tax": "$0.00",
//     "shipping_taxes": [],
//     "discount_total": "$0.00",
//     "discount_tax": "$0.00",
//     "cart_contents_total": "$50.00",
//     "cart_contents_tax": "$0.00",
//     "cart_contents_taxes": [],
//     "fee_total": "$0.00",
//     "fee_tax": "$0.00",
//     "fee_taxes": [],
//     "total": "$52.00",
//     "total_tax": "$0.00"
//   },
//   "total_weight": {
//     "total": 0,
//     "weight_unit": "kg"
//   },
//   "extras": {
//     "removed_items": {
//       "766ebcd59621e305170616ba3d3dac32": {
//         "key": "766ebcd59621e305170616ba3d3dac32",
//         "product_id": 587,
//         "variation_id": 0,
//         "variation": [],
//         "quantity": 1,
//         "data_hash": "b5c1d5ca8bae6d4896cf1807cdf763f0",
//         "line_tax_data": {
//           "subtotal": [],
//           "total": []
//         },
//         "line_subtotal": 50,
//         "line_subtotal_tax": 0,
//         "line_total": 50,
//         "line_tax": 0
//       }
//     },
//     "cross_sells": []
//   },
//   "notices": []
// }

// CART WITHOUT ENHANCEMENTS

// {
//   "766ebcd59621e305170616ba3d3dac32": {
//     "key": "766ebcd59621e305170616ba3d3dac32",
//     "product_id": 587,
//     "variation_id": 0,
//     "variation": [],
//     "quantity": 1,
//     "data_hash": "b5c1d5ca8bae6d4896cf1807cdf763f0",
//     "line_tax_data": {
//       "subtotal": [],
//       "total": []
//     },
//     "line_subtotal": 50,
//     "line_subtotal_tax": 0,
//     "line_total": 50,
//     "line_tax": 0,
//     "data": {},
//     "product_name": "Prade Game Sunglasses",
//     "product_title": "Prade Game Sunglasses",
//     "product_price": "$50.00"
//   }
// }
