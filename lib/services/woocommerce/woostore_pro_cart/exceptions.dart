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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:dio/dio.dart';

class WooStoreProCartException implements Exception {
  final String code;
  final String message;

  const WooStoreProCartException({
    this.code = 'code_not_available',
    this.message = 'Message not available',
  });

  factory WooStoreProCartException.fromDioError(DioError e) {
    switch (e.type) {
      case DioErrorType.response:
        return WooStoreProCartException(
          code: e.response?.data != null ? e.response?.data['code'] : 'failure',
          message: e.response?.data != null
              ? e.response?.data['message']
              : 'Something went wrong.',
        );

      case DioErrorType.connectTimeout:
        return const WooStoreProCartException(
          code: 'connect_time_out',
          message:
              'Connection timed out. Please check your internet connection.',
        );

      case DioErrorType.cancel:
        return const WooStoreProCartException(
          code: 'request_cancelled',
          message: 'The request was cancelled',
        );

      case DioErrorType.other:
        return const WooStoreProCartException(
          code: 'no_connection',
          message:
              'Could not connect to the server, please check your internet connection',
        );

      default:
        return const WooStoreProCartException(
          code: 'failure',
          message: 'Something went wrong!',
        );
    }
  }

  factory WooStoreProCartException.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const WooStoreProCartException();
    }
    return WooStoreProCartException(
      code: ModelUtils.createStringProperty(map['code']),
      message: ModelUtils.createStringProperty(map['message']),
    );
  }

  @override
  String toString() {
    return 'WooStoreProCartException\ncode: $code\nmessage: $message';
  }
}

class InvalidCustomerIdException extends WooStoreProCartException {
  const InvalidCustomerIdException()
      : super(
          code: 'invalid_customer_id',
          message: 'The customer id cannot be null or 0',
        );
}

class InvalidProductIdException extends WooStoreProCartException {
  const InvalidProductIdException()
      : super(
          code: 'invalid_product_id',
          message: 'The product id cannot be null or 0',
        );
}

class InvalidQuantityException extends WooStoreProCartException {
  const InvalidQuantityException()
      : super(
          code: 'invalid_quantity_id',
          message: 'The quantity cannot be null or 0',
        );
}

class InvalidCartResponseException extends WooStoreProCartException {
  const InvalidCartResponseException()
      : super(
          code: 'invalid_cart_data',
          message:
              'The response received from cart endpoint is invalid or not the expected type',
        );
}
