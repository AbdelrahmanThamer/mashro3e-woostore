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

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../developer/dev.log.dart';
import '../woocommerce.service.dart';
import 'constants.dart';
import 'models/totals.model.dart';
import 'utils/utils.dart';

export 'exceptions/exceptions.dart';
export 'models/models.dart';

/// Cart Rest Api for woocommerce.
///
/// [cookie] property can be used in a WebView to load the
/// cart items from the session of the cookie.
///
/// Creates and stores a [key] if one is not provided at instantiation.
/// This cartKey will be responsible for the subsequent changes made to the
/// cart for synchronisation with the server and website.
class CoCart {
  /// Single instance variable
  static CoCart _instance;

  /// Getter for the CoCart singleton instance
  CoCart get instance => _instance;

  /// The Url for the website
  static String baseUrl;

  /// The Base Api Path for the CoCart plugin for woocommerce
  static String baseApiPath;

  /// The version of the CoCart Rest Api
  static String version;

  /// This is the cart key which will be used for any transaction that
  /// occurs through this API.
  static String key;

  /// Holds the information about the session of the cart on the
  /// server for WebView or similar.
  static Cookie cookie;

  /// Dio instance which is used for the HTTP Requests
  static Dio dio;

  /// Keeps a reference for the cart items which can be required to
  /// remove the cart items using unique key for the item
  final Map<int, CoCartProductItem> cartItems = {};

  // Factory to return a single instance every time
  factory CoCart({
    @required String baseUrl,
    // If you want to assign a cart key at instantiation
    String cartKey,
    String apiPath = CoCartConstants.defaultApiPath,
    String version = 'v1',
  }) {
    if (_instance != null) {
      return _instance;
    } else {
      _instance = CoCart._(
        baseUrl: baseUrl,
        cartKey: cartKey,
        apiPath: apiPath,
        version: version,
      );
      return _instance;
    }
  }

  CoCart._({
    @required String baseUrl,
    String cartKey,
    String apiPath = CoCartConstants.defaultApiPath,
    String version = 'v1',
  }) {
    _init();

    setBaseUrl(baseUrl);

    // Always call these later to override to new values
    baseApiPath = '$baseUrl$apiPath/$version';
    key = cartKey;

    // Create a dio instance
    dio = Dio(BaseOptions(
      baseUrl: baseApiPath,
      connectTimeout: 10000,
    ));
  }

  //**********************************************************
  //  Private Functions
  //**********************************************************

  /// Checks the local database for the saved values of cookie and cart key
  /// and load them into memory for later use if present
  Future<void> _init() async {
    // Function Log
    Dev.debugFunction(
      functionName: '_init',
      className: 'CoCart',
      fileName: 'coCart.dart',
      start: true,
    );

    key = await CoCartUtils.getCartKeyFromDB();
    cookie = await CoCartUtils.getCartCookieFromDB();

    Dev.debug('Setting key: $key');
    Dev.debug('Setting cookie: $cookie');

    // Function Log
    Dev.debugFunction(
      functionName: '_init',
      className: 'CoCart',
      fileName: 'coCart.dart',
      start: false,
    );
  }

  void setBaseUrl(String value) {
    baseUrl = value;
  }

  //**********************************************************
  //  Public Functions
  //**********************************************************

  /// Set the Authorization Headers for the network requests for
  /// logged in customers explicitly
  void setAuthHeader({@required String jwtToken}) {
    if (jwtToken != null && jwtToken.isNotEmpty) {
      Dev.debug('xxxxxxxxxxxxxx Setting auth header xxxxxxxxxxxxxx');
      dio.options.headers.addAll({'Authorization': 'Bearer $jwtToken'});
      Dev.debug(dio.options.headers);
    }
  }

  /// Remove the Authorization Header from the network request.
  void removeAuthHeader() {
    Dev.debug('xxxxxxxxxxxxxx Removing auth header xxxxxxxxxxxxxx');
    dio.options.headers = {};
  }

  /// Completely removes the user specific items in the cart like
  /// cartKey, cartCookie, etc. for a new start.
  ///
  /// Usually called when the user logs out.
  Future<void> reset() async {
    removeAuthHeader();
    key = null;
    cookie = null;
    await CoCartUtils.removeCartKeyFromDB();
    await CoCartUtils.removeCartCookieFromDB();
  }

