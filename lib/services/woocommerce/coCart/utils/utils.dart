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

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class CoCartUtils {
  /// Save the cart key to local database
  static Future<bool> saveCartKeyToDB(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setString(CoCartConstants.cartKey, key);
    } catch (_) {
      return false;
    }
  }

  /// Get the cart key from local database
  static Future<String> getCartKeyFromDB() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(CoCartConstants.cartKey);
    } catch (_) {
      return '';
    }
  }

  /// Delete the cart key from database
  static Future<bool> removeCartKeyFromDB() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.remove(CoCartConstants.cartKey);
    } catch (_) {
      return false;
    }
  }

  /// Save the cart cookie to local database
  static Future<bool> saveCartCookieToDB(Cookie cookie) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setString(CoCartConstants.cookie, cookie?.toString());
    } catch (_) {
      return false;
    }
  }

  /// Get the cart cookie from local database
  static Future<Cookie> getCartCookieFromDB() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return Cookie.fromSetCookieValue(prefs.getString(CoCartConstants.cookie));
    } catch (_) {
      return null;
    }
  }

  /// Delete the cart cookie from database
  static Future<bool> removeCartCookieFromDB() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.remove(CoCartConstants.cookie);
    } catch (_) {
      return false;
    }
  }
}
