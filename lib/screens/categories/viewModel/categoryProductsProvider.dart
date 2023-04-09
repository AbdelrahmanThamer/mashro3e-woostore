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

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../app_builder/app_builder.dart';
import '../../../developer/dev.log.dart';
import '../../../enums/enums.dart';
import '../../../locator.dart';
import '../../../models/productModel.dart';
import '../../../providers/utils/baseProvider.dart';
import '../../../services/woocommerce/woocommerce.service.dart';

class CategoryProductsProvider extends BaseProvider with WooFiltersMixin {
  //**********************************************************
  //  Data Holders
  //**********************************************************

  /// The previous category as a reference for the new fetch data request
  @protected
  WooProductCategory? _oldCategory;

  /// The initial category before the filters were used
  WooProductCategory? _initialCategory;

  /// The current category to search for in the categorised products screen
  WooProductCategory? _currentCategory;

  /// Get the current category
  WooProductCategory? get currentCategory => _currentCategory;

  /// Set the current category along with its children if they are present
  void setCurrentCategory(
    WooProductCategory value, {
    List<WooProductCategory> childrenCategories = const [],
  }) {
    Dev.info(
        'Selected [WooProductCategory]\n\nId: ${value.id}\nName: ${value.name}\nChildren list length ${childrenCategories.length}');
    _initialCategory = value;

    _currentCategory = value;
    _childrenCategories = childrenCategories;
    try {
      // Set the child categories from the Global categories map if the passed
      // parameter is empty
      if (childrenCategories.isEmpty) {
        LocatorService.categoriesProvider()
            .categoriesMap
            .forEach((parent, childrenList) {
          if (parent.id == value.id && childrenList.isNotEmpty) {
            _childrenCategories = childrenList;
          }
        });
      }
    } catch (_) {}
    _searchCategory = value;
  }

  /// List of all the children categories that this `currentCategory` (which
  /// is a parent category ) contains as a child.
  ///
  /// If this is empty for a given `currentCategory`, it suggests that there are
  /// no child categories for the given `currentCategory` hence fetch the
  /// products for this only.
  List<WooProductCategory> _childrenCategories = [];

  List<WooProductCategory> get childrenCategories => _childrenCategories;

  /// Search products for the type of categories.
  WooProductCategory? _searchCategory;

  WooProductCategory? get searchCategory => _searchCategory;

  void setSearchCategory(WooProductCategory value) {
    if (_searchCategory == value) {
      return;
    }

    _searchCategory = value;

    // When new category is set, reset the values
    reset();
    performAfterCategoryChangeActionsAndNotify();
  }

  /// Error message state holder
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  /// Holds all the products' id from the category selected.
  UnmodifiableListView<String> _categoryProductsList =
      UnmodifiableListView(const []);

  UnmodifiableListView<String> get categoryProductsList =>
      _categoryProductsList;

  /// Page to get the data for
  int pageNumber = 2;

  /// Flag to check if more data is available
  bool isFinalDataSet = false;

  WooStoreFilters get categoryFilters => filters;

  //**********************************************************
  //  Events
  //**********************************************************

  /// Loading event
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// Success flag to verify if data fetching event was successfully.
  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  /// Error flag for any error while fetching
  bool _isError = false;

  bool get isError => _isError;

  /// Flag to check if there is data or not
  bool _hasData = false;

  bool get hasData => _hasData;

  //**********************************************************
  //  Functions
  //**********************************************************