  /// Set the cart key for the session if not already present.
  /// Saves the key to device local storage for future use.
  ///
  /// [headers] parameter will be used over [value] parameter when both are
  /// provided at once.
  ///
  /// Will throw exception when both the parameters are null and there
  /// is no [key] already present in the session.
  static Future<void> setCartKey({
    String value,
    Map<String, List<String>> headers,
  }) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'setCartKey',
      className: 'CoCart',
      fileName: 'coCart.dart',
      start: true,
    );

    if (value == null && headers == null) {
      if (key != null) {
        Dev.debug(
            'Provided cartKey and headers are null but [key] variable is not null');
        return;
      }
      throw const CoCartNullArgumentsException(
          'setCartKey value and headers cannot be both null');
    }

    // If headers is not null perform this action
    if (headers != null) {
      Dev.debug('Headers are not null, setting cart key from headers');
      if (headers[CoCartConstants.coCartKeyHeaderResponse] != null &&
          headers[CoCartConstants.coCartKeyHeaderResponse].first != null &&
          headers[CoCartConstants.coCartKeyHeaderResponse].first.isNotEmpty) {
        // If new and old key are same, then return
        if (key == headers[CoCartConstants.coCartKeyHeaderResponse].first) {
          Dev.debug('Both keys are same, returning');
          return;
        }

        // Set the value
        key = headers[CoCartConstants.coCartKeyHeaderResponse].first;

        // Save the cart key to local storage
        await CoCartUtils.saveCartKeyToDB(
          headers[CoCartConstants.coCartKeyHeaderResponse].first,
        );

        // Function Log
        Dev.debugFunction(
          functionName: 'setCartKey',
          className: 'CoCart',
          fileName: 'coCart.dart',
          start: false,
        );

        return;
      }
    }

    // If headers is null and value is not null perform this action
    if (value != null && value.isNotEmpty) {
      Dev.debug('Setting cart key from provided value');
      // If new and old key are same, then return
      if (key == value) {
        Dev.debug('Both keys are same (value: $key), returning');
        return;
      }

      // Set the value
      key = value;

      // Save the cart key to local storage
      await CoCartUtils.saveCartKeyToDB(value);
    }

    // Function Log
    Dev.debugFunction(
      functionName: 'setCartKey',
      className: 'CoCart',
      fileName: 'coCart.dart',
      start: false,
    );
  }

  /// Set the cart cookie and save it in the local database if not
  /// already present.
  ///
  /// [headers] parameter will be used over [value] parameter when both are
  /// provided at once.
  ///
  /// Will throw exception when both the parameters are null and there
  /// is no [cookie] already present in the session.
  static Future<void> setCartCookie({
    Cookie value,
    Map<String, List<String>> headers,
  }) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'setCartCookie',
      className: 'CoCart',
      fileName: 'coCart.dart',
      start: true,
    );

    if (value == null && headers == null) {
      if (cookie != null) {
        Dev.debug(
            'Provided cookie value and headers are null but [cookie] variable is not null');
        return;
      }
      throw const CoCartNullArgumentsException(
          'setCartCookie value and headers cannot be both null');
    }

    if (headers != null) {
      Dev.debug('Setting cookie value from headers');
      if (headers['set-cookie'] != null) {
        Dev.debug('set-cookie header list value is not null, processing...');
        final String result = headers['set-cookie'].firstWhere(
          (element) => element.startsWith(CoCartConstants.cookieNamePattern),
          orElse: () => null,
        );

        if (result == null) {
          Dev.debug('Headers\' set-cookie for coCart is null, returning');
          return;
        }

        final Cookie c = Cookie.fromSetCookieValue(result);

        // If new cookie and old cookie value are same, then return
        if (cookie != null) {
          if (c.value == cookie.value) {
            Dev.debug('Both new and old cookie values are equal, returning');
            Dev.debug(cookie);
            return;
          }
        }

        // Set the cart cookie to the created result
        cookie = c;
        cookie.domain = _createCookieDomain(baseUrl);

        // Save the cookie to db
        await CoCartUtils.saveCartCookieToDB(c);

        Dev.debug('Saved cookie to DB from headers');
        Dev.debug(cookie);

        // Function Log
        Dev.debugFunction(
          functionName: 'setCartCookie',
          className: 'CoCart',
          fileName: 'coCart.dart',
          start: false,
        );

        return;
      }
    }

    if (value != null) {
      Dev.debug('Setting cookie from provided value');
      if (cookie == value) {
        Dev.debug('Both cookie values are same, returning');
        Dev.debug(cookie);
        return;
      }
      // Set the cart cookie to the created result
      cookie = value;
      cookie.domain = _createCookieDomain(baseUrl);

      // Save the cookie to db
      await CoCartUtils.saveCartCookieToDB(value);

      Dev.debug('Saved cookie to DB from value');
      Dev.debug(cookie);

      // Function Log
      Dev.debugFunction(
        functionName: 'setCartCookie',
        className: 'CoCart',
        fileName: 'coCart.dart',
        start: false,
      );
    }
  }

  /// Get the cart key if not accessible from the variable
  Future<String> getCartKey() async {
    if (key != null && key.isNotEmpty) {
      return Future.value(key);
    }

    final result = await CoCartUtils.getCartKeyFromDB();
    if (result != null && result.isNotEmpty) {
      key = result;
    }
    return result;
  }

  /// Get the cart cookie if not accessible from the variable
  Future<Cookie> getCartCookie() async {
    if (cookie != null && cookie.value != null && cookie.value.isNotEmpty) {
      return Future.value(cookie);
    }
    final result = await CoCartUtils.getCartCookieFromDB();
    if (result != null) {
      cookie = result;
    }
    return result;
  }

  /// Add Item to the cart and return the Added item response
  Future<CoCartProductItem> addItem({
    @required id,
    @required quantity,
    String cartKey,
  }) async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'addItem',
        className: 'CoCart',
        fileName: 'coCart.dart',
        start: true,
      );

      // The cart key on which the action is to be performed
      final String activeCartKey = _getActiveCartKey(cartKey);

      // Data for the API
      final Map<String, dynamic> data = {
        'product_id': id,
        'quantity': quantity,
      };

      Dev.debug(data.toString());

      // Parameters for the query --> Mainly the [cartKey]
      final Map<String, dynamic> queryParameters = {};

      if (activeCartKey != null) {
        Dev.debug('Using cart key: $activeCartKey');
        queryParameters.addAll({'cart_key': activeCartKey});
      }

      // Actual request
      final Response result = await dio.post(
        '/add-item',
        data: json.encode(data),
        queryParameters: queryParameters,
      );

      // If response is null
      if (result == null) {
        throw const CoCartNullResponseException(
            'CoCart Add Item Api returned null response');
      }

      // Set the cart key and save it int the database
      setCartKey(headers: result.headers.map);

      // Set the cookie and save it in the database
      setCartCookie(headers: result.headers.map);

      // Return the response
      final CoCartProductItem cpi = CoCartProductItem.fromMap(result.data);

      print(cpi);

      // Add to cart Items list
      cartItems.addAll({cpi.id: cpi});

      // Function Log
      Dev.debugFunction(
        functionName: 'addItem',
        className: 'CoCart',
        fileName: 'coCart.dart',
        start: false,
      );

      return cpi;
    } on DioError catch (e) {
      throw CoCartException.fromDioError(e);
    } catch (_) {
      rethrow;
    }
  }

  /// Update an existing item in the cart.
  Future<bool> updateItem({
    @required int id,
    @required int quantity,
    String cartKey,
  }) async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'updateItem',
        className: 'CoCart',
        fileName: 'coCart.dart',
        start: true,
      );

      // The cart key on which the action is to be performed
      final String activeCartKey = _getActiveCartKey(cartKey);

      final CoCartProductItem cpi = cartItems[id];

      // Data for the API
      final Map<String, dynamic> data = {
        'cart_item_key': cpi.key,
        'quantity': quantity,
      };

      Dev.debug(data.toString());

      // Parameters for the query --> Mainly the [cartKey]
      final Map<String, dynamic> queryParameters = {};

      if (activeCartKey != null) {
        Dev.debug('Using cart key: $activeCartKey');
        queryParameters.addAll({'cart_key': activeCartKey});
      }

      // Actual request
      final Response result = await dio.post(
        '/item',
        data: json.encode(data),
        queryParameters: queryParameters,
      );

      // If response is null
      if (result == null) {
        throw const CoCartNullResponseException(
            'CoCart Add Item Api returned null response');
      }

      // Set the cart key and save it int the database
      setCartKey(headers: result.headers.map);

      // Set the cookie and save it in the database
      setCartCookie(headers: result.headers.map);

      // Increase the quantity of the product
      cpi.quantity = result.data['quantity'];

      // Add to cart Items list
      cartItems.addAll({cpi.id: cpi});

      // Function Log
      Dev.debugFunction(
        functionName: 'updateItem',
        className: 'CoCart',
        fileName: 'coCart.dart',
        start: false,
      );

      return true;
    } on DioError catch (e) {
      throw CoCartException.fromDioError(e);
    } catch (_) {
      rethrow;
    }
  }

  /// Remove the item specified from the [cartItemKey] from the cart
  /// in session.
  Future<bool> removeItem({
    @required int productId,
    String cartKey,
    bool returnCart = false,
  }) async {
    try {
      if (productId == null) {
        throw const CoCartNullArgumentsException(
            'Argument \'productId\' cannot be null');
      }

      final activeCartKey = _getActiveCartKey(cartKey);

      final Map<String, dynamic> queryParameters = {};

      if (activeCartKey != null) {
        queryParameters.addAll({'cart_key': activeCartKey});
      }

      // Data for the request
      final data = {
        'cart_item_key': cartItems[productId].key,
        'return_cart': returnCart,
      };

      final result = await dio.delete(
        '/item',
        data: json.encode(data),
        queryParameters: queryParameters,
      );

      if (result == null) {
        throw const CoCartNullResponseException(
            'CoCart remove item api returned null response');
      }
      // Set the cart key and save it int the database
      setCartKey(headers: result.headers.map);

      // Set the cookie and save it in the database
      setCartCookie(headers: result.headers.map);

      // Remove the product from the items list
      cartItems.remove(productId);

      return true;
    } on DioError catch (e) {
      throw CoCartException.fromDioError(e);
    } catch (_) {
      rethrow;
    }
  }

  /// Get the contents of the cart from the [cartKey] if specified
  /// else will get the information from the key stored in the application
  Future<CoCartEnhanced> getCart({String cartKey}) async {
    if (cartKey == null && key == null) {
      throw const CoCartNullArgumentsException(
          'CoCart get cart api cannot be used on null cart key. Please provide a cart key or set a key on the CoCart instance');
    }

    try {
      // Get the active cart key
      final activeCartKey = _getActiveCartKey(cartKey);

      // Parameters
      final Map<String, dynamic> queryParameters = {'cart_key': activeCartKey};

      // Actual Request
      final Response result = await dio.get(
        '/get-cart',
        queryParameters: queryParameters,
      );

      if (result == null) {
        throw const CoCartNullResponseException(
            'CoCart get-cart api returned null response');
      } else {
        // Set the cart key and save it int the database
        setCartKey(headers: result.headers.map);

        // Set the cookie and save it in the database
        setCartCookie(headers: result.headers.map);

        final CoCartEnhanced c = CoCartEnhanced.fromMap(result.data);

        if (c.items.isNotEmpty) {
          for (final obj in c.items) {
            cartItems.addAll({obj.id: obj});
          }
        }

        return c;
      }
    } on DioError catch (e) {
      throw CoCartException.fromDioError(e);
    } catch (_) {
      rethrow;
    }
  }

  /// Clears the cart from the backend
  Future<bool> clearCart({String cartKey}) async {
    if (cartKey == null && key == null) {
      throw const CoCartNullArgumentsException(
          'CoCart clear cart api cannot be used on null cart key. Please provide a cart key or set a key on the CoCart instance');
    }

    try {
      // Get the active cart key
      final activeCartKey = _getActiveCartKey(cartKey);

      // Parameters
      final Map<String, dynamic> queryParameters = {'cart_key': activeCartKey};

      // Actual Request
      final Response result = await dio.post(
        '/clear',
        queryParameters: queryParameters,
      );

      if (result == null) {
        throw const CoCartNullResponseException(
            'CoCart clear-cart api returned null response');
      } else {
        // Set the cart key and save it int the database
        setCartKey(headers: result.headers.map);

        // Set the cookie and save it in the database
        setCartCookie(headers: result.headers.map);

        return true;
      }
    } on DioError catch (e) {
      throw CoCartException.fromDioError(e);
    } catch (_) {
      rethrow;
    }
  }

  /// Get the totals of the cart in the application.
  Future<CoCartTotals> getCartTotals({String cartKey}) async {
    try {
      final activeCartKey = _getActiveCartKey(cartKey);
      if (activeCartKey == null) {
        throw const CoCartNullArgumentsException(
            'CoCart totals cannot be fetched. CartKey is empty. Please provide a valid cartKey');
      }

      final Map<String, dynamic> queryParameters = {'cart_key': activeCartKey};

      final Response result = await dio.get(
        '/totals',
        queryParameters: queryParameters,
      );

      if (result == null) {
        throw const CoCartNullResponseException(
            'CoCart totals returned null response');
      }

      final CoCartTotals totals = CoCartTotals.fromMap(result.data);

      // Set the cart key and save it int the database
      setCartKey(headers: result.headers.map);

      // Set the cookie and save it in the database
      setCartCookie(headers: result.headers.map);

      return totals;
    } on DioError catch (e) {
      throw CoCartException.fromDioError(e);
    } catch (_) {
      rethrow;
    }
  }

  /// Add item to the local cart instance
  ///
  /// Usually this will be run when the local cart is not in sync
  /// with the cart on the server.
  void addToLocalCart(List<CoCartProductItem> items) {
    if (items != null && items.isNotEmpty) {
      for (final value in items) {
        if (cartItems.containsKey(value.id)) {
          return;
        } else {
          cartItems.addAll({value.id: value});
        }
      }
    }
  }

  //**********************************************************
  //  Private Helpers
  //**********************************************************

  /// Returns the actual value on which the cart action is to be
  /// performed.
  static String _getActiveCartKey(String cartKey) {
    String finalCartKey = key;
    // Check if the [cartKey] parameter is provided
    if (cartKey != null && cartKey.isNotEmpty) {
      finalCartKey = cartKey;
    }

    return finalCartKey;
  }

  /// Creates a string from a url of the domain name
  /// removing the HTTP or HTTPS methods from the url
  static String _createCookieDomain(String url) {
    try {
      final tempArr = url.split('://');
      return tempArr.last;
    } catch (e) {
      return url;
    }
  }
}

