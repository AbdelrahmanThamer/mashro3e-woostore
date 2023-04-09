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

import 'dart:developer';

@Deprecated('Use Utils.formatCardNumber instead')
String formatCardNumber(String value) {
  if (value != null) {
    String result = '';

    for (var i = 0; i < value.length; i++) {
      if (i == 0) {
        result += value[i];
      } else if ((i % 4) == 0) {
        result += ' ' + value[i];
      } else {
        result += value[i];
      }
    }
    return result;
  } else {
    log('No value provided to the function', name: 'Format Card Number');
    return '';
  }
}
