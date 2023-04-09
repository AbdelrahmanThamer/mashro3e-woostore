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

import 'package:flutter/foundation.dart';
import 'package:woocommerce/models/cart_details_payload.dart';
import 'package:woocommerce/models/cart_totals.dart';

import '../../../../../developer/dev.log.dart';
import '../../../../../locator.dart';
import '../../../../../utils/utils.dart';

mixin ReviewDetailsMixin on ChangeNotifier {
  /// The cart details response which shows the totals
  /// for the application.
  WPICartTotals cartTotals = const WPICartTotals();

  Future<WPICartTotals> reviewDetails(
    WPICartDetailsPayload cartDetailsPayload,
  ) async {
    try {
      _onLoading(true);
      final result = await LocatorService.wooService()
          .wc
          .reviewDetailsWithApi(cartDetailsPayload);
      cartTotals = result;
      Dev.info(cartTotals.toMap());
      _onSuccessful();
      return result;
    } catch (e, s) {
      _onError(Utils.renderException(e));
      Dev.error('Review Details Error', error: e, stackTrace: s);
      return const WPICartTotals();
    }
  }

  bool shouldShowFee() {
    return false;
  }

  bool shouldShowTax() {
    return false;
  }

  //**********************************************************
  //  Events
  //**********************************************************

  /// Loading event
  bool _isReviewDetailsLoading = true;

  /// Get the loading value
  bool get isReviewDetailsLoading => _isReviewDetailsLoading;

  /// Success flag to verify if data fetching event was successfully.
  bool _isReviewDetailsSuccess = false;

  /// Get the success value
  bool get isReviewDetailsSuccess => _isReviewDetailsSuccess;

  /// Flag to show if data is available
  bool _hasReviewDetailsData = false;

  /// Getter for the data availability flag
  bool get hasReviewDetailsData => _hasReviewDetailsData;

  /// Error flag for any error while fetching
  bool _isReviewDetailsError = false;

  /// Get the error value
  bool get isReviewDetailsError => _isReviewDetailsError;

  /// Error message
  String _errorReviewDetailsMessage = '';

  /// Get the error message value
  String get errorReviewDetailsMessage => _errorReviewDetailsMessage;

  //**********************************************************
  //  Event Helper Functions
  //**********************************************************

  /// Changes the flags to reflect loading event and notify the listeners.
  void _onLoading(bool value) {
    _isReviewDetailsLoading = value;
    notifyListeners();
  }

  /// Changes the flags to reflect success and notify the listeners.
  void _onSuccessful({bool hasReviewDetailsData = true}) {
    _isReviewDetailsLoading = false;
    _isReviewDetailsSuccess = true;
    _hasReviewDetailsData = hasReviewDetailsData;
    _isReviewDetailsError = false;
    _errorReviewDetailsMessage = '';
    notifyListeners();
  }

  /// Notifies about the error
  void _onError(String message) {
    _isReviewDetailsLoading = false;
    _isReviewDetailsSuccess = false;
    _isReviewDetailsError = true;
    _errorReviewDetailsMessage = message;
    notifyListeners();
  }
}
