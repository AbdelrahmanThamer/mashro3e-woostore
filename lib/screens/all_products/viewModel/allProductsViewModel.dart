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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';

import '../../../app_builder/app_builder.dart';
import '../../../developer/dev.log.dart';
import '../../../enums/enums.dart';
import '../../../locator.dart';
import '../../../models/models.dart';
import '../../../providers/utils/baseProvider.dart';
import '../../../services/pagination/pagination.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../../../shared/filter_modal/filter_view_model.dart';
import '../../../utils/utils.dart';

class AllProductsViewModel extends BaseProvider {
  AllProductsViewModel({
    required this.screenData,
    required this.action,
  }) {
    paginationController = StateNotifierProvider.autoDispose((ref) {
      return PaginationController(
        fetchMoreData: fetchMoreData,
      );
    });

    filterViewModel = FilterViewModel(
      onApplyFilters: fetchData,
      tagId: action.tagData.tagId,
      categoryId: action.categoryData.categoryId,
    );
  }

  //**********************************************************
  //  Data Holders
  //**********************************************************

  final AppAllProductsScreenData screenData;

  /// The provider to get the data from
  final NavigateToAllProductsScreenAction action;

  /// Hold the search list data
  UnmodifiableListView<String> _productsList = UnmodifiableListView(const []);

  UnmodifiableListView<String> get productsList => _productsList;

  /// Controls the pagination of the screen
  late final AutoDisposeStateNotifierProvider<PaginationController,
      PaginationState> paginationController;

  late final FilterViewModel filterViewModel;
  WooStoreFilters get filters => filterViewModel.filters;

  //**********************************************************
  //  Public Functions
  //**********************************************************

  @override
  void dispose() {
    // Function Log
    Dev.debugFunction(
      functionName: 'dispose',
      className: 'AllProductsViewModel',
      fileName: 'allProductsViewModel.dart',
      start: true,
    );

    _productsList = UnmodifiableListView(const []);

    /// Set the state to loading for next access
    state = ViewState.LOADING;

    // Function Log
    Dev.debugFunction(
      functionName: 'dispose',
      className: 'AllProductsViewModel',
      fileName: 'allProductsViewModel.dart',
      start: false,
    );

    super.dispose();
  }

  /// Returns the dynamic title for the View
  String? getTitle() {
    try {
      if (isNotBlank(action.title)) {
        return Utils.capitalize(action.title);
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  /// Fetch the data based on the search term
  Future<void> fetchData() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'fetchData',
      className: 'AllProductsViewModel',
      fileName: 'allProductsViewModel.dart',
      start: true,
    );

    try {
      notifyLoading();
      final result = await _getDataFromBackend();

      if (result.isEmpty) {
        notifyState(ViewState.NO_DATA_AVAILABLE);
      } else {
        _productsList = UnmodifiableListView(_processRawData(result));
        notifyState(ViewState.DATA_AVAILABLE);
      }
    } catch (e) {
      Dev.error('Fetch data AllProductsViewModel error', error: e);
      if (_productsList.isEmpty) {
        notifyError(message: Utils.renderException(e));
      } else {
        notifyState(ViewState.DATA_AVAILABLE);
      }
    }
  }

  /// Fetch the data based on the search term
  Future<FetchActionResponse> fetchMoreData(int page) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'fetchMoreData',
      className: 'AllProductsViewModel',
      fileName: 'allProductsViewModel.dart',
      start: true,
    );

    try {
      final result = await _getDataFromBackend(page: page);

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchMoreData',
        className: 'AllProductsViewModel',
        fileName: 'allProductsViewModel.dart',
        start: false,
      );

      if (result.isEmpty) {
        return FetchActionResponse.NoDataAvailable;
      } else {
        // If result is not empty then process the data
        if (result.length < ParseEngine.itemsPerPage) {
          // If result is less than the requested length, then
          // this is the last lot of data.
          _productsList = UnmodifiableListView([
            ..._productsList,
            ..._processRawData(result),
          ]);
          notifyListeners();
          return FetchActionResponse.LastData;
        } else {
          // If result is not empty then process the data
          _productsList = UnmodifiableListView([
            ..._productsList,
            ..._processRawData(result),
          ]);
          notifyListeners();
          return FetchActionResponse.Successful;
        }
      }
    } catch (e, s) {
      Dev.error(
        'Fetch more data error',
        error: e,
        stackTrace: s,
      );
      return FetchActionResponse.Failed;
    }
  }

  //**********************************************************
  //  Helpers
  //**********************************************************

  Future<List<WooProduct>> _getDataFromBackend({int page = 1}) async {
    String? _category;
    if (filters.parentCategoryId != null && filters.parentCategoryId! > 0) {
      _category = filters.parentCategoryId.toString();
    }

    if (filters.childCategoryId != null && filters.childCategoryId! > 0) {
      _category = filters.childCategoryId.toString();
    }

    final result = await LocatorService.wooService().wc.getProducts(
          category: _category,
          tag: (filters.tagId != null && filters.tagId != 0)
              ? filters.tagId.toString()
              : null,
          minPrice: filters.minPrice?.toString(),
          maxPrice: filters.maxPrice?.toString(),
          perPage: ParseEngine.itemsPerPage,
          page: page,
          status: 'publish',
          stockStatus: filters.inStock ? 'instock' : null,
          onSale: filters.onSale ? filters.onSale : null,
          featured: filters.featured ? filters.featured : null,
          orderBy: WooUtils.convertSortOptionToString(filters.sortOption),
          order: WooUtils.setSortOrder(filters.sortOption),
          taxonomyQuery: await filters.buildTaxonomyQuery(),
        );
    return result;
  }

  /// Process the product data list and returns a list of product's ids and adds
  /// them to the all products map in products provider for liking and other
  /// local stuff.
  @protected
  List<String> _processRawData(List<WooProduct> productsDataList) {
    // Function Log
    Dev.debugFunction(
      functionName: '_processRawData',
      className: 'AllProductsViewModel',
      fileName: 'allProductsViewModel.dart',
      start: true,
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
    // Function Log
    Dev.debugFunction(
      functionName: '_processRawData',
      className: 'AllProductsViewModel',
      fileName: 'allProductsViewModel.dart',
      start: false,
    );
    return result;
  }
}