// {
// "id": "paypal",
// "title": "PayPal",
// "description": "Pay via PayPal; you can pay with your credit card if you don't have a PayPal account. SANDBOX ENABLED. You can use sandbox testing accounts only. See the <a href=\"https://developer.paypal.com/docs/classic/lifecycle/ug_sandbox/\">PayPal Sandbox Testing Guide</a> for more details.",
// "order": 3,
// "enabled": true,
// "method_title": "PayPal Standard",
// "method_description": "PayPal Standard redirects customers to PayPal to enter their payment information.",
// "method_supports": [
// "products",
// "refunds"
// ],
// "settings": {
// "title": {
// "id": "title",
// "label": "Title",
// "description": "This controls the title which the user sees during checkout.",
// "type": "text",
// "value": "PayPal",
// "default": "PayPal",
// "tip": "This controls the title which the user sees during checkout.",
// "placeholder": ""
// },
// "email": {
// "id": "email",
// "label": "PayPal email",
// "description": "Please enter your PayPal email address; this is needed in order to take payment.",
// "type": "email",
// "value": "business@ecommercestore.com",
// "default": "malik.aniket3000@gmail.com",
// "tip": "Please enter your PayPal email address; this is needed in order to take payment.",
// "placeholder": "you@youremail.com"
// },
// "advanced": {
// "id": "advanced",
// "label": "Advanced options",
// "description": "",
// "type": "title",
// "value": "",
// "default": "",
// "tip": "",
// "placeholder": ""
// },
// "testmode": {
// "id": "testmode",
// "label": "Enable PayPal sandbox",
// "description": "PayPal sandbox can be used to test payments. Sign up for a <a href=\"https://developer.paypal.com/\">developer account</a>.",
// "type": "checkbox",
// "value": "yes",
// "default": "no",
// "tip": "PayPal sandbox can be used to test payments. Sign up for a <a href=\"https://developer.paypal.com/\">developer account</a>.",
// "placeholder": ""
// },
// "debug": {
// "id": "debug",
// "label": "Enable logging",
// "description": "Log PayPal events, such as IPN requests, inside <code>/Users/aniketmalik/Local Sites/testecommercestore/app/public/wp-content/uploads/wc-logs/paypal-2021-09-12-82a2765c48493cf39c45b32a0fc8a999.log</code> Note: this may log personal information. We recommend using this for debugging purposes only and deleting the logs when finished.",
// "type": "checkbox",
// "value": "no",
// "default": "no",
// "tip": "Log PayPal events, such as IPN requests, inside <code>/Users/aniketmalik/Local Sites/testecommercestore/app/public/wp-content/uploads/wc-logs/paypal-2021-09-12-82a2765c48493cf39c45b32a0fc8a999.log</code> Note: this may log personal information. We recommend using this for debugging purposes only and deleting the logs when finished.",
// "placeholder": ""
// },
// "ipn_notification": {
// "id": "ipn_notification",
// "label": "Enable IPN email notifications",
// "description": "Send notifications when an IPN is received from PayPal indicating refunds, chargebacks and cancellations.",
// "type": "checkbox",
// "value": "yes",
// "default": "yes",
// "tip": "Send notifications when an IPN is received from PayPal indicating refunds, chargebacks and cancellations.",
// "placeholder": ""
// },
// "receiver_email": {
// "id": "receiver_email",
// "label": "Receiver email",
// "description": "If your main PayPal email differs from the PayPal email entered above, input your main receiver email for your PayPal account here. This is used to validate IPN requests.",
// "type": "email",
// "value": "business@ecommercestore.com",
// "default": "",
// "tip": "If your main PayPal email differs from the PayPal email entered above, input your main receiver email for your PayPal account here. This is used to validate IPN requests.",
// "placeholder": "you@youremail.com"
// },
// "identity_token": {
// "id": "identity_token",
// "label": "PayPal identity token",
// "description": "Optionally enable \"Payment Data Transfer\" (Profile > Profile and Settings > My Selling Tools > Website Preferences) and then copy your identity token here. This will allow payments to be verified without the need for PayPal IPN.",
// "type": "text",
// "value": "",
// "default": "",
// "tip": "Optionally enable \"Payment Data Transfer\" (Profile > Profile and Settings > My Selling Tools > Website Preferences) and then copy your identity token here. This will allow payments to be verified without the need for PayPal IPN.",
// "placeholder": ""
// },
// "invoice_prefix": {
// "id": "invoice_prefix",
// "label": "Invoice prefix",
// "description": "Please enter a prefix for your invoice numbers. If you use your PayPal account for multiple stores ensure this prefix is unique as PayPal will not allow orders with the same invoice number.",
// "type": "text",
// "value": "WC-ES",
// "default": "WC-",
// "tip": "Please enter a prefix for your invoice numbers. If you use your PayPal account for multiple stores ensure this prefix is unique as PayPal will not allow orders with the same invoice number.",
// "placeholder": ""
// },
// "send_shipping": {
// "id": "send_shipping",
// "label": "Send shipping details to PayPal instead of billing.",
// "description": "PayPal allows us to send one address. If you are using PayPal for shipping labels you may prefer to send the shipping address rather than billing. Turning this option off may prevent PayPal Seller protection from applying.",
// "type": "checkbox",
// "value": "yes",
// "default": "yes",
// "tip": "PayPal allows us to send one address. If you are using PayPal for shipping labels you may prefer to send the shipping address rather than billing. Turning this option off may prevent PayPal Seller protection from applying.",
// "placeholder": ""
// },
// "address_override": {
// "id": "address_override",
// "label": "Enable \"address_override\" to prevent address information from being changed.",
// "description": "PayPal verifies addresses therefore this setting can cause errors (we recommend keeping it disabled).",
// "type": "checkbox",
// "value": "no",
// "default": "no",
// "tip": "PayPal verifies addresses therefore this setting can cause errors (we recommend keeping it disabled).",
// "placeholder": ""
// },
// "paymentaction": {
// "id": "paymentaction",
// "label": "Payment action",
// "description": "Choose whether you wish to capture funds immediately or authorize payment only.",
// "type": "select",
// "value": "sale",
// "default": "sale",
// "tip": "Choose whether you wish to capture funds immediately or authorize payment only.",
// "placeholder": "",
// "options": {
// "sale": "Capture",
// "authorization": "Authorize"
// }
// },
// "image_url": {
// "id": "image_url",
// "label": "Image url",
// "description": "Optionally enter the URL to a 150x50px image displayed as your logo in the upper left corner of the PayPal checkout pages.",
// "type": "text",
// "value": "",
// "default": "",
// "tip": "Optionally enter the URL to a 150x50px image displayed as your logo in the upper left corner of the PayPal checkout pages.",
// "placeholder": "Optional"
// },
// "api_details": {
// "id": "api_details",
// "label": "API credentials",
// "description": "Enter your PayPal API credentials to process refunds via PayPal. Learn how to access your <a href=\"https://developer.paypal.com/webapps/developer/docs/classic/api/apiCredentials/#create-an-api-signature\">PayPal API Credentials</a>.",
// "type": "title",
// "value": "",
// "default": "",
// "tip": "Enter your PayPal API credentials to process refunds via PayPal. Learn how to access your <a href=\"https://developer.paypal.com/webapps/developer/docs/classic/api/apiCredentials/#create-an-api-signature\">PayPal API Credentials</a>.",
// "placeholder": ""
// },
// "api_username": {
// "id": "api_username",
// "label": "Live API username",
// "description": "Get your API credentials from PayPal.",
// "type": "text",
// "value": "",
// "default": "",
// "tip": "Get your API credentials from PayPal.",
// "placeholder": "Optional"
// },
// "api_password": {
// "id": "api_password",
// "label": "Live API password",
// "description": "Get your API credentials from PayPal.",
// "type": "password",
// "value": "",
// "default": "",
// "tip": "Get your API credentials from PayPal.",
// "placeholder": "Optional"
// },
// "api_signature": {
// "id": "api_signature",
// "label": "Live API signature",
// "description": "Get your API credentials from PayPal.",
// "type": "password",
// "value": "",
// "default": "",
// "tip": "Get your API credentials from PayPal.",
// "placeholder": "Optional"
// },
// "sandbox_api_username": {
// "id": "sandbox_api_username",
// "label": "Sandbox API username",
// "description": "Get your API credentials from PayPal.",
// "type": "text",
// "value": "",
// "default": "",
// "tip": "Get your API credentials from PayPal.",
// "placeholder": "Optional"
// },
// "sandbox_api_password": {
// "id": "sandbox_api_password",
// "label": "Sandbox API password",
// "description": "Get your API credentials from PayPal.",
// "type": "password",
// "value": "Y742UCMPXJ4UBESN",
// "default": "",
// "tip": "Get your API credentials from PayPal.",
// "placeholder": "Optional"
// },
// "sandbox_api_signature": {
// "id": "sandbox_api_signature",
// "label": "Sandbox API signature",
// "description": "Get your API credentials from PayPal.",
// "type": "password",
// "value": "ApeJwnFj6ED5VMAjvlsEQG5DXUI8AshkfVL7VnYbWHAf60YS7FJBVNz8",
// "default": "",
// "tip": "Get your API credentials from PayPal.",
// "placeholder": "Optional"
// }
// },
// "_links": {
// "self": [
// {
// "href": "http://192.168.0.102:10009/wp-json/wc/v3/payment_gateways/paypal"
// }
// ],
// "collection": [
// {
// "href": "http://192.168.0.102:10009/wp-json/wc/v3/payment_gateways"
// }
// ]
// }
// },

// const data = {
//   payment_method: "paypal",
//   payment_method_title: "PayPal Standard",
//   billing: {
//     first_name: "John",
//     last_name: "Doe",
//     address_1: "969 Market",
//     address_2: "",
//     city: "San Francisco",
//     state: "CA",
//     postcode: "94103",
//     country: "US",
//     email: "john.doe@example.com",
//     phone: "(555) 555-5555"
//   },
//   shipping: {
//     first_name: "John",
//     last_name: "Doe",
//     address_1: "969 Market",
//     address_2: "",
//     city: "San Francisco",
//     state: "CA",
//     postcode: "94103",
//     country: "US"
//   },
//   line_items: [
//     {
//       product_id: 1782,
//       quantity: 3
//     }
//   ],
// };
