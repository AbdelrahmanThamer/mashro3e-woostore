// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

//**********************************************************
// This file saves the cart products in the local storage
// for later access.

// Used especially for guest users.
//**********************************************************

import 'dart:convert';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:quiver/strings.dart';

import '../../woocommerce.service.dart';

class WooStoreProCartDatabaseUtils {
  /// Opens the Hive box
  static const String cartBoxKey = 'cartBox';

  /// Save the JSON Encoded version of the cart data to database
  static const String cartDataKey = 'cartData';

  static Future<List<RawWooStoreProCartItemData>> read() async {
    try {
      final box = await Hive.openBox(cartBoxKey);
      // create a json string of the cart items
      final List<RawWooStoreProCartItemData> listOfCartItems = [];

      // get the data from database
      final String jsonString = box.get(cartDataKey);
      if (isNotBlank(jsonString)) {
        // decode the data
        final result = await compute(jsonDecode, jsonString);

        // convert the result set to raw cart items
        if (result is List && result.isNotEmpty) {
          for (final cartItemMap in result) {
            // cast the item to map
            try {
              listOfCartItems.add(
                RawWooStoreProCartItemData.fromMap(
                  Map.from(cartItemMap).cast<String, dynamic>(),
                ),
              );
            } catch (_) {}
          }
        }
      }

      return listOfCartItems;
    } catch (e, s) {
      Dev.error('read cart items from db error', error: e, stackTrace: s);
      return const [];
    }
  }

  static Future<bool> save(List<RawWooStoreProCartItemData> cartItems) async {
    try {
      if (cartItems.isEmpty) {
        return await deleteAll();
      }
      final box = await Hive.openBox(cartBoxKey);
      // create a json string of the cart items
      final List<Map<String, dynamic>> listOfMaps = [];
      for (final item in cartItems) {
        listOfMaps.add(item.toMap());
      }
      final String jsonString = await compute(
        jsonEncode,
        listOfMaps,
      );

      await box.put(cartDataKey, jsonString);
      return true;
    } catch (e, s) {
      Dev.error('Save cart items to db error', error: e, stackTrace: s);
      return false;
    }
  }

  static Future<bool> deleteAll() async {
    try {
      final box = await Hive.openBox(cartBoxKey);
      await box.clear();
      return true;
    } catch (e, s) {
      Dev.error('delete cart items from db error', error: e, stackTrace: s);
      return false;
    }
  }
}
