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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:woocommerce/woocommerce.dart';

class WooStoreProCartData {
  final double total;
  final List<WooStoreProCartItemData> items;

  /// This property is set for the response for GUEST CART when
  /// all the products are added to the cart and their success or error
  /// responses are recorded for the user
  final List<WooStoreProCartItemAddToCartResult>? lineItemAddToCartResult;

  const WooStoreProCartData({
    this.total = 0,
    this.items = const [],
    this.lineItemAddToCartResult,
  });

  factory WooStoreProCartData.fromMap(Map<String, dynamic> map) {
    return WooStoreProCartData(
      total: ModelUtils.createDoubleProperty(map['totals']['subtotal']),
      items: ModelUtils.createListOfType<WooStoreProCartItemData>(
        map['line_items'],
        (e) => WooStoreProCartItemData.fromMap(e),
      ),
      lineItemAddToCartResult: ModelUtils.createListOfType(
        map['line_items_add_to_cart_result'],
        (elem) => WooStoreProCartItemAddToCartResult.fromMap(elem),
      ),
    );
  }
}

class WooStoreProCartItemActionResponseData {
  final WooStoreProCartItemData item;
  final double total;

  const WooStoreProCartItemActionResponseData({
    required this.item,
    required this.total,
  });

  factory WooStoreProCartItemActionResponseData.fromMap(
      Map<String, dynamic> map) {
    return WooStoreProCartItemActionResponseData(
      item: WooStoreProCartItemData.fromMap(map['item']),
      total: ModelUtils.createDoubleProperty(map['subtotal']),
    );
  }
}

class WooStoreProCartItemData {
  final String cartItemKey;
  final WooProduct product;
  final int quantity;
  final WooProductVariation? variation;
  final List<WooStoreProCartItemAddOnData>? addOns;

  const WooStoreProCartItemData({
    required this.cartItemKey,
    required this.product,
    this.quantity = 1,
    this.variation,
    this.addOns,
  });

  factory WooStoreProCartItemData.fromMap(Map<String, dynamic> map) {
    return WooStoreProCartItemData(
      cartItemKey: ModelUtils.createStringProperty(map['cart_item_key']),
      product: WooProduct.fromJson(map['product']),
      quantity: ModelUtils.createIntProperty(map['quantity']),
      variation: map['variation'] != null
          ? WooProductVariation.fromJson(map['variation'])
          : null,
      addOns: ModelUtils.createListOfType(
        map['addons'],
        (elem) => WooStoreProCartItemAddOnData.fromMap(elem),
      ),
    );
  }
}

class RawWooStoreProCartItemData {
  final String? cartItemKey;
  final int productId;
  final int quantity;
  final int? variationId;
  final Map<String, dynamic>? variationData, cartItemData;

  const RawWooStoreProCartItemData({
    this.cartItemKey,
    required this.productId,
    required this.quantity,
    this.variationId,
    this.variationData,
    this.cartItemData,
  });

  Map<String, dynamic> toMap() {
    return {
      'cart_item_key': cartItemKey,
      'product_id': productId,
      'quantity': quantity,
      'variation_id': variationId,
      // 'variation': variationData,
      'cart_item_data': cartItemData,
    };
  }

  factory RawWooStoreProCartItemData.fromMap(Map<String, dynamic> map) {
    return RawWooStoreProCartItemData(
      cartItemKey: ModelUtils.createStringProperty(map['cart_item_key']),
      productId: ModelUtils.createIntProperty(map['product_id']),
      quantity: ModelUtils.createIntProperty(map['quantity']),
      variationId: ModelUtils.createIntProperty(map['variation_id']),
      variationData:
          ModelUtils.createMapOfType<String, dynamic>(map['variation']),
      cartItemData:
          ModelUtils.createMapOfType<String, dynamic>(map['cart_item_data']),
    );
  }
}

class WooStoreProCartItemAddOnData {
  final String? name;
  final String? value;
  final double? price;
  final String? fieldType;
  final String? priceType;

  const WooStoreProCartItemAddOnData({
    this.name,
    this.value,
    this.price,
    this.fieldType,
    this.priceType,
  });

  factory WooStoreProCartItemAddOnData.fromMap(Map<String, dynamic> map) {
    return WooStoreProCartItemAddOnData(
      name: ModelUtils.createStringProperty(map['name']),
      value: ModelUtils.createStringProperty(map['value']),
      price: ModelUtils.createDoubleProperty(map['price']),
      fieldType: ModelUtils.createStringProperty(map['field_type']),
      priceType: ModelUtils.createStringProperty(map['price_type']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
      'price': price,
      'field_type': fieldType,
      'price_type': priceType,
    };
  }
}

class WooStoreProGuestCartPayload {
  final String? couponCode;
  final List<RawWooStoreProCartItemData> lineItems;

  const WooStoreProGuestCartPayload({
    this.couponCode,
    this.lineItems = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'coupon_code': couponCode,
      'line_items': lineItems.map((e) => e.toMap()).toList(),
    };
  }

  factory WooStoreProGuestCartPayload.fromMap(Map<String, dynamic> map) {
    return WooStoreProGuestCartPayload(
      couponCode: ModelUtils.createStringProperty(map['couponCode']),
      lineItems: ModelUtils.createListOfType(
        map['lineItems'],
        (elem) => RawWooStoreProCartItemData.fromMap(elem),
      ),
    );
  }
}

class WooStoreProCartItemAddToCartResult {
  final bool success;
  final String? error;
  final Map<String, dynamic> lineItem;

  const WooStoreProCartItemAddToCartResult({
    required this.success,
    this.error,
    required this.lineItem,
  });

  factory WooStoreProCartItemAddToCartResult.fromMap(Map<String, dynamic> map) {
    return WooStoreProCartItemAddToCartResult(
      success: ModelUtils.createBoolProperty(map['success'], true),
      error: ModelUtils.createStringProperty(map['error']),
      lineItem: ModelUtils.createMapOfType<String, dynamic>(map['line_item']),
    );
  }
}
