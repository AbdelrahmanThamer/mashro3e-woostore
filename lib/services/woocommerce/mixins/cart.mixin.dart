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

import '../../../constants/wooConfig.dart';
import '../woostore_pro_cart/woostore_pro_cart.dart';

/// Implements the CoCart Rest API methods to access the cart
/// in the website to preform cart actions for the users
mixin CartMixin {
  final WooStoreProCart cart = WooStoreProCart(WooConfig.wordPressUrl);
}
