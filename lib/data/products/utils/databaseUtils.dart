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

import 'package:flutter/foundation.dart';
import 'package:quiver/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../developer/dev.log.dart';
import '../../../models/recent_product.dart';
import '../../../screens/favorites/models/favoriteProduct.model.dart';

class ProductsDatabaseUtils {
  static const String favoritesList = 'favoritesList';

  /// Updates the list of favorites list which holds
  /// reference to all the products
  static Future<void> updateFavoritesRefList(List<String>? updatedList) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'updateFavoritesList',
      className: 'ProductsDatabaseUtils',
      fileName: 'databaseUtils.dart',
      start: true,
    );
    try {
      if (updatedList != null && updatedList.isNotEmpty) {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setStringList(favoritesList, updatedList);
      }
      // Function Log
      Dev.debugFunction(
        functionName: 'updateFavoritesList',
        className: 'ProductsDatabaseUtils',
        fileName: 'databaseUtils.dart',
        start: false,
      );
    } catch (e, s) {
      Dev.error('Update favorites ref list in db', error: e, stackTrace: s);
    }
  }

  /// Add the product id to the favorites ref list without
  /// affecting the other values
  static Future<void> addToFavoritesRefList(String? productId) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'addToFavoritesRefList',
      className: 'ProductsDatabaseUtils',
      fileName: 'databaseUtils.dart',
      start: true,
    );
    try {
      if (productId == null) {
        return;
      }
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final oldList = pref.getStringList(favoritesList);
      final Set<String> tempSet = oldList?.toSet() ?? {};
      tempSet.add(productId);
      await pref.setStringList(favoritesList, tempSet.toList());

      // Function Log
      Dev.debugFunction(
        functionName: 'addToFavoritesRefList',
        className: 'ProductsDatabaseUtils',
        fileName: 'databaseUtils.dart',
        start: false,
      );
    } catch (e, s) {
      Dev.error(
        'add to favorites ref list in db',
        error: e,
        stackTrace: s,
      );
    }
  }

  /// Remove the single Product id from the favorites ref list
  /// without affecting the other values
  static Future<void> removeFromFavoritesRefList(String? productId) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'removeFromFavoritesRefList',
      className: 'ProductsDatabaseUtils',
      fileName: 'databaseUtils.dart',
      start: true,
    );
    try {
      if (productId == null) {
        return;
      }
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final oldList = pref.getStringList(favoritesList);
      if (oldList == null) {
        return;
      }
      oldList.removeWhere((element) => element == productId);
      await pref.setStringList(favoritesList, oldList);

      // Function Log
      Dev.debugFunction(
        functionName: 'removeFromFavoritesRefList',
        className: 'ProductsDatabaseUtils',
        fileName: 'databaseUtils.dart',
        start: false,
      );
    } catch (e, s) {
      Dev.error(
        'remove from favorites ref list in db',
        error: e,
        stackTrace: s,
      );
    }
  }

  /// Get the favorites list from the database
  static Future<List<String>> getFavoritesList() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'getFavoritesList',
      className: 'ProductsDatabaseUtils',
      fileName: 'databaseUtils.dart',
      start: true,
    );
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final result = pref.getStringList(favoritesList);

      if (result == null) {
        Dev.info('Result is null returning');
        return [];
      }
      // Function Log
      Dev.debugFunction(
        functionName: 'getFavoritesList',
        className: 'ProductsDatabaseUtils',
        fileName: 'databaseUtils.dart',
        start: false,
      );

      return result;
    } catch (e, s) {
      Dev.error('Update favorites list in db', error: e, stackTrace: s);
      return [];
    }
  }

  /// Get the favorite products from the database
  static Future<List<FavoriteProduct>> getFavoriteProducts() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'getFavoriteProducts',
      className: 'ProductsDatabaseUtils',
      fileName: 'databaseUtils.dart',
      start: true,
    );

    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final List<String>? refList = pref.getStringList(favoritesList);

      // If the result list from DB is empty or null, then just return
      // with an empty list to indicate of no data stored in the db yet
      if (refList == null || refList.isEmpty) {
        Dev.info('RefList is empty or null, returning');
        return [];
      }

      // list of products information as a string of map
      final List<String> productMapStringList = [];

      // Get the product map data using the productId from
      // the ref list
      for (final productId in refList) {
        // Get the product map string from the DB
        productMapStringList.add(pref.getString(productId)!);
      }

      // Function Log
      Dev.debugFunction(
        functionName: 'getFavoriteProducts',
        className: 'ProductsDatabaseUtils',
        fileName: 'databaseUtils.dart',
        start: false,
      );

      if (productMapStringList.isNotEmpty) {
        return await compute(decodeProductsInformation, productMapStringList);
      }
      return [];
    } catch (e, s) {
      Dev.error('Get favorite products list from db', error: e, stackTrace: s);
      return [];
    }
  }

  /// Adds a product instance to the products store in the local
  /// database
  static Future<void> addFavoriteProductToDB(FavoriteProduct fp) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'addProductToDB',
      className: 'ProductsDatabaseUtils',
      fileName: 'databaseUtils.dart',
      start: true,
    );
    try {
      final productMapString = await compute(jsonEncode, fp.toMap());
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString(fp.productId.toString(), productMapString);
      // Function Log
      Dev.debugFunction(
        functionName: 'addProductToDB',
        className: 'ProductsDatabaseUtils',
        fileName: 'databaseUtils.dart',
        start: false,
      );
    } catch (e, s) {
      Dev.error('Add product to db', error: e, stackTrace: s);
    }
  }

  /// Remove products from DB
  static Future<bool> removeFavoriteProductFromDB(String productId) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'removeProductFromDB',
      className: 'ProductsDatabaseUtils',
      fileName: 'databaseUtils.dart',
      start: true,
    );
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final bool result = await pref.remove(productId);

      // Function Log
      Dev.debugFunction(
        functionName: 'removeProductFromDB',
        className: 'ProductsDatabaseUtils',
        fileName: 'databaseUtils.dart',
        start: false,
      );

      return result;
    } catch (e, s) {
      Dev.error('Remove products from db', error: e, stackTrace: s);
      return false;
    }
  }

  //**********************************************************
  // Recent Products
  //**********************************************************

  static const String recentProductsList = 'recentProductsList';

  static Future<void> addToRecentProducts(RecentProduct product) async {
    final pref = await SharedPreferences.getInstance();
    final String? stringOfProductsList = pref.getString(recentProductsList);
    final listOfMap = await compute(
      decodeRecentProductList,
      stringOfProductsList,
    );
    if (listOfMap.length == 10) {
      listOfMap.removeLast();
    }
    listOfMap.insert(0, product.toMap());
    if (listOfMap.isNotEmpty) {
      // save to database
      final String databaseSaveString = await compute(jsonEncode, listOfMap);
      await pref.setString(recentProductsList, databaseSaveString);
    }
  }

  static Future<List<RecentProduct>> getRecentProducts() async {
    final pref = await SharedPreferences.getInstance();
    final String? stringOfProductsList = pref.getString(recentProductsList);
    final listOfMap = await compute(
      decodeRecentProductList,
      stringOfProductsList,
    );

    final result = <RecentProduct>[];
    for (final object in listOfMap) {
      result.add(RecentProduct.fromMap(object));
    }

    return result;
  }

  static Future<List<Map<String, dynamic>>> decodeRecentProductList(
    String? stringOfProductList,
  ) async {
    if (isBlank(stringOfProductList)) {
      return <Map<String, dynamic>>[];
    }
    return List.from(jsonDecode(stringOfProductList!))
        .cast<Map<String, dynamic>>();
  }
}

/// Top level function to decode and create products from a
/// list of strings of map of products information
///
/// Returns a Map of Product with Product.id (String) as the key
List<FavoriteProduct> decodeProductsInformation(
    List<String> productMapStringList) {
  // Function Log
  Dev.debugFunction(
    functionName: 'decodeProductsInformation',
    className: 'ProductDataBaseUtils',
    fileName: 'databaseUtils.dart',
    start: true,
  );
  final List<FavoriteProduct> productsList = [];
  for (final productMapString in productMapStringList) {
    if (isBlank(productMapString)) {
      Dev.info('Product Map String is empty');
      continue;
    }
    // Convert the mapString to product Map
    final Map<String, dynamic> _map =
        Map<String, dynamic>.from(jsonDecode(productMapString));

    final FavoriteProduct fp = FavoriteProduct.fromMap(_map);
    productsList.add(fp);
  }

  // Function Log
  Dev.debugFunction(
    functionName: 'decodeProductsInformation',
    className: 'ProductDataBaseUtils',
    fileName: 'databaseUtils.dart',
    start: false,
  );

  return productsList;
}
