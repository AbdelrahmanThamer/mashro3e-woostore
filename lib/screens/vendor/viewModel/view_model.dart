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

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_builder/app_builder.dart';
import '../../../developer/dev.log.dart';
import '../../../enums/enums.dart';
import '../../../locator.dart';
import '../../../models/productModel.dart';
import '../../../providers/utils/baseProvider.dart';
import '../../../services/pagination/pagination.dart';
import '../../../services/woocommerce/woocommerce.service.dart';

class VendorProductsViewModel extends BaseProvider with WooFiltersMixin {
  VendorProductsViewModel(this.vendor) {
    paginationController = StateNotifierProvider.autoDispose((ref) {
      return PaginationController(
        fetchMoreData: fetchMoreData,
      );
    });
  }

  //**********************************************************
  //  Data Holders
  //**********************************************************

  Vendor vendor;

  /// Error message state holder
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  /// Holds all the products' id from the tag selected.
  UnmodifiableListView<String> _productsList = UnmodifiableListView(const []);

  UnmodifiableListView<String> get productsList => _productsList;

  /// Controls the pagination of the screen
  late final AutoDisposeStateNotifierProvider<PaginationController,
      PaginationState> paginationController;

  //**********************************************************
  //  Functions
  //**********************************************************

  /// Fetch the product data for the tag chosen.
  Future<void> fetchData() async {
    Dev.debugFunction(
      functionName: 'fetchData',
      className: 'VendorProductsViewModel',
      fileName: 'VendorProductsViewModel',
      start: true,
    );

    try {
      _onLoading(true);
      final _r = _processRawData(await _getDataFromBackend());

      if (_r.isEmpty) {
        _onSuccessful(isDataPresent: false);
      } else {
        _productsList = UnmodifiableListView([..._r]);
        _onSuccessful();
      }
      Dev.debugFunction(
        functionName: 'fetchData',
        className: 'VendorProductsViewModel',
        start: false,
        fileName: 'VendorProductsViewModel',
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      _onError(e.toString());
    }
  }

  /// Fetch more product data for the tag chosen
  Future<FetchActionResponse> fetchMoreData(int pageNumber) async {
    Dev.debugFunction(
      functionName: 'fetchMoreData',
      className: 'VendorProductsViewModel',
      start: true,
      fileName: 'VendorProductsViewModel',
    );

    try {
      final _r = _processRawData(await _getDataFromBackend(
        page: pageNumber,
      ));

      if (_r.isEmpty) {
        if (_productsList.isEmpty) {
          Dev.debugFunction(
            functionName: 'fetchMoreData',
            className: 'VendorProductsViewModel',
            start: false,
            fileName: 'VendorProductsViewModel',
          );
          return FetchActionResponse.NoDataAvailable;
        } else {
          Dev.debugFunction(
            functionName: 'fetchMoreData',
            className: 'VendorProductsViewModel',
            start: false,
            fileName: 'VendorProductsViewModel',
          );
          return FetchActionResponse.LastData;
        }
      } else {
        // add the data to the list
        _productsList = UnmodifiableListView([..._productsList, ..._r]);
        notifyListeners();
        // if result is not empty then check if the length of list is less than
        // 20 to check if this was the last amount of data that was available.
        if (_r.length < 20) {
          Dev.debugFunction(
            functionName: 'fetchMoreData',
            className: 'VendorProductsViewModel',
            start: false,
            fileName: 'VendorProductsViewModel',
          );
          return FetchActionResponse.LastData;
        } else {
          Dev.debugFunction(
            functionName: 'fetchMoreData',
            className: 'VendorProductsViewModel',
            start: false,
            fileName: 'VendorProductsViewModel',
          );
          return FetchActionResponse.Successful;
        }
      }
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return FetchActionResponse.Failed;
    }
  }

  /// Fetch the product data for the tag chosen with the new price range.
  Future<void> fetchDataWithNewPrice() async {
    Dev.debugFunction(
      functionName: 'fetchDataWithNewPrice',
      className: 'VendorProductsViewModel',
      start: true,
      fileName: 'VendorProductsViewModel',
    );

    try {
      // Reset the page and final data set info as a new price
      // is set
      _onLoading(true);
      final _r = _processRawData(await _getDataFromBackend());

      if (_r.isEmpty) {
        _onSuccessful(isDataPresent: false);
      } else {
        _productsList = UnmodifiableListView([..._r]);
        _onSuccessful();
      }
      Dev.debugFunction(
        functionName: 'fetchDataWithNewPrice',
        className: 'VendorProductsViewModel',
        start: false,
        fileName: 'VendorProductsViewModel',
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
      _onLoading(true);
      final _r = _processRawData(await _getDataFromBackend());

      if (_r.isEmpty) {
        _onSuccessful(isDataPresent: false);
      } else {
        _productsList = UnmodifiableListView([..._r]);
        _onSuccessful();
      }
      Dev.debugFunction(
        functionName: 'fetchWithSortOptions',
        className: 'VendorProductsViewModel',
        start: false,
        fileName: 'VendorProductsViewModel',
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      _onError(e.toString());
    }
  }

  Future<Vendor?> getCompleteVendorData(int vendorId) async {
    try {
      final List<Vendor> result =
          await LocatorService.wooService().fetchVendors(
        includes: [vendorId],
      );

      if (result.isNotEmpty) {
        return result.firstWhereOrNull((element) => element.id == vendorId);
      }
      return null;
    } catch (e, s) {
      Dev.error('Get complete vendor data error', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// Gets the data from backend and returns a list of map of strings and dynamic
  /// values to process.
  @protected
  Future<List<WooProduct>> _getDataFromBackend({int page = 1}) async {
    Dev.debugFunction(
      functionName: '_getDataFromBackend',
      className: 'VendorProductsViewModel',
      start: true,
      fileName: 'VendorProductsViewModel',
    );

    // Get data from WooCommerce
    if (vendor.id != null && vendor.id! <= 0) {
      Dev.error('Vendor is empty...aborting fetch event');
      return const [];
    }

    try {
      final List<WooProduct> _result =
          await LocatorService.wooService().wc.getProducts(
        page: page,
        perPage: ParseEngine.itemsPerPage,
        minPrice: filters.minPrice.toString(),
        maxPrice: filters.maxPrice.toString(),
        stockStatus: filters.inStock ? 'instock' : null,
        onSale: filters.onSale ? filters.onSale : null,
        featured: filters.featured ? filters.featured : null,
        orderBy: WooUtils.convertSortOptionToString(filters.sortOption),
        order: WooUtils.setSortOrder(filters.sortOption),
        taxonomyQuery: await filters.buildTaxonomyQuery(),
        extraParams: {'vendor': vendor.id},
      );
      Dev.debugFunction(
        functionName: '_getDataFromBackend',
        className: 'VendorProductsViewModel',
        start: false,
        fileName: 'VendorProductsViewModel',
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
      className: 'VendorProductsViewModel',
      start: true,
      fileName: 'VendorProductsViewModel',
    );
    final List<String> result = [];
    if (productsDataList.isNotEmpty) {
      for (var i = 0; i < productsDataList.length; i++) {
        if (_productsList.contains(productsDataList[i].id.toString())) {
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
      className: 'VendorProductsViewModel',
      start: false,
      fileName: 'VendorProductsViewModel',
    );
    return result;
  }

  //**********************************************************
  //  Helper Functions
  //**********************************************************

  /// Changes the flags to reflect loading event and notify the listeners.
  void _onLoading(bool value) {
    state = ViewState.LOADING;
    notifyListeners();
  }

  /// Changes the flags to reflect success and notify the listeners.
  void _onSuccessful({bool isDataPresent = true}) {
    state =
        isDataPresent ? ViewState.DATA_AVAILABLE : ViewState.NO_DATA_AVAILABLE;
    notifyListeners();
  }

  void _onError(String message) {
    state = ViewState.ERROR;
    _errorMessage = message;
    notifyListeners();
  }

  /// Cleans the resources when the `categorisedProducts` screen is disposed
  /// for the next session
  void cleanUp() {
    state = ViewState.LOADING;
    _productsList = UnmodifiableListView(const []);
    _errorMessage = '';
    filters = const WooStoreFilters();
  }

  @override
  void dispose() {
    cleanUp();
    super.dispose();
  }
}
