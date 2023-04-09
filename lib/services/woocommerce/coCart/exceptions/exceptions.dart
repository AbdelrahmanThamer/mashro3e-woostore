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

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// The CoCart Exception
@immutable
class CoCartException implements Exception {
  final int code;
  final String status;
  final String message;

  const CoCartException({
    this.code = 0,
    this.status = '',
    this.message = '',
  });

  factory CoCartException.fromDioError(DioError e) {
    switch (e.type) {
      case DioErrorType.response:
        return CoCartException(
          code: e.response.statusCode,
          status: e.response.data != null ? e.response.data['code'] : 'failure',
          message: e.response.data != null
              ? e.response.data['message']
              : 'Something went wrong.',
        );
        break;
      case DioErrorType.connectTimeout:
        return const CoCartException(
          code: 00,
          status: 'connect_time_out',
          message:
              'Connection timed out. Please check your internet connection.',
        );
        break;
      case DioErrorType.cancel:
        return const CoCartException(
          code: 00,
          status: 'request_cancelled',
          message: 'The request was cancelled',
        );
        break;
      case DioErrorType.other:
        return const CoCartException(
          code: 00,
          status: 'no_connection',
          message:
              'Could not connect to the server, please check your internet connection',
        );
        break;
      default:
        return const CoCartException(
          code: 00,
          status: 'failure',
          message: 'Something went wrong!',
        );
    }
  }

  factory CoCartException.fromMap(Map<String, dynamic> map) {
    return CoCartException(
      code: map['code'] as int,
      status: map['status'] as String,
      message: map['message'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'code': code,
      'status': status,
      'message': message,
    } as Map<String, dynamic>;
  }

  @override
  String toString() {
    return 'CoCartException{code: $code, status: $status, message: $message}';
  }
}

@immutable
class CoCartNullArgumentsException extends CoCartException {
  const CoCartNullArgumentsException([String error])
      : super(message: error ?? 'CoCart: Arguments cannot be null');
}

@immutable
class CoCartNullResponseException extends CoCartException {
  const CoCartNullResponseException([String error])
      : super(message: error ?? 'CoCart: Response returned is null');
}
