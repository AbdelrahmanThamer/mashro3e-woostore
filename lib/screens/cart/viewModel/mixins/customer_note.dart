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

import 'package:quiver/strings.dart';

mixin CustomerNoteMixin {
  String _customerNote = '';

  String get customerNote => _customerNote;

  set customerNote(String value) {
    if (isBlank(value)) {
      _customerNote = '';
      return;
    }
    _customerNote = value;
  }

  /// Clear the coupon code applied
  void clearCustomerNote() {
    _customerNote = '';
  }
}
