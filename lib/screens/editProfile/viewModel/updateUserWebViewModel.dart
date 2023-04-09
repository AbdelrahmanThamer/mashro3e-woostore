// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../developer/dev.log.dart';
import '../../../locator.dart';

class UpdateUserWebViewModel with ChangeNotifier {
  static const String simpleJwtLoginRouteNameSpace =
      '/simple-jwt-login/v1/autologin';

  //**********************************************************
  //  Data Holders
  //**********************************************************

  /// A controller for the web view in which all the actions will
  /// be performed.
  Completer<WebViewController> controller;

  /// The value of the actual endpoint
  ///
  /// The url should contain the `Simple JWT Login` wordpress plugin
  /// which has the route name like below:
  /// `?rest_route=/simple-jwt-login/v1/autologin&redirectUrl=`
  ///
  /// The path after `rest_route` param must match the route namespace
  /// provided in the plugin setting.
  ///
  /// `redirectUrl` param redirects the user to the url specified
  /// after authenticating the user.
  ///
  /// DO NOT CHANGE UNTIL YOU ARE SURE OF WHAT YOU ARE DOING.
  /// BREAKING THIS WILL BREAK THE CHECKOUT FLOW OF THE APPLICATION.
  String url;

  /// Flag to check if the checkout is successful.
  bool isSuccessful = false;

  /// The endpoint to which the user must be redirected to after the
  /// auth is complete
  final String redirectUrlEndpoint;

  /// Function to call when the URL matches the [pattern] provided
  final Function successFunction;

  /// Pattern to check for each URL to perform the [successFunction].
  final RegExp pattern;

  /// Widget to show on success
  final Widget successWidget;

  /// Widget to show on failure
  final Widget failureWidget;

  UpdateUserWebViewModel({
    @required this.redirectUrlEndpoint,
    @required this.pattern,
    this.successFunction,
    this.successWidget,
    this.failureWidget,
  }) {
    _init();
  }

  /// Initialize the model instance
  Future<void> _init() async {
    // Function Log
    Dev.debugFunction(
      functionName: '_init',
      className: 'UpdateUserWebViewModel',
      fileName: 'updateUserWebViewModel.dart',
      start: true,
    );

    // Set the url value
    final _baseUrl = LocatorService.wooService().wc.baseUrl;
    url =
        '$_baseUrl?rest_route=$simpleJwtLoginRouteNameSpace&redirectUrl=$_baseUrl/$redirectUrlEndpoint';

    // Create the controller
    controller = Completer<WebViewController>();

    _onSuccessful();

    // Function Log
    Dev.debugFunction(
      functionName: '_init',
      className: 'UpdateUserWebViewModel',
      fileName: 'updateUserWebViewModel.dart',
      start: false,
    );
  }

  @override
  void dispose() {
    // Function Log
    Dev.debugFunction(
      functionName: 'dispose',
      className: 'UpdateUserWebViewModel',
      fileName: 'updateUserWebViewModel.dart',
      start: true,
    );

    url = null;
    controller = null;
    isSuccessful = null;
    super.dispose();

    // Function Log
    Dev.debugFunction(
      functionName: 'dispose',
      className: 'UpdateUserWebViewModel',
      fileName: 'updateUserWebViewModel.dart',
      start: false,
    );
  }

  void updateLoading(bool value) {
    _onLoading(value);
  }

  void updateError(String message) {
    _onError(message);
  }

  /// Check if the order is complete based on the URL of the
  /// web view
  Future<void> checkStatus(String url) async {
    if (pattern != null && pattern.hasMatch(url)) {
      // The order was successful, hence navigate to successful page.
      isSuccessful = true;
      notifyListeners();

      // Get the refreshed user info
      if (successFunction != null) {
        await successFunction();
      }
    }

    // Required to call to update the loading status.
    _onLoading(false);
  }

  //**********************************************************
  //  Events
  //**********************************************************

  /// Loading event
  bool _isLoading = true;

  /// Get the loading value
  bool get isLoading => _isLoading;

  /// Success flag to verify if data fetching event was successfully.
  bool _isSuccess = false;

  /// Get the success value
  bool get isSuccess => _isSuccess;

  /// Flag to show if data is available
  bool _hasData = true;

  /// Getter for the data availability flag
  bool get hasData => _hasData;

  /// Error flag for any error while fetching
  bool _isError = false;

  /// Get the error value
  bool get isError => _isError;

  /// Error message
  String _errorMessage = '';

  /// Get the error message value
  String get errorMessage => _errorMessage;

  //**********************************************************
  //  Event Helper Functions
  //**********************************************************

  /// Changes the flags to reflect loading event and notify the listeners.
  void _onLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Changes the flags to reflect success and notify the listeners.
  void _onSuccessful({bool hasData = true}) {
    _isLoading = false;
    _isSuccess = true;
    _hasData = hasData;
    _isError = false;
    _errorMessage = '';
    notifyListeners();
  }

  /// Notifies about the error
  void _onError(String message) {
    _isLoading = false;
    _isSuccess = false;
    _isError = true;
    _errorMessage = message;
    notifyListeners();
  }
}
