// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

import 'package:meta/meta.dart';

import '../../../developer/dev.log.dart';
import '../woocommerce.service.dart';

mixin WooProductTagsMixin {
  /// Retrieve all the tags to sort products into
  Future<List<WooProductTag>> getTags() async {
    try {
      final List<WooProductTag> _result = await wooCommerce.getProductTags(
        perPage: 100,
      );
      return _result;
    } catch (e) {
      rethrow;
    }
  }

  /// Get all the products with the single specified tag which must be the
  /// [ID] of the tag
  Future<List<WooProduct>> getProductsByTag({
    @required WooProductTag tag,
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      Dev.debugFunction(
        functionName: 'getProductsByTag',
        className: 'WooProductTagsMixin',
        start: true,
        fileName: 'ProductTags.mixin',
      );

      if (tag.id == null || tag.id.toString().isEmpty) {
        throw Exception('Tag id cannot be null or empty');
      }

      final List<WooProduct> _result = await wooCommerce.getProducts(
        tag: tag.id.toString(),
        perPage: perPage,
        page: page,
      );

      Dev.info('Result of length ${_result.length}');

      Dev.debugFunction(
        functionName: 'getProductsByTag',
        className: 'WooProductTagsMixin',
        start: false,
        fileName: 'ProductTags.mixin',
      );

      return _result;
    } catch (e) {
      rethrow;
    }
  }

  /// Get all the products with multiple tags which must be the
  /// [IDs] of the tags
  Future<List<WooProduct>> getProductsByMultipleTag({
    @required List<WooProductTag> tags,
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'getProductsByMultipleTag',
        className: 'WooProductTagsMixin',
        fileName: 'productTags.mixin.dart',
        start: true,
      );

      if (tags.isEmpty) {
        throw Exception('Tags list cannot be empty');
      }

      final List<String> _tagIds = [];

      for (final item in tags) {
        _tagIds.add(item.id?.toString());
      }

      final result = await wooCommerce.getProducts(
        tag: _tagIds.join(','),
      );

      // Function Log
      Dev.debugFunction(
        functionName: 'getProductsByMultipleTag',
        className: 'WooProductTagsMixin',
        fileName: 'productTags.mixin.dart',
        start: false,
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
