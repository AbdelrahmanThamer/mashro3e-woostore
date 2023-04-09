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

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../app_builder/app_builder.dart';
import '../../../constants/wooConfig.dart';
import '../../../developer/dev.log.dart';
import '../../../enums/enums.dart';
import '../../../models/models.dart';
import '../../../providers/utils/baseProvider.dart';
import '../../../utils/utils.dart';

class BlogsViewModel extends BaseProvider {
  static const String baseUrl =
      '${WooConfig.wordPressUrl}/wp-json/woostore_pro_api';

  /// Initiate the scroll controller
  BlogsViewModel({required this.screenData, this.filter}) {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  final AppBlogScreenData screenData;
  final BlogFilter? filter;

  /// Data holder for all the posts in the home page
  List<WordpressPost> postsList = [];

  /// Get the posts to display on the home screen
  Future<List<WordpressPost>> fetchData() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'fetchData',
      className: 'BlogViewModel',
      start: true,
      fileName: 'view_model.dart',
    );
    try {
      notifyLoading();
      final Response response = await Dio().get(
        '$baseUrl/posts',
        queryParameters: {
          'per_page': perPage,
          if (filter != null) ...filter!.toMap(),
        },
      );

      final List<WordpressPost> tempList = [];
      for (var i = 0; i < response.data.length; ++i) {
        final v = WordpressPost.fromMap(response.data[i]);
        tempList.add(v);
      }
      postsList = tempList;
      Dev.info('Got blog posts data with length: ${postsList.length}');
      notifyState(ViewState.DATA_AVAILABLE);

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchData',
        className: 'BlogViewModel',
        start: false,
        fileName: 'view_model.dart',
      );

      if (tempList.length < perPage) {
        _isFinalDataSet = true;
      }

      return postsList;
    } on DioError catch (e, s) {
      Dev.error('Dio Error fetch posts', error: e, stackTrace: s);
      notifyError(message: '');
      return Future.error(e);
    } catch (e, s) {
      Dev.error('Fetch Posts Error', error: e, stackTrace: s);
      notifyError(message: '');
      return Future.error(Utils.renderException(e));
    }
  }

  Future<void> refresh() async {
    pageNumber = 2;
    _isPerformingRequest = false;
    _isFinalDataSet = false;
    await fetchData();
  }

  //**********************************************************
  // Fetch More Data
  //**********************************************************

  /// ScrollController for fetching more data
  late ScrollController _scrollController;

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

  /// Fetch more posts for the home page
  Future<FetchActionResponse> fetchMorePosts() async {
    Dev.debugFunction(
      functionName: 'fetchMorePosts',
      className: 'BlogViewModel',
      start: true,
      fileName: 'view_model.dart',
    );

    try {
      _notifyMoreDataLoading(true);
      final Response response = await Dio().get(
        '$baseUrl/posts',
        queryParameters: {
          'page': pageNumber,
          'per_page': perPage,
          if (filter != null) ...filter!.toMap(),
        },
      );

      final List _r = response.data;
      if (_r.isEmpty) {
        _notifyMoreDataLoading(false);
        if (postsList.isEmpty) {
          Dev.debugFunction(
            functionName: 'fetchMorePosts',
            className: 'BlogViewModel',
            start: false,
            fileName: 'view_model.dart',
          );
          _isFinalDataSet = true;
          return FetchActionResponse.NoDataAvailable;
        } else {
          Dev.debugFunction(
            functionName: 'fetchMorePosts',
            className: 'BlogViewModel',
            start: false,
            fileName: 'view_model.dart',
          );
          _isFinalDataSet = true;
          return FetchActionResponse.LastData;
        }
      } else {
        _notifyMoreDataLoading(false);
        // add the data to the list
        final List<WordpressPost> tempList = [];
        for (var i = 0; i < _r.length; ++i) {
          final v = WordpressPost.fromMap(_r[i]);
          tempList.add(v);
        }
        Dev.info('Got more list of ${tempList.length}');
        postsList.addAll(tempList);
        // if result is not empty then check if the length of list is less than
        // 10 to check if this was the last amount of data that was available.
        if (_r.length < 10) {
          Dev.debugFunction(
            functionName: 'fetchMorePosts',
            className: 'BlogViewModel',
            start: false,
            fileName: 'view_model.dart',
          );
          _isFinalDataSet = true;
          return FetchActionResponse.LastData;
        } else {
          Dev.debugFunction(
            functionName: 'fetchMorePosts',
            className: 'BlogViewModel',
            start: false,
            fileName: 'view_model.dart',
          );
          pageNumber++;
          return FetchActionResponse.Successful;
        }
      }
    } on DioError catch (e, s) {
      Dev.error('DioError From fetch more posts', error: e, stackTrace: s);
      _notifyMoreDataLoading(false);
      return FetchActionResponse.Failed;
    } catch (e, s) {
      Dev.error('Error From fetch more posts', error: e, stackTrace: s);
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
      final r = await fetchMorePosts();

      if (r == FetchActionResponse.Successful ||
          r == FetchActionResponse.LastData) {
        notifyListeners();
      }
      _isPerformingRequest = false;
    }
  }
}

@immutable
class BlogFilter {
  final List<int>? tags;
  final List<int>? categories;
  final String? search;

  const BlogFilter({
    this.tags,
    this.categories,
    this.search,
  });

  Map<String, dynamic> toMap() {
    return {
      'tags': tags,
      'categories': categories,
      'search': search,
    };
  }
}
