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

import 'dart:collection';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_builder/app_builder.dart';
import '../../../enums/enums.dart';
import '../../../locator.dart';
import '../../../providers/utils/baseProvider.dart';
import '../../../services/pagination/pagination.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../../../utils/utils.dart';

class AllVendorsViewModel extends BaseProvider {
  AllVendorsViewModel({required this.screenData}) {
    paginationController = StateNotifierProvider.autoDispose((ref) {
      return PaginationController(
        fetchMoreData: fetchMoreData,
      );
    });
  }

  //**********************************************************
  //  Data Holders
  //**********************************************************

  final AppAllVendorsScreenData screenData;

  /// Hold the search list data
  UnmodifiableListView<Vendor> _vendorsList = UnmodifiableListView(const []);

  UnmodifiableListView<Vendor> get vendorsList => _vendorsList;

  /// Controls the pagination of the screen
  late final AutoDisposeStateNotifierProvider<PaginationController,
      PaginationState> paginationController;

  //**********************************************************
  //  Public Functions
  //**********************************************************

  @override
  void dispose() {
    // Function Log
    Dev.debugFunction(
      functionName: 'dispose',
      className: 'AllVendorsViewModel',
      fileName: 'view_model.dart',
      start: true,
    );

    _vendorsList = UnmodifiableListView(const []);

    /// Set the state to loading for next access
    state = ViewState.LOADING;

    // Function Log
    Dev.debugFunction(
      functionName: 'dispose',
      className: 'AllVendorsViewModel',
      fileName: 'view_model.dart',
      start: false,
    );

    super.dispose();
  }

  /// Fetch the data based on the search term
  Future<void> fetchData() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'fetchData',
      className: 'AllVendorsViewModel',
      fileName: 'view_model.dart',
      start: true,
    );

    try {
      notifyLoading();

      final result = await _getDataFromBackend();

      if (result.isEmpty) {
        notifyState(ViewState.NO_DATA_AVAILABLE);
      } else {
        _vendorsList = UnmodifiableListView([..._vendorsList, ...result]);
        notifyState(ViewState.DATA_AVAILABLE);
      }
    } catch (e) {
      Dev.error('Fetch data AllVendorsViewModel error', error: e);
      if (_vendorsList.isEmpty) {
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
      className: 'AllVendorsViewModel',
      fileName: 'view_model.dart',
      start: true,
    );

    try {
      final result = await _getDataFromBackend(page: page);

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchMoreData',
        className: 'AllVendorsViewModel',
        fileName: 'view_model.dart',
        start: false,
      );

      if (result.isEmpty) {
        return FetchActionResponse.NoDataAvailable;
      } else {
        // If result is not empty then process the data
        if (result.length < ParseEngine.itemsPerPage) {
          // If result is less than the requested length, then
          // this is the last lot of data.
          _vendorsList = UnmodifiableListView([..._vendorsList, ...result]);
          notifyListeners();
          return FetchActionResponse.LastData;
        } else {
          // If result is not empty then process the data
          _vendorsList = UnmodifiableListView([..._vendorsList, ...result]);
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

  Future<List<Vendor>> _getDataFromBackend({int page = 1}) async {
    return await LocatorService.wooService().fetchVendors(
      page: page,
      perPage: ParseEngine.itemsPerPage,
    );
  }
}
