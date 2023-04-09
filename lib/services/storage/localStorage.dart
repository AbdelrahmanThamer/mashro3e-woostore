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

import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'storageConstants.dart';

///
/// ## Description
///
/// Stores the information about `User`, `User settings` and likely
/// values used for the application in the future.
///
/// Use this class to store data for the application in the local
/// device. (Use only to store small amounts of data)
///
abstract class LocalStorage {
  static Future<bool> setString(String key, Object value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value.toString());
  }

  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<bool> setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<bool> removeInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  /// Reads the data stored in secure storage
  static Future<String?> secureRead(String key) async {
    const FlutterSecureStorage fss = FlutterSecureStorage();
    final result = await fss.read(key: key);
    return result;
  }

  /// Write the data in secure storage
  static Future<void> secureWrite(String key, String value) async {
    const FlutterSecureStorage fss = FlutterSecureStorage();
    await fss.write(key: key, value: value);
  }

  /// Remove the data in secure storage
  static Future<void> secureRemove(String key) async {
    const FlutterSecureStorage fss = FlutterSecureStorage();
    await fss.delete(key: key);
  }
}
