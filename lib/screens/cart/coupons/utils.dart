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

import 'package:intl/intl.dart';
import 'package:quiver/strings.dart';

import '../../../developer/dev.log.dart';
import '../../../services/woocommerce/woocommerce.service.dart';

abstract class CouponUtils {
  static String createDateTimeString(String valueToConvert) {
    if (isBlank(valueToConvert)) {
      return '';
    }

    try {
      final DateTime time = DateTime.tryParse(valueToConvert);
      return DateFormat.yMd().add_jm().format(time).toString();
    } catch (e, s) {
      Dev.error('Error creating date time', error: e, stackTrace: s);
      return valueToConvert;
    }
  }

  static bool isExpired(String expireDate) {
    if (isBlank(expireDate)) {
      return true;
    }

    try {
      final DateTime expiration = DateTime.tryParse(expireDate);
      final DateTime now = DateTime.now();

      if (expiration == null ||
          expiration is! DateTime ||
          expiration.isBefore(now)) {
        return true;
      }

      return false;
    } catch (e, s) {
      Dev.error('Error checking expired status', error: e, stackTrace: s);
      return true;
    }
  }

  /// Check if the coupon can be used or applied
  static bool canBeUsed(WooCoupon coupon) {
    if (coupon == null) {
      return false;
    }

    try {
      // Check if it is expired
      if (isExpired(coupon.dateExpires)) {
        return false;
      }

      if (coupon.usageLimit != 0 && coupon.usageCount >= coupon.usageLimit) {
        Dev.warn('Coupon ${coupon.code} is out of usage limit');
        return false;
      }

      return true;
    } catch (e, s) {
      Dev.error('Coupon canBeUsed status', error: e, stackTrace: s);
      return false;
    }
  }
}
