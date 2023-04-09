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

import 'dart:convert';
import 'dart:io';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:quiver/strings.dart';

import '../../../utils/api_utils.dart';
import 'constants.dart';
import 'exceptions.dart';
import 'models.dart';

export 'database/cart_db.dart';
export 'exceptions.dart';
export 'models.dart';

class WooStoreProCart {
  // Single instance variable
  static WooStoreProCart? _instance;

  /// Users Json Web Token to validate the authority of
  /// the request.
  static String? jwt;

  /// Dio instance which is used for the HTTP Requests
  static late Dio dio;

  static late String baseUrl;

  // Factory to return a single instance every time
  factory WooStoreProCart(String websiteUrl) {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = WooStoreProCart._(websiteUrl);
      return _instance!;
    }
  }

  // Private constructor
  WooStoreProCart._(String url) {
    baseUrl = url;
    // Create a dio instance
    dio = Dio(BaseOptions(
      baseUrl:
          '$url${WooStoreProCartConstants.defaultApiPath}${WooStoreProCartConstants.version}${WooStoreProCartConstants.cartApi}',
      connectTimeout: 10000,
    ));
  }

  /// Sets the [jwt] for the user to attach in requests
  void setAuthToken(String? value) {
    if (isNotBlank(value)) {
      jwt = value;
      dio.options.queryParameters = {
        'jwt': jwt,
      };
    }
  }

  void removeAuthToken() {
    jwt = null;
    dio.options.queryParameters = {};
  }

  Future<void> reset() async {
    removeAuthToken();
    dio.options.headers = {};
  }

  static void _setHeaders(List<String>? cookies) {
    // dio.options.headers['Cookie'] = cookies;
    // final cm = WebviewCookieManager();
    // final List<Cookie> list = [];
    // for (final cookie in cookies) {
    //   list.add(Cookie.fromSetCookieValue(cookie));
    // }
    // cm.setCookies(list, origin: baseUrl);
  }

  Future<WooStoreProCartData> getCart() async {
    if (isBlank(jwt)) {
      throw const WooStoreProCartException(
        code: 'no_user_found',
        message: 'Could not find a user. Please login!',
      );
    }

    try {
      final result = await dio.get(WooStoreProCartEndpoints.getCart);

      if (result.statusCode == 200) {
        _setHeaders(result.headers.map['set-cookie']);
        if (result.data == null || result.data is! Map) {
          throw const InvalidCartResponseException();
        }
        return WooStoreProCartData.fromMap(result.data);
      } else {
        throw WooStoreProCartException.fromMap(result.data);
      }
    } on DioError catch (e) {
      throw WooStoreProCartException.fromMap(ApiUtils.handleDioError(e));
    }
  }

  /// Add item to cart and also updates the quantity of the item
  /// if the item is already in the cart
  Future<WooStoreProCartItemActionResponseData> addItem(
    RawWooStoreProCartItemData lineItem,
  ) async {
    if (lineItem.productId == 0) {
      throw const InvalidProductIdException();
    }

    if (lineItem.quantity == 0) {
      throw const InvalidQuantityException();
    }

    try {
      final result = await dio.post(
        WooStoreProCartEndpoints.addToCart,
        data: jsonEncode(lineItem.toMap()),
      );

      if (result.statusCode == 200) {
        _setHeaders(result.headers.map['set-cookie']);
        Dev.info(result.data);
        return WooStoreProCartItemActionResponseData.fromMap(result.data);
      } else {
        throw WooStoreProCartException.fromMap(result.data);
      }
    } on DioError catch (e) {
      throw WooStoreProCartException.fromMap(ApiUtils.handleDioError(e));
    }
  }

  /// Update item to cart and also updates the quantity of the item
  /// if the item is already in the cart
  Future<WooStoreProCartItemActionResponseData> updateItem(
    RawWooStoreProCartItemData lineItem,
  ) async {
    if (lineItem.productId == 0) {
      throw const InvalidProductIdException();
    }

    if (lineItem.quantity == 0) {
      throw const InvalidQuantityException();
    }

    try {
      final result = await dio.post(
        WooStoreProCartEndpoints.updateItemInCart,
        data: jsonEncode(lineItem.toMap()),
      );

      if (result.statusCode == 200) {
        _setHeaders(result.headers.map['set-cookie']);
        return WooStoreProCartItemActionResponseData.fromMap(result.data);
      } else {
        throw WooStoreProCartException.fromMap(result.data);
      }
    } on DioError catch (e) {
      throw WooStoreProCartException.fromMap(ApiUtils.handleDioError(e));
    }
  }

  /// Update the whole cart with the list of items
  Future<WooStoreProCartData> updateCart(
    List<RawWooStoreProCartItemData> items,
  ) async {
    try {
      final result = await dio.post(
        WooStoreProCartEndpoints.updateCart,
        data: jsonEncode({
          'line_items': items.map((e) => e.toMap()).toList(),
        }),
      );

      if (result.statusCode == 200) {
        _setHeaders(result.headers.map['set-cookie']);
        if (result.data == null || result.data is! Map) {
          throw const InvalidCartResponseException();
        }
        return WooStoreProCartData.fromMap(result.data);
      } else {
        throw WooStoreProCartException.fromMap(result.data);
      }
    } on DioError catch (e) {
      throw WooStoreProCartException.fromMap(ApiUtils.handleDioError(e));
    }
  }

  /// Update the whole cart with the list of items
  Future<WooStoreProCartData> removeItems(
    List<String> cartItemKeys,
  ) async {
    try {
      final result = await dio.post(
        WooStoreProCartEndpoints.removeItems,
        data: jsonEncode({
          'cart_item_keys': cartItemKeys,
        }),
      );

      if (result.statusCode == 200) {
        _setHeaders(result.headers.map['set-cookie']);
        if (result.data == null || result.data is! Map) {
          throw const InvalidCartResponseException();
        }
        return WooStoreProCartData.fromMap(result.data);
      } else {
        throw WooStoreProCartException.fromMap(result.data);
      }
    } on DioError catch (e) {
      throw WooStoreProCartException.fromMap(ApiUtils.handleDioError(e));
    }
  }

  /// Update the whole cart with the list of items
  Future<WooStoreProCartData> clearCart() async {
    try {
      final result = await dio.get(WooStoreProCartEndpoints.clearCart);

      if (result.statusCode == 200) {
        _setHeaders(result.headers.map['set-cookie']);
        if (result.data == null || result.data is! Map) {
          throw const InvalidCartResponseException();
        }
        return const WooStoreProCartData();
      } else {
        throw WooStoreProCartException.fromMap(result.data);
      }
    } on DioError catch (e) {
      throw WooStoreProCartException.fromMap(ApiUtils.handleDioError(e));
    }
  }

  //**********************************************************
  // Guest cart related api
  //**********************************************************

  Future<WooStoreProCartData> handleGuestCartData(
    WooStoreProGuestCartPayload payload,
  ) async {
    try {
      final result = await dio.post(
        WooStoreProCartEndpoints.guestCart,
        data: payload.toMap(),
      );

      if (result.statusCode == 200) {
        _setHeaders(result.headers.map['set-cookie']);
        if (result.data == null || result.data is! Map) {
          throw const InvalidCartResponseException();
        }

        // Dev.info(result.data);
        return WooStoreProCartData.fromMap(result.data);
      } else {
        throw WooStoreProCartException.fromMap(result.data);
      }
    } on DioError catch (e) {
      throw WooStoreProCartException.fromMap(ApiUtils.handleDioError(e));
    }
  }

  Future<WooStoreProCartData> mergeCart({
    required WooStoreProGuestCartPayload payload,
    required String jwt,
  }) async {
    try {
      final result = await dio.post(
        WooStoreProCartEndpoints.mergeCart,
        data: {
          ...payload.toMap(),
          'jwt': jwt,
        },
      );

      if (result.statusCode == 200) {
        _setHeaders(result.headers.map['set-cookie']);
        if (result.data == null || result.data is! Map) {
          throw const InvalidCartResponseException();
        }
        return WooStoreProCartData.fromMap(result.data);
      } else {
        throw WooStoreProCartException.fromMap(result.data);
      }
    } on DioError catch (e) {
      throw WooStoreProCartException.fromMap(ApiUtils.handleDioError(e));
    }
  }

  Future<Response> uploadProductAddonFile({
    required File file,
    required void Function(int, int) onSendProgress,
  }) async {
    try {
      final FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: basename(file.path),
        ),
      });

      final response = await dio.post(
        WooStoreProCartEndpoints.uploadFile,
        data: formData,
        onSendProgress: onSendProgress,
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw WooStoreProCartException.fromMap(response.data);
      }
    } on DioError catch (e) {
      throw WooStoreProCartException.fromMap(ApiUtils.handleDioError(e));
    }
  }
}
