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

import 'package:quiver/strings.dart';

import '../../../../developer/dev.log.dart';
import '../../../../locator.dart';
import '../../../../providers/utils/baseProvider.dart';
import '../../../../services/woocommerce/woocommerce.service.dart';
import '../../../../utils/utils.dart';

class CouponsViewModel extends BaseProvider {
  List<WooCoupon> wooCouponsList = const [];

  /// Fetch the coupons information based on the cart items.
  Future<void> fetchCoupons() async {
    try {
      notifyLoading();

      final _tempResult = <WooCoupon>[];
      int _page = 1;
      bool _fetchMore = true;

      while (_fetchMore) {
        final _result = await LocatorService.wooService().wc.getCoupons(
              perPage: 100,
              page: _page,
            );

        _tempResult.addAll(_result);

        // increase the page count
        _page++;

        if (_result is List && _result.length < 100) {
          _fetchMore = false;
        }
      }

      if (_tempResult == null || _tempResult is! List) {
        notifyError(message: 'Returned data is not correct');
        return;
      }

      if (_tempResult.isEmpty) {
        notifyState(ViewState.NO_DATA_AVAILABLE);
        return;
      }

      wooCouponsList = _tempResult;
      notifyState(ViewState.DATA_AVAILABLE);
    } catch (e, s) {
      Dev.error('Fetch Coupons Error:', error: e, stackTrace: s);
      notifyError(message: Utils.renderException(e));
    }
  }

  /// Set the selected coupon on the cart
  void selectCoupon(WooCoupon coupon) {
    if (coupon == null || isBlank(coupon.code)) {
      Dev.warn('Coupon or Coupon Code is empty');
      return;
    }
    LocatorService.cartViewModel().couponCode = coupon.code;
  }
}
