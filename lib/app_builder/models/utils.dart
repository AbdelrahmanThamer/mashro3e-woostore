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

import 'package:flutter/material.dart';

abstract class EnumUtils {
  /// Converts a string value to BoxFit enum
  static BoxFit convertStringToBoxFit(String? value) {
    if (value == null) {
      return BoxFit.cover;
    }
    switch (value) {
      case 'fill':
        return BoxFit.fill;

      case 'scaleDown':
        return BoxFit.scaleDown;

      case 'fitWidth':
        return BoxFit.fitWidth;

      case 'fitHeight':
        return BoxFit.fitHeight;

      case 'cover':
        return BoxFit.cover;

      case 'contain':
        return BoxFit.contain;

      default:
        return BoxFit.cover;
    }
  }
}
