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

abstract class WooStoreProCartConstants {
  static const String defaultApiPath = '/wp-json/woostore-pro-api';
  static const String version = '/v2';
  static const String cartApi = '/cart';
}

abstract class WooStoreProCartEndpoints {
  static const String getCart = '/get';
  static const String guestCart = '/guest';
  static const String mergeCart = '/merge';
  static const String uploadFile = '/upload_file';
  static const String addToCart = '/add-item';
  static const String updateItemInCart = '/update-item';
  static const String updateCart = '/update';
  static const String clearCart = '/clear';
  static const String removeItems = '/remove-items';
  static const String maxWoorewardPoints = '/get-max-wooreward-points';
  static const String checkout = '/checkout';

  static String createV2CartEndpoint({
    required String websiteUrl,
    required String backSlashedEndpoint,
  }) {
    return '$websiteUrl${WooStoreProCartConstants.defaultApiPath}${WooStoreProCartConstants.version}${WooStoreProCartConstants.cartApi}$backSlashedEndpoint';
  }
}