  /// Fetch the product data for the category chosen.
  Future<void> fetchData() async {
    Dev.debugFunction(
      functionName: 'fetchData',
      className: 'CategoryProductsProvider',
      fileName: 'CategoryProductsProvider',
      start: true,
    );

    Dev.info(
      'Current Category: ${_currentCategory?.name}\nSearch Category: ${_searchCategory?.name}',
    );

    if (searchCategory == null || searchCategory?.id == null) {
      return;
    }

    Dev.info(
        'OldCategory: ${_oldCategory?.name}\nSearch Category: ${_searchCategory?.name}');

    if (_oldCategory != null) {
      if (_oldCategory == _searchCategory && _categoryProductsList.isNotEmpty) {
        Dev.info('Both categories are same...returning');
        return;
      }
    }

    try {
      _onLoading(true);
      final _r = _processRawData(await _getDataFromBackend());

      if (_r.isEmpty) {
        _oldCategory = _searchCategory;
        _onSuccessful(isDataPresent: false);
      } else {
        _categoryProductsList = UnmodifiableListView([..._r]);
        _oldCategory = _searchCategory;
        _onSuccessful();
      }
      Dev.debugFunction(
        functionName: 'fetchData',
        className: 'CategoryProductsProvider',
        start: false,
        fileName: 'CategoryProductsProvider',
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      _onError(e.toString());
    }
  }

  /// Fetch more product data for the category chosen
  Future<FetchActionResponse> fetchMoreData() async {
    Dev.debugFunction(
      functionName: 'fetchMoreData',
      className: 'CategoryProductsProvider',
      start: true,
      fileName: 'CategoryProductsProvider',
    );

    Dev.info(
      'Current Category: ${_currentCategory?.name}\nSearch Category: ${_searchCategory?.name}\nPage Number: $pageNumber',
    );

    if (searchCategory == null || searchCategory?.id == null) {
      Dev.debugFunction(
        functionName: 'fetchMoreData',
        className: 'CategoryProductsProvider',
        start: false,
        fileName: 'CategoryProductsProvider',
      );
      return FetchActionResponse.Failed;
    }

    try {
      final _r = _processRawData(await _getDataFromBackend(
        page: pageNumber,
      ));

      if (_r.isEmpty) {
        if (_categoryProductsList.isEmpty) {
          Dev.debugFunction(
            functionName: 'fetchMoreData',
            className: 'CategoryProductsProvider',
            start: false,
            fileName: 'CategoryProductsProvider',
          );
          isFinalDataSet = true;
          return FetchActionResponse.NoDataAvailable;
        } else {
          Dev.debugFunction(
            functionName: 'fetchMoreData',
            className: 'CategoryProductsProvider',
            start: false,
            fileName: 'CategoryProductsProvider',
          );
          isFinalDataSet = true;
          return FetchActionResponse.LastData;
        }
      } else {
        // add the data to the list

        _categoryProductsList =
            UnmodifiableListView([..._categoryProductsList, ..._r]);
        notifyListeners();
        // if result is not empty then check if the length of list is less than
        // `ParseEngine.itemsPerPage` to check if this was the last amount of data that was available.
        if (_r.length < ParseEngine.itemsPerPage) {
          Dev.debugFunction(
            functionName: 'fetchMoreData',
            className: 'CategoryProductsProvider',
            start: false,
            fileName: 'CategoryProductsProvider',
          );
          isFinalDataSet = true;
          return FetchActionResponse.LastData;
        } else {
          Dev.debugFunction(
            functionName: 'fetchMoreData',
            className: 'CategoryProductsProvider',
            start: false,
            fileName: 'CategoryProductsProvider',
          );
          pageNumber++;
          return FetchActionResponse.Successful;
        }
      }
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return FetchActionResponse.Failed;
    }
  }

  /// Fetch the product data for the category chosen with the new price range.
  Future<void> fetchDataWithNewPrice() async {
    Dev.debugFunction(
      functionName: 'fetchDataWithNewPrice',
      className: 'CategoryProductsProvider',
      start: true,
      fileName: 'CategoryProductsProvider',
    );

    if (searchCategory == null || searchCategory?.id == null) {
      return;
    }

    try {
      // Reset the page and final data set info as a new price
      // is set
      reset();
      _onLoading(true);
      final _r = _processRawData(await _getDataFromBackend());

      if (_r.isEmpty) {
        _oldCategory = _searchCategory;
        _onSuccessful(isDataPresent: false);
      } else {
        _categoryProductsList = UnmodifiableListView([..._r]);
        _oldCategory = _searchCategory;
        _onSuccessful();
      }
      Dev.debugFunction(
        functionName: 'fetchDataWithNewPrice',
        className: 'CategoryProductsProvider',
        start: false,
        fileName: 'CategoryProductsProvider',
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      _onError(e.toString());
    }
  }

  /// Fetch the product data for the category chosen with sort option
  /// filter
  Future<void> fetchWithSortOption() async {
    Dev.debugFunction(
      functionName: 'fetchWithSortOption',
      className: 'CategoryProductsProvider',
      fileName: 'CategoryProductsProvider',
      start: true,
    );

    try {
      // Reset the page and final data set info as a new price
      // is set
      reset();
      _onLoading(true);
      final _r = _processRawData(await _getDataFromBackend());

      if (_r.isEmpty) {
        _oldCategory = _searchCategory;
        _onSuccessful(isDataPresent: false);
      } else {
        _categoryProductsList = UnmodifiableListView([..._r]);
        _oldCategory = _searchCategory;
        _onSuccessful();
      }
      Dev.debugFunction(
        functionName: 'fetchWithSortOption',
        className: 'CategoryProductsProvider',
        start: false,
        fileName: 'CategoryProductsProvider',
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      _onError(e.toString());
    }
  }

  /// Gets the data from backend and returns a list of map of strings and dynamic
  /// values to process.
  @protected
  Future<List<WooProduct>> _getDataFromBackend({int page = 1}) async {
    Dev.debugFunction(
      functionName: '_getDataFromBackend',
      className: 'CategoryProductsProvider',
      start: true,
      fileName: 'CategoryProductsProvider',
    );
    // Get data from WooCommerce
    if (_searchCategory == null) {
      Dev.error('Search Category is empty...aborting fetch event');
      return const [];
    }

    try {
      final List<WooProduct> _result = await LocatorService.wooService()
          .wc
          .getProducts(
            category: _searchCategory?.id?.toString(),
            page: page,
            perPage: ParseEngine.itemsPerPage,
            minPrice: categoryFilters.minPrice.toString(),
            maxPrice: categoryFilters.maxPrice.toString(),
            stockStatus: categoryFilters.inStock ? 'instock' : null,
            onSale: categoryFilters.onSale ? categoryFilters.onSale : null,
            featured:
                categoryFilters.featured ? categoryFilters.featured : null,
            orderBy:
                WooUtils.convertSortOptionToString(categoryFilters.sortOption),
            order: WooUtils.setSortOrder(categoryFilters.sortOption),
            taxonomyQuery: await categoryFilters.buildTaxonomyQuery(),
          );
      Dev.debugFunction(
        functionName: '_getDataFromBackend',
        className: 'CategoryProductsProvider',
        start: false,
        fileName: 'CategoryProductsProvider',
      );
      return _result;
    } catch (e) {
      Dev.error('End =====>> [_getDataFromBackend]', error: e);
      return const [];
    }
  }

  /// Process the product data list and returns a list of product's ids and adds
  /// them to the all products map in products provider for liking and other
  /// local stuff.
  @protected
  List<String> _processRawData(List<WooProduct> productsDataList) {
    // Function log
    Dev.debugFunction(
      functionName: '_processRawData',
      className: 'CategoryProductsProvider',
      start: true,
      fileName: 'CategoryProductsProvider',
    );
    final List<String> result = [];
    if (productsDataList.isNotEmpty) {
      for (var i = 0; i < productsDataList.length; i++) {
        if (_categoryProductsList.contains(productsDataList[i].id.toString())) {
          result.add(productsDataList[i].id.toString());
          continue;
        }
        final Product p = Product.fromWooProduct(productsDataList[i]);
        result.add(p.id.toString());
        LocatorService.productsProvider().addToMap(p);
      }
    }
    // Function log
    Dev.debugFunction(
      functionName: '_processRawData',
      className: 'CategoryProductsProvider',
      start: false,
      fileName: 'CategoryProductsProvider',
    );
    return result;
  }

  //**********************************************************
  //  Helper Functions
  //**********************************************************

  /// Changes the flags to reflect loading event and notify the listeners.
  void _onLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Changes the flags to reflect success and notify the listeners.
  void _onSuccessful({bool isDataPresent = true}) {
    _isLoading = false;
    _isSuccess = true;
    _isError = false;
    _hasData = isDataPresent;
    notifyListeners();
  }

  void _onError(String message) {
    _isLoading = false;
    _isSuccess = false;
    _isError = true;
    _errorMessage = message;
    notifyListeners();
  }

  /// Cleans the resources when the `categorisedProducts` screen is disposed
  /// for the next session
  void cleanUp() {
    _categoryProductsList = UnmodifiableListView(const []);
    _searchCategory = _currentCategory = _initialCategory = null;
    _childrenCategories = [];
    _errorMessage = '';
    filters = const WooStoreFilters();
  }

  void reset() {
    pageNumber = 2;
    isFinalDataSet = false;
  }

  /// Clear all the filters selected
  @override
  void clearFilters() {
    _searchCategory = _initialCategory;
    super.clearFilters();
  }
}
