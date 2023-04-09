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

import '../../developer/dev.log.dart';
import '../../locator.dart';
import '../../models/productModel.dart';
import '../../screens/favorites/models/favoriteProduct.model.dart';
import '../../services/woocommerce/woocommerce.service.dart';
import '../../utils/utils.dart';
import '../utils/baseProvider.dart';

class ProductsProvider extends BaseProvider {
  // Single instance variable
  static ProductsProvider? _instance;

  // Factory to return a single instance every time
  factory ProductsProvider() {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = ProductsProvider._();
      return _instance!;
    }
  }

  // Private constructor
  ProductsProvider._();

  Map<String, Product> get productsMap =>
      LocatorService.productsRepository().allProducts;

  List<String> get favProducts =>
      LocatorService.productsRepository().favProducts;

  Map<String, FavoriteProduct> get favoriteProductsMap =>
      LocatorService.productsRepository().favProductsMap;

  /// Get the favorite products from the Local Database and fetch
  Future<void> getFavoriteProductsFromDB() async {
    try {
      notifyLoading();
      await LocatorService.productsRepository().loadFavoriteProducts();
      notifyState(ViewState.DATA_AVAILABLE);
    } catch (e) {
      notifyError(message: Utils.renderException(e));
      Dev.error('getFavoriteProductsFromDB favorites view model', error: e);
    }
  }

  // Helper Function
  void addToMap(Product p) {
    LocatorService.productsRepository().addToAllProducts(p);
  }

  /// Function to update the `liked` status of a Product object in the
  /// product repository
  void toggleStatus(String productId, {bool? status}) {
    LocatorService.productsRepository().toggleStatus(productId, status: status);
    // _favProducts = LocatorService.productsRepository().favProducts;
    notifyListeners();
  }

  // void setProductSize(String productId, String sizeValue) {
  //   final Product p = productsMap[productId];
  //   p.setSize = sizeValue;
  //   notifyListeners();
  // }
  //
  // void setProductColor(String productId, Color color) {
  //   final Product p = productsMap[productId];
  //   p.setColor = color;
  //   notifyListeners();
  // }

  void increaseProductQuantity(String productId) {
    final Product? p = productsMap[productId];
    p?.setQuantity = p.quantity + 1;
    notifyListeners();
  }

  void decreaseProductQuantity(String productId) {
    final Product? p = productsMap[productId];
    p?.setQuantity = p.quantity == 1 ? 1 : p.quantity - 1;
    notifyListeners();
  }

  /// Set the variation selected for the product
  void setProductVariation(String productId, WooProductVariation variation) {
    final Product? p = productsMap[productId];
    p?.setSelectedProductVariation(variation);
  }

  /// Fetch products based on their ids and adds them to
  /// all products store or repository
  Future<List<Product>> fetchProductsById(List<int> idList,
      {bool shouldCheckInCache = false}) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'fetchProductsById',
      className: 'ProductsProvider',
      fileName: 'products.provider.dart',
      start: true,
    );
    try {
      final List<Product> productList = [];

      // Create a new list to make changes to its data without affecting the
      // passed parameter list reference.
      final productIds = List<int>.from(idList);

      // Check for the products in cache
      if (shouldCheckInCache) {
        final tempList = List<int>.from(productIds);
        for (final id in tempList) {
          if (productsMap.containsKey(id.toString())) {
            Dev.debug('Found Product with id: $id in cache');

            // The product is present, there fore do not fetch this from
            // backend
            productList.add(productsMap[id.toString()]!);

            // remove the id from the product id list which
            // fetches the data for all the id present in it
            productIds.remove(id);
          }
        }

        // If the products id list is empty after the cache check up, then just
        // return the product list.
        if (productIds.isEmpty) {
          Dev.debug('Product Ids is empty, returning with cache result');
          return productList;
        }
      }

      final List<WooProduct> result =
          await LocatorService.wooService().wc.getProducts(
                include: productIds,
              );

      if (result.isNotEmpty) {
        for (final o in result) {
          final Product p = Product.fromWooProduct(o);
          addToMap(p);
          productList.add(p);
        }
      }

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchProductsById',
        className: 'ProductsProvider',
        fileName: 'products.provider.dart',
        start: false,
      );

      return productList;
    } catch (e, s) {
      Dev.error('Fetch Products by id error', error: e, stackTrace: s);
      return const [];
    }
  }

  /// Fetches the information about a single product with id.
  /// If the [shouldCheckInCache] flag is true, then the product is searched
  /// in the products repo as well and returned if found.
  ///
  /// Cache functionality is used when the updated product data is not required.
  Future<Product?> fetchSingleProductById(int productId,
      {bool shouldCheckInCache = false}) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'fetchSingleProductById',
      className: 'ProductsProvider',
      fileName: 'products.provider.dart',
      start: true,
    );
    try {
      // Check for the products in cache
      if (shouldCheckInCache) {
        // Check for product in products repo
        final Product? _cacheProduct = productsMap[productId.toString()];
        if (_cacheProduct != null) {
          Dev.debug('Returning product from cache');
          return Future.value(_cacheProduct);
        }
      }

      final WooProduct? result =
          await LocatorService.wooService().wc.getProductById(
                id: productId,
              );

      if (result == null) {
        return null;
      }

      final Product p = Product.fromWooProduct(result);
      addToMap(p);

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchSingleProductById',
        className: 'ProductsProvider',
        fileName: 'products.provider.dart',
        start: false,
      );

      return p;
    } catch (e, s) {
      Dev.error('Fetch Products by id error', error: e, stackTrace: s);
      return null;
    }
  }

  /// Fetch the product variation
  Future<WooProductVariation?> fetchProductVariation(
    int productId,
    int variationId,
  ) async {
    try {
      final WooProductVariation? resultOfVariation =
          await LocatorService.wooService().wc.getProductVariationById(
                productId: productId,
                variationId: variationId,
              );

      if (resultOfVariation != null) {
        return resultOfVariation;
      }
      return null;
    } catch (e, s) {
      Dev.error('Fetch Product Variation by ids error',
          error: e, stackTrace: s);
      return null;
    }
  }
}
