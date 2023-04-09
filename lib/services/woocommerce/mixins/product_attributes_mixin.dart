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

import 'package:quiver/strings.dart';

import '../../../developer/dev.log.dart';
import '../woocommerce.service.dart';

/// Holds the information about the filter product attributes used
/// in various filter modals / screens
mixin ProductAttributesMixin {
  /// List of filter attributes to be consumed by various
  /// filter modals / screens.
  List<WooStoreProductAttribute> productAttributes = [];

  Future<List<WooStoreProductAttribute>> fetchProductAttributes(
      [String? taxonomyQuery]) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'fetchProductAttributes',
      className: 'ProductAttributesMixin',
      fileName: 'product_attributes_mixin.dart',
      start: true,
    );
    try {
      String endpoint = 'products/attributes';
      if (isNotBlank(taxonomyQuery)) {
        endpoint = endpoint + '?attrs=$taxonomyQuery';
      }
      final response = await wooCommerce.get(endpoint);

      if (response == null) {
        return const [];
      }
      final List<WooStoreProductAttribute> result = [];
      for (final elem in response) {
        result.add(WooStoreProductAttribute.fromJson(elem));
      }

      // Set the result to the accessible list
      productAttributes = result;

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchProductAttributes',
        className: 'ProductAttributesMixin',
        fileName: 'product_attributes_mixin.dart',
        start: false,
      );
      return result;
    } catch (e, s) {
      Dev.error('fetchProductAttributes', error: e, stackTrace: s);
      return const [];
    }
  }
}
