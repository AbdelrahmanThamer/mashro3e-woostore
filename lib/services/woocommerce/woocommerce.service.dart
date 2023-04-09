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

// @dart=2.9

import 'package:meta/meta.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../constants/wooConfig.dart';
import '../../developer/dev.log.dart';
import 'mixins/cart.mixin.dart';
import 'mixins/countries.mixin.dart';
import 'mixins/productTags.mixin.dart';
import 'mixins/product_attributes_mixin.dart';
import 'mixins/shipmentTracking.mixin.dart';
import 'mixins/vendor.mixin.dart';
import 'utils/utils.woo.dart';

export 'package:woocommerce/woocommerce.dart';

export 'coCart/coCart.dart';
export 'enums/sort_option.dart';
export 'mixins/filter_mixin.dart';
export 'models/models.dart';
export 'shipmentTracking/shipmentTracking.dart';
export 'utils/utils.woo.dart';
export 'woostore_pro_cart/woostore_pro_cart.dart';

final WooCommerce wooCommerce = WooCommerce(
  baseUrl: WooConfig.wordPressUrl,
  consumerKey: WooConfig.consumerKey,
  consumerSecret: WooConfig.consumerSecret,
);

/// Creates a singleton instance of WooCommerce service to interact with
/// woo-commerce rest api end points
class WooService
    with
        WooProductTagsMixin,
        CartMixin,
        ShipmentTrackingMixin,
        CountriesMixin,
        ProductAttributesMixin,
        VendorsMixin {
  // Single instance variable
  static WooService _instance;

  // Factory to return a single instance every time
  factory WooService() {
    if (_instance != null) {
      return _instance;
    } else {
      _instance = WooService._();
      return _instance;
    }
  }

  // Private constructor
  WooService._();

  /// Instance of WooCommerce
  final WooCommerce wc = wooCommerce;

  /// Create a WooCustomer and authenticate immediately
  Future<WooCustomer> signUp(
    WooCustomer wooCustomer, {

    /// Extra data to send to the backend without affecting
    /// other classes for verification and checks before
    /// creating the user and other meta data to
    /// save for the user
    Map<String, dynamic> extraData,
  }) async {
    try {
      final WooCustomer result = await wc.createCustomerWithApi(
        wooCustomer,
        extraData,
      );

      if (result != null) {
        cart.setAuthToken(await wc.getAuthTokenFromDb());
      }
      return result;
    } on WooCommerceError catch (e) {
      Dev.error(' Woo Commerce Error', error: e);
      throw WooUtils.removeAllHtmlTags(e.message);
    } catch (e) {
      rethrow;
    }
  }

  /// Perform actions related to login
  Future<WooCustomer> login({
    @required String email,
    @required String password,
  }) async {
    try {
      final WooCustomer result = await wc.loginCustomer(
        email: email,
        password: password,
      );

      return result;
    } on WooCommerceError catch (e) {
      Dev.error(' Woo Commerce Error', error: e);
      throw WooUtils.removeAllHtmlTags(e.message);
    } catch (_) {
      rethrow;
    }
  }

  // Perform actions related to logout
  Future<void> logout() async {
    await cart.reset();
    await wc.logUserOut();
  }

  /// Check if the user is already logged in
  Future<bool> isLoggedIn() async {
    final isLoggedIn = await wc.isCustomerLoggedIn();

    if (isLoggedIn) {
      // set the cart headers
      cart.setAuthToken(await wc.getAuthTokenFromDb());
      return true;
    }
    return false;
  }

  /// Get the categories and sort them into parent-child relations
  Future<List<WooProductCategory>> getCategories({
    List<int> include,
  }) async {
    try {
      Dev.debugFunction(
        functionName: 'getCategories',
        className: 'WooService',
        start: true,
        fileName: 'Woocommerce.service',
      );

      final _tempResult = <WooProductCategory>[];
      int _page = 1;
      bool _fetchMore = true;

      while (_fetchMore) {
        final List<WooProductCategory> _result =
            await wooCommerce.getProductCategories(
          perPage: 100,
          page: _page,
          include: include,
        );

        _result.removeWhere(
          (element) => element.name.toLowerCase() == 'uncategorized',
        );

        _tempResult.addAll(_result);

        // increase the page count
        _page++;

        if (_result is List && _result.length < 100) {
          _fetchMore = false;
        }
      }

      Dev.debugFunction(
        functionName: 'getCategories',
        className: 'TestWooService',
        start: false,
        fileName: 'Woocommerce.service',
      );

      return _tempResult;
    } catch (e) {
      rethrow;
    }
  }

  /// Get all the products with a single specified category which must be the
  /// [ID] of the category
  Future<List<WooProduct>> getProductsByCategory({
    @required WooProductCategory category,
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      Dev.debugFunction(
        functionName: 'getProductsByCategory',
        className: 'TestWooService',
        start: true,
        fileName: 'Woocommerce.service',
      );

      final List<WooProduct> _result = await wooCommerce.getProducts(
        category: category.id.toString(),
        perPage: perPage,
        page: page,
      );

      Dev.debugFunction(
        functionName: 'getProductsByCategory',
        className: 'TestWooService',
        start: false,
        fileName: 'Woocommerce.service',
      );
      return _result;
    } catch (e) {
      rethrow;
    }
  }

  /// Get all the products with multiple specified categories which must be the
  /// [IDs] of each category
  Future<List<WooProduct>> getProductsByMultipleCategories({
    @required List<WooProductCategory> categories,
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      Dev.debugFunction(
        functionName: 'getProductsByMultipleCategories',
        className: 'TestWooService',
        start: true,
        fileName: 'Woocommerce.service',
      );

      if (categories.isEmpty) {
        throw Exception('Categories list cannot be empty');
      }

      final List<String> _categoryIds = [];

      for (final item in categories) {
        _categoryIds.add(item.id?.toString());
      }

      final List<WooProduct> _result = await wc.getProducts(
        category: _categoryIds.join(','),
      );

      // // Create a list of Futures iterable for each tagId
      // final List<Future<List<WooProduct>>> _iterable = [];
      //
      // for (final item in _categoryIds) {
      //   if (item.isNotEmpty) {
      //     _iterable.add(wooCommerce.getProducts(
      //       category: item,
      //       perPage: perPage,
      //       page: page,
      //     ));
      //   }
      // }
      //
      // final List<List<WooProduct>> _res = await Future.wait(_iterable);
      //
      // // List which contains all the products fetched
      // final List<WooProduct> _result = [];
      //
      // for (final list in _res) {
      //   if (list.isNotEmpty) {
      //     _result.addAll(list);
      //   }
      // }

      Dev.debugFunction(
        functionName: 'getProductsByMultipleCategories',
        className: 'TestWooService',
        start: false,
        fileName: 'Woocommerce.service',
      );

      return _result;
    } catch (e) {
      rethrow;
    }
  }
}
