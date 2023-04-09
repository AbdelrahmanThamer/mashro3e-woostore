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
import 'package:woocommerce/models/payment_gateway.dart';

import '../../../../../developer/dev.log.dart';
import '../../../../../locator.dart';
import '../../../../../utils/utils.dart';

mixin PaymentGatewaysMixin on ChangeNotifier {
  /// All the payment gateways available in the website
  List<WooPaymentGateway> paymentGateways = const [];

  /// The gateway which is selected by the user to pay for
  /// the order
  WooPaymentGateway _selectedGateway;
  WooPaymentGateway get selectedPaymentGateway => _selectedGateway;

  /// Get all the payment gateways
  Future<void> fetchPaymentGateways() async {
    try {
      _onLoading(true);
      final result = await LocatorService.wooService().wc.getPaymentGateways();
      if (result is! List) {
        _onError('result is not a list');
        return;
      }
      paymentGateways = result;
      _onSuccessful();
    } catch (e, s) {
      Dev.error('Fetch Payment Gateways', error: e, stackTrace: s);
      _onError(Utils.renderException(e));
    }
  }

  void selectPaymentGateway(WooPaymentGateway gateway) {
    _selectedGateway = gateway;
    notifyListeners();
  }

  //**********************************************************
  //  Events
  //**********************************************************

  /// Loading event
  bool _isPaymentInfoLoading = true;

  /// Get the loading value
  bool get isPaymentInfoLoading => _isPaymentInfoLoading;

  /// Success flag to verify if data fetching event was successfully.
  bool _isPaymentInfoSuccess = false;

  /// Get the success value
  bool get isPaymentInfoSuccess => _isPaymentInfoSuccess;

  /// Flag to show if data is available
  bool _hasPaymentInfoData = false;

  /// Getter for the data availability flag
  bool get hasPaymentInfoData => _hasPaymentInfoData;

  /// Error flag for any error while fetching
  bool _isPaymentInfoError = false;

  /// Get the error value
  bool get isPaymentInfoError => _isPaymentInfoError;

  /// Error message
  String _errorPaymentInfoMessage = '';

  /// Get the error message value
  String get errorPaymentInfoMessage => _errorPaymentInfoMessage;

  //**********************************************************
  //  Event Helper Functions
  //**********************************************************

  /// Changes the flags to reflect loading event and notify the listeners.
  void _onLoading(bool value) {
    _isPaymentInfoLoading = value;
    notifyListeners();
  }

  /// Changes the flags to reflect success and notify the listeners.
  void _onSuccessful({bool hasPaymentInfoData = true}) {
    _isPaymentInfoLoading = false;
    _isPaymentInfoSuccess = true;
    _hasPaymentInfoData = hasPaymentInfoData;
    _isPaymentInfoError = false;
    _errorPaymentInfoMessage = '';
    notifyListeners();
  }

  /// Notifies about the error
  void _onError(String message) {
    _isPaymentInfoLoading = false;
    _isPaymentInfoSuccess = false;
    _isPaymentInfoError = true;
    _errorPaymentInfoMessage = message;
    notifyListeners();
  }
}
