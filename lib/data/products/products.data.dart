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

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../../developer/dev.log.dart';
import '../../models/productModel.dart';
import '../../models/recent_product.dart';
import '../../screens/favorites/models/favoriteProduct.model.dart';
import 'utils/databaseUtils.dart';

///
/// `Description`
///
/// Keeps track of all the products that are needed in this application.
///
class ProductsRepository {
  /// All products map
  final Map<String, Product> _allProducts = {};

  Map<String, Product> get allProducts => _allProducts;

  /// Map to contain the favorite products of the user.
  final Map<String, FavoriteProduct> _favProductsMap = {};

  /// Getter for [_favProductsMap].
  Map<String, FavoriteProduct> get favProductsMap => _favProductsMap;

  /// Favorite Products reference list
  final Set<String> _favProducts = {};

  List<String> get favProducts => _favProducts.toList();

  /// Run the required functions when creating the products repo
  Future<void> loadFavoriteProducts() async {
    final favListFromDB = await ProductsDatabaseUtils.getFavoritesList();

    _favProducts.addAll(favListFromDB);

    final _favoriteProductsList =
        await ProductsDatabaseUtils.getFavoriteProducts();
    for (final value in _favoriteProductsList) {
      _favProductsMap.addAll({value.productId.toString(): value});
    }
  }

  /// Add product to the store
  void addToAllProducts(Product product) {
    if (_allProducts.containsKey(product.id)) {
      _allProducts.addAll({product.id: product.copyWith(product)});
    } else {
      _allProducts.addAll({product.id: product});
    }
  }

  /// Remove product from the store
  void removeFromAllProducts({Product product, String productId}) {
    if (product != null) {
      if (_allProducts.containsKey(product.id)) {
        _allProducts.remove(product.id);
        return;
      }
    }

    if (productId != null) {
      if (_allProducts.containsKey(productId)) {
        _allProducts.remove(productId);
        return;
      }
    }
  }

  /// Get the product with a product Id
  Product getProductWithId(String productId) {
    if (_allProducts.containsKey(productId)) {
      return _allProducts[productId];
    }
    return null;
  }

  /// Function to update the `liked` status of a Product object.
  void toggleStatus(String productId, {bool status}) {
    final Product p = _allProducts[productId];
    if (p != null) {
      p.toggleLikedStatus(status: status);
      if (p.liked) {
        _addToFavProducts(product: p);
      } else {
        _removeFromFavProducts(productId: p.id);
      }
    } else {
      // If the item is not present in the all products
      // still run the remove function to remove the item from
      // Favorites Map if present
      _removeFromFavProducts(productId: productId);
    }
  }

  /// Add the product data to favorite products map
  void _addToFavProducts({Product product}) {
    // Function Log
    Dev.debugFunction(
      functionName: '_addToFavProducts',
      className: 'ProductsRepository',
      fileName: 'products.data.dart',
      start: true,
    );
    // If the favorites list doesn't contain the product.
    if (_favProductsMap.containsKey(product.id)) {
      // Update the favorite item
      final FavoriteProduct fp = FavoriteProduct.fromProduct(product);
      _favProductsMap.addAll({product.id: fp});
    } else {
      final FavoriteProduct fp = FavoriteProduct.fromProduct(product);
      _favProducts.add(product.id);
      _favProductsMap.addAll({product.id: fp});
      ProductsDatabaseUtils.addToFavoritesRefList(product.id);
      ProductsDatabaseUtils.addFavoriteProductToDB(fp);
    }

    // Function Log
    Dev.debugFunction(
      functionName: '_addToFavProducts',
      className: 'ProductsRepository',
      fileName: 'products.data.dart',
      start: false,
    );
  }

  /// Add the product data to favorite products map
  void _removeFromFavProducts({String productId}) {
    // Function Log
    Dev.debugFunction(
      functionName: '_removeFromFavProducts',
      className: 'ProductsRepository',
      fileName: 'products.data.dart',
      start: true,
    );
    _favProducts.remove(productId);
    _favProductsMap.remove(productId);
    ProductsDatabaseUtils.removeFromFavoritesRefList(productId);
    ProductsDatabaseUtils.removeFavoriteProductFromDB(productId);
    // Function Log
    Dev.debugFunction(
      functionName: '_removeFromFavProducts',
      className: 'ProductsRepository',
      fileName: 'products.data.dart',
      start: false,
    );
  }

  //**********************************************************
  // Recent Products Section
  //**********************************************************

  ValueNotifier<UnmodifiableListView<RecentProduct>> recentProductsList =
      ValueNotifier(UnmodifiableListView(const []));

  Future<void> addToRecentProducts(Product product) async {
    for (final o in recentProductsList.value) {
      if (o.id == product.id) {
        Dev.info('Recent Product already present');
        return;
      }
    }

    final RecentProduct recentProduct = RecentProduct(
      id: product.id,
      name: product.wooProduct.name,
      displayImage: product.displayImage,
    );

    await ProductsDatabaseUtils.addToRecentProducts(recentProduct);
    recentProductsList.value =
        UnmodifiableListView([recentProduct, ...recentProductsList.value]);
  }

  Future<UnmodifiableListView<RecentProduct>> getRecentProducts() async {
    if (recentProductsList.value.isNotEmpty) {
      return recentProductsList.value;
    }
    final result = await ProductsDatabaseUtils.getRecentProducts();
    if (result.isNotEmpty) {
      recentProductsList.value = UnmodifiableListView(result);
    }

    return UnmodifiableListView(const []);
  }
}
