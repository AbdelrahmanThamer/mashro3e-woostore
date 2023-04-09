// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:dio/dio.dart';

abstract class ApiUtils {
  static Map<String, dynamic> handleDioError(DioError dioError) {
    Map<String, dynamic> tempMap = {
      'code': 'unknown',
      'message': 'something went wrong -> dio error',
    };

    if (dioError.response != null) {
      if (dioError.response!.data != null) {
        if (dioError.response!.data is Map) {
          tempMap = Map.from(dioError.response!.data).cast<String, dynamic>();
        } else {
          tempMap['message'] = dioError.response!.data;
        }
      } else {
        tempMap['message'] = dioError.message;
      }
    }

    return tempMap;
  }
}
