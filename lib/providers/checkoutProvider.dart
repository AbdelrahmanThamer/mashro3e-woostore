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

import 'package:flutter/foundation.dart';

import '../models/address.model.dart';

class CheckoutProvider with ChangeNotifier {
  static const double FREE_AMOUNT = 0.0;
  static const double FLAT_AMOUNT = 20.0;
  static const double LOCAL_PICKUP_AMOUNT = 10.0;
  static const double ONE_DAY_AMOUNT = 40.0;

  /// This 'MUST' not change
  double _totalAmountBeforeShipping = 0.0;

  double _totalAmount = 0.0;
  Address _shippingAddress;
  PaymentType _paymentType;
  ShippingOptionsType _shippingOption;

  /// Only for review screen
  double _shippingAmount = FREE_AMOUNT;

  double get totalAmount => _totalAmount;
  Address get shippingAddress => _shippingAddress;
  PaymentType get paymentType => _paymentType;
  ShippingOptionsType get shippingOption => _shippingOption;
  double get shippingAmount => _shippingAmount;

  set setTotalAmount(double amount) {
    _totalAmount = amount;
    _totalAmountBeforeShipping = amount;
  }

  set setAddress(Address address) {
    _shippingAddress = address;
  }

  set setPaymentType(PaymentType type) {
    _paymentType = type;
  }

  set setShippingOption(ShippingOptionsType type) {
    _shippingOption = type;

    _updateTotalAmount(type);
  }

  // Updates the total amount based on the shipping option chosen.
  // Also updates the shipping amount.
  void _updateTotalAmount(ShippingOptionsType type) {
    switch (type) {
      case ShippingOptionsType.FREE:
        _totalAmount = _totalAmountBeforeShipping;
        _shippingAmount = FREE_AMOUNT;
        break;

      case ShippingOptionsType.FLAT_RATE:
        _totalAmount = _totalAmountBeforeShipping + FLAT_AMOUNT;
        _shippingAmount = FLAT_AMOUNT;
        break;

      case ShippingOptionsType.LOCAL_PICKUP:
        _totalAmount = _totalAmountBeforeShipping + LOCAL_PICKUP_AMOUNT;
        _shippingAmount = LOCAL_PICKUP_AMOUNT;
        break;

      case ShippingOptionsType.ONE_DAY_FAST:
        _totalAmount = _totalAmountBeforeShipping + ONE_DAY_AMOUNT;
        _shippingAmount = ONE_DAY_AMOUNT;
        break;

      default:
        break;
    }
  }
}

enum PaymentType {
  PAYPAL,
  COD,
  CARD,
  APPLE_PAY,
  GOOGLE_PAY,
  RAZOR_PAY,
}

enum ShippingOptionsType {
  FREE,
  FLAT_RATE,
  LOCAL_PICKUP,
  ONE_DAY_FAST,
}
