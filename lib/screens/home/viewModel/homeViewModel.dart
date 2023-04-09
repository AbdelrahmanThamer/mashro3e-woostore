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

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../constants/wooConfig.dart';
import '../../../developer/dev.log.dart';
import '../../../enums/enums.dart';
import '../../../providers/utils/baseProvider.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../../../utils/utils.dart';
import '../models/customSectionData.dart';
import 'homeSection.viewModel.dart';

/// ## Description
///
/// Manages the display state of the home page taking the instructions from
/// backend endpoint for product sections
class HomeViewModel extends BaseProvider {
  /// Initiate the scroll controller
  HomeViewModel() {
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  /// String key should be [WooProductTag.id] and must be unique for each entry
  /// in the map
  final Map<int, HomeSectionViewModel> _homeSectionsMap = {};

  /// Getter for tags and data map
  Map<int, HomeSectionViewModel> get homeSectionsMap => _homeSectionsMap;

  /// Add tag data and creates and add [HomeSectionViewModel] to the map, if
  /// not already present, for later use.
  void addHomeSectionToMap(HomeSectionDataHolder data) {
    if (!_homeSectionsMap.containsKey(data.id)) {
      final dataHolder = HomeSectionViewModel(dataHolder: data);
      _homeSectionsMap.addAll({data.id: dataHolder});
    }
  }

  //**********************************************************
  // Home Sections
  //**********************************************************

  /// Data holder for all the sections in the home page
  List<CustomSectionData> sectionsList = [];

  /// Get the sections to display on the home screen
  Future<List<CustomSectionData>> fetchSections() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'fetchSections',
      className: 'HomeViewModel',
      start: true,
      fileName: 'homeViewModel.dart',
    );
    try {
      notifyLoading();
      final Response response = await Dio().get(
        '${WooConfig.wordPressUrl}/wp-json/wp/v2/section',
        queryParameters: {
          'per_page': perPage,
        },
      );

      final List<CustomSectionData> tempList = [];
      for (var i = 0; i < response.data.length; ++i) {
        final v = CustomSectionData.fromMap(response.data[i]);
        tempList.add(v);
      }
      sectionsList = tempList;
      Dev.info('Got home sections data with length: ${sectionsList.length}');
      notifyState(ViewState.DATA_AVAILABLE);

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchSections',
        className: 'HomeViewModel',
        start: false,
        fileName: 'homeViewModel.dart',
      );

      if (tempList.length < perPage) {
        _isFinalDataSet = true;
      }

      return sectionsList;
    } on DioError catch (e, s) {
      Dev.error('Dio Error fetch sections', error: e, stackTrace: s);
      notifyError(message: '');
      return Future.error(e);
    } catch (e, s) {
      Dev.error('Fetch Sections Error', error: e, stackTrace: s);
      notifyError(message: '');
      return Future.error(Utils.renderException(e));
    }
  }

  Future<void> refresh() async {
    pageNumber = 2;
    _isPerformingRequest = false;
    _isFinalDataSet = false;
    await fetchSections();
  }

  //**********************************************************
  // Fetch More Data
  //**********************************************************

  /// ScrollController for fetching more data
  ScrollController _scrollController;

  ScrollController get scrollController => _scrollController;

  /// Flag to prevent concurrent requests
  bool _isPerformingRequest = false;
  bool _isFinalDataSet = false;
  int pageNumber = 2;
  int perPage = 10;

  /// More data loading indicator
  bool _moreDataLoading = false;

  bool get moreDataLoading => _moreDataLoading;

  void _notifyMoreDataLoading(bool value) {
    _moreDataLoading = value;
    notifyListeners();
  }

  /// Fetch more sections for the home page
  Future<FetchActionResponse> fetchMoreSections() async {
    Dev.debugFunction(
      functionName: 'fetchMoreSections',
      className: 'HomeViewModel',
      start: true,
      fileName: 'homeViewModel',
    );

    try {
      _notifyMoreDataLoading(true);
      final Response response = await Dio().get(
        '${WooConfig.wordPressUrl}/wp-json/wp/v2/section',
        queryParameters: {
          'page': pageNumber,
          'per_page': perPage,
        },
      );

      final List _r = response.data;
      if (_r.isEmpty) {
        _notifyMoreDataLoading(false);
        if (sectionsList.isEmpty) {
          Dev.debugFunction(
            functionName: 'fetchMoreSections',
            className: 'HomeViewModel',
            start: false,
            fileName: 'homeViewModel',
          );
          _isFinalDataSet = true;
          return FetchActionResponse.NoDataAvailable;
        } else {
          Dev.debugFunction(
            functionName: 'fetchMoreSections',
            className: 'HomeViewModel',
            start: false,
            fileName: 'homeViewModel',
          );
          _isFinalDataSet = true;
          return FetchActionResponse.LastData;
        }
      } else {
        _notifyMoreDataLoading(false);
        // add the data to the list
        final List<CustomSectionData> tempList = [];
        for (var i = 0; i < _r.length; ++i) {
          final v = CustomSectionData.fromMap(_r[i]);
          tempList.add(v);
        }
        Dev.info('Got more list of ${tempList.length}');
        sectionsList.addAll(tempList);
        // if result is not empty then check if the length of list is less than
        // 10 to check if this was the last amount of data that was available.
        if (_r.length < 10) {
          Dev.debugFunction(
            functionName: 'fetchMoreSections',
            className: 'HomeViewModel',
            start: false,
            fileName: 'homeViewModel',
          );
          _isFinalDataSet = true;
          return FetchActionResponse.LastData;
        } else {
          Dev.debugFunction(
            functionName: 'fetchMoreSections',
            className: 'HomeViewModel',
            start: false,
            fileName: 'homeViewModel',
          );
          pageNumber++;
          return FetchActionResponse.Successful;
        }
      }
    } on DioError catch (e, s) {
      Dev.error('DioError From fetch more sections', error: e, stackTrace: s);
      _notifyMoreDataLoading(false);
      return FetchActionResponse.Failed;
    } catch (e, s) {
      Dev.error('Error From fetch more sections', error: e, stackTrace: s);
      _notifyMoreDataLoading(false);
      return FetchActionResponse.Failed;
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _getMoreData();
    }
  }

  Future<void> _getMoreData() async {
    if (_isFinalDataSet) {
      Dev.debug('Final data set, returning');
      return;
    }
    if (!_isPerformingRequest) {
      _isPerformingRequest = true;
      final r = await fetchMoreSections();

      if (r == FetchActionResponse.Successful ||
          r == FetchActionResponse.LastData) {
        notifyListeners();
      }
      _isPerformingRequest = false;
    }
  }
}
