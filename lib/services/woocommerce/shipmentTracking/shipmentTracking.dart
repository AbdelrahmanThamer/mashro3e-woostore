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

import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'constants.dart';
import 'models/models.dart';

export 'models/models.dart';

/// Handles the shipment tracking of the object
class ShipmentTracking {
  static ShipmentTracking instance;

  final String baseUrl;
  final String consumerKey;
  final String consumerSecret;
  bool isHttps = false;

  factory ShipmentTracking({
    String baseUrl,
    String consumerKey,
    String consumerSecret,
  }) {
    if (instance != null) {
      return instance;
    } else {
      instance = ShipmentTracking._(
        baseUrl: baseUrl,
        consumerKey: consumerKey,
        consumerSecret: consumerSecret,
      );
      return instance;
    }
  }

  ShipmentTracking._({
    @required this.baseUrl,
    @required this.consumerKey,
    @required this.consumerSecret,
  }) {
    if (baseUrl.startsWith('https')) {
      isHttps = true;
    } else {
      isHttps = false;
    }
  }

  Future<AdvancedShipmentTracking> getTrackingInfo(String orderId) async {
    final String url =
        _getOAuthURL('GET', '/orders/$orderId/shipment-trackings');
    final Response result = await Dio().get(url);
    if (result == null) {
      throw Exception('Null response from server');
    }

    if (result.data is List) {
      if ((result.data as List).isNotEmpty) {
        return AdvancedShipmentTracking.fromJson(result.data[0]);
      } else {
        return null;
      }
    } else if (result.data is Map) {
      return AdvancedShipmentTracking.fromJson(result.data);
    }

    return null;
  }

  //**********************************************************
  //  Helper
  //**********************************************************

  /// This Generates a valid OAuth 1.0 URL
  ///
  /// if [isHttps] is true we just return the URL with
  /// [consumerKey] and [consumerSecret] as query parameters
  String _getOAuthURL(String requestMethod, String endpoint) {
    final String consumerKey = this.consumerKey;
    final String consumerSecret = this.consumerSecret;

    const String token = '';
    final String url = baseUrl + ShipmentTrackingConstants.apiPath + endpoint;
    final bool containsQueryParams = url.contains('?');

    if (isHttps == true) {
      return url +
          (containsQueryParams == true
              ? '&consumer_key=' +
                  this.consumerKey +
                  '&consumer_secret=' +
                  this.consumerSecret
              : '?consumer_key=' +
                  this.consumerKey +
                  '&consumer_secret=' +
                  this.consumerSecret);
    }

    final Random rand = Random();
    final List<int> codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    /// Random string uniquely generated to identify each signed request
    final String nonce = String.fromCharCodes(codeUnits);

    /// The timestamp allows the Service Provider to only keep nonce values for a limited time
    final int timestamp =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toInt();

    String parameters = 'oauth_consumer_key=' +
        consumerKey +
        '&oauth_nonce=' +
        nonce +
        '&oauth_signature_method=HMAC-SHA1&oauth_timestamp=' +
        timestamp.toString() +
        '&oauth_token=' +
        token +
        '&oauth_version=1.0&';

    if (containsQueryParams == true) {
      parameters = parameters + url.split('?')[1];
    } else {
      parameters = parameters.substring(0, parameters.length - 1);
    }

    final Map<dynamic, dynamic> params = _QueryString.parse(parameters);
    final Map<dynamic, dynamic> treeMap = SplayTreeMap<dynamic, dynamic>();
    treeMap.addAll(params);

    String parameterString = '';

    for (final key in treeMap.keys) {
      parameterString = parameterString +
          Uri.encodeQueryComponent(key) +
          '=' +
          treeMap[key] +
          '&';
    }

    parameterString = parameterString.substring(0, parameterString.length - 1);
    parameterString = parameterString.replaceAll(' ', '%20');

    final String method = requestMethod.toUpperCase();
    final String baseString = method +
        '&' +
        Uri.encodeQueryComponent(
            containsQueryParams == true ? url.split('?')[0] : url) +
        '&' +
        Uri.encodeQueryComponent(parameterString);

    final String signingKey = consumerSecret + '&' + token;
    final crypto.Hmac hmacSha1 =
        crypto.Hmac(crypto.sha1, utf8.encode(signingKey)); // HMAC-SHA1

    /// The Signature is used by the server to verify the
    /// authenticity of the request and prevent unauthorized access.
    /// Here we use HMAC-SHA1 method.
    final crypto.Digest signature = hmacSha1.convert(utf8.encode(baseString));

    final String finalSignature = base64Encode(signature.bytes);

    String requestUrl = '';

    if (containsQueryParams == true) {
      requestUrl = url.split('?')[0] +
          '?' +
          parameterString +
          '&oauth_signature=' +
          Uri.encodeQueryComponent(finalSignature);
    } else {
      requestUrl = url +
          '?' +
          parameterString +
          '&oauth_signature=' +
          Uri.encodeQueryComponent(finalSignature);
    }

    return requestUrl;
  }
}

class _QueryString {
  /// Parses the given query string into a Map.
  static Map parse(String query) {
    final RegExp search = RegExp('([^&=]+)=?([^&]*)');
    final Map result = {};

    // Get rid off the beginning ? in query strings.
    if (query.startsWith('?')) {
      query = query.substring(1);
    }

    // A custom decoder.
    String decode(String s) => Uri.decodeComponent(s.replaceAll('+', ' '));

    // Go through all the matches and build the result map.
    for (final Match match in search.allMatches(query)) {
      result[decode(match.group(1))] = decode(match.group(2));
    }

    return result;
  }
}
