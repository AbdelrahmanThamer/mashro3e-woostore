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

import 'package:woocommerce/models/order_payload.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../../../locator.dart';

/// Adds the important cart functionality that can be consumed
mixin PublicCartMixin {
  String get totalCost => LocatorService.cartViewModel().totalCost;
  String get subTotal => LocatorService.cartViewModel().subTotal;
  String get discountString => LocatorService.cartViewModel().discountString;
  WooCoupon get selectedCoupon =>
      LocatorService.cartViewModel().selectedCoupon.value;
  List<WPILineItems> get cartLineItems =>
      LocatorService.cartViewModel().createOrderWPILineItems();
  String get customerNote => LocatorService.cartViewModel().customerNote;
}
