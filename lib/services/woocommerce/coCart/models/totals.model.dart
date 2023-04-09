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

/// Contains the information about the total amount of the cart
/// including taxes and shipping values.
class CoCartTotals {
  double cartContentsTax;
  double cartContentsTotal;
  double discountTax;
  double discountTotal;
  double feeTax;
  double feeTotal;
  double shippingTax;
  double shippingTotal;
  double subtotal;
  double subtotalTax;
  double total;
  double totalTax;

  CoCartTotals({
    this.cartContentsTax,
    this.cartContentsTotal,
    this.discountTax,
    this.discountTotal,
    this.feeTax,
    this.feeTotal,
    this.shippingTax,
    this.shippingTotal,
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.totalTax,
  });

  factory CoCartTotals.fromMap(Map<String, dynamic> map) {
    return CoCartTotals(
      cartContentsTax: map['cart_contents_tax'],
      cartContentsTotal: double.parse(map['cart_contents_total'] as String),
      discountTax: (map['discount_tax'] as int).toDouble(),
      discountTotal: map['discount_total'],
      feeTax: (map['fee_tax'] as int).toDouble(),
      feeTotal: double.parse(map['fee_total'] as String),
      shippingTax: map['shipping_tax'],
      shippingTotal: double.parse(map['shipping_total'] as String),
      subtotal: double.parse(map['subtotal'] as String),
      subtotalTax: map['subtotal_tax'],
      total: double.parse(map['total'] as String),
      totalTax: (map['total_tax'] as int).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['cart_contents_tax'] = cartContentsTax;
    data['cart_contents_total'] = cartContentsTotal;
    data['discount_tax'] = discountTax;
    data['discount_total'] = discountTotal;
    data['fee_tax'] = feeTax;
    data['fee_total'] = feeTotal;
    data['shipping_tax'] = shippingTax;
    data['shipping_total'] = shippingTotal;
    data['subtotal'] = subtotal;
    data['subtotal_tax'] = subtotalTax;
    data['total'] = total;
    data['total_tax'] = totalTax;
    return data;
  }
}
