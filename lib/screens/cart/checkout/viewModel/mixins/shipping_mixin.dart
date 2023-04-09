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

import 'package:flutter/material.dart';

import '../../../../../developer/dev.log.dart';
import '../../../../../locator.dart';
import '../../../../../services/woocommerce/woocommerce.service.dart';
import '../../../../../utils/utils.dart';

mixin ShippingMethodsMixin on ChangeNotifier {
  /// All the payment gateways available in the website
  List<WPIShippingMethod> shippingMethods = const [];

  /// The gateway which is selected by the user to pay for
  /// the order
  WPIShippingMethod shippingMethod = const WPIShippingMethod.empty();

  /// Get all the payment gateways
  Future<void> fetchShippingMethods(
    WPIShippingMethodRequestPackage package,
  ) async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'fetchShippingMethods',
        className: 'ShippingMethodsMixin',
        fileName: 'shipping_mixin.dart',
        start: true,
      );
      shippingMethods = const [];
      shippingMethod = const WPIShippingMethod.empty();
      _onLoading(true);
      final result = await LocatorService.wooService()
          .wc
          .getShippingMethodsFromApi(package);
      if (result is! List) {
        _onError('result is not a list');
        return;
      }
      shippingMethods = result;

      _onSuccessful();
      // Function Log
      Dev.debugFunction(
        functionName: 'fetchShippingMethods',
        className: 'ShippingMethodsMixin',
        fileName: 'shipping_mixin.dart',
        start: false,
      );
    } catch (e, s) {
      Dev.error('Fetch Shipping Gateways', error: e, stackTrace: s);
      _onError(Utils.renderException(e));
    }
  }

  /// Set the shipping method for the checkout
  void setShippingMethod(WPIShippingMethod method) {
    shippingMethod = method;
    notifyListeners();
  }

  //**********************************************************
  // Events
  //**********************************************************

  /// Loading event
  bool _isShippingInfoLoading = true;

  /// Get the loading value
  bool get isShippingInfoLoading => _isShippingInfoLoading;

  /// Success flag to verify if data fetching event was successfully.
  bool _isShippingInfoSuccess = false;

  /// Get the success value
  bool get isShippingInfoSuccess => _isShippingInfoSuccess;

  /// Error flag for any error while fetching
  bool _isShippingInfoError = false;

  /// Get the error value
  bool get isShippingInfoError => _isShippingInfoError;

  /// Error message
  String _errorShippingInfoMessage = '';

  /// Get the error message value
  String get errorShippingInfoMessage => _errorShippingInfoMessage;

  //**********************************************************
  //  Event Helper Functions
  //**********************************************************

  /// Changes the flags to reflect loading event and notify the listeners.
  void _onLoading(bool value) {
    _isShippingInfoLoading = value;
    notifyListeners();
  }

  /// Changes the flags to reflect success and notify the listeners.
  void _onSuccessful() {
    _isShippingInfoLoading = false;
    _isShippingInfoSuccess = true;
    _isShippingInfoError = false;
    _errorShippingInfoMessage = '';
    notifyListeners();
  }

  /// Notifies about the error
  void _onError(String message) {
    _isShippingInfoLoading = false;
    _isShippingInfoSuccess = false;
    _isShippingInfoError = true;
    _errorShippingInfoMessage = message;
    notifyListeners();
  }
}
