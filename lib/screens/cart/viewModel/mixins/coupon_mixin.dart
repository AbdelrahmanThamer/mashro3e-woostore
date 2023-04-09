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
import 'package:html_unescape/html_unescape.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../../../controllers/uiController.dart';
import '../../../../developer/dev.log.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../utils/utils.dart';

mixin CouponMixin {
  /// Notifies the loading status of the coupon
  final ValueNotifier<bool> couponLoadingNotifier = ValueNotifier<bool>(false);
  final FocusNode couponFocusNode = FocusNode();
  final TextEditingController couponTextController =
      TextEditingController(text: '');

  /// Coupon to show in the coupon information in the cart tile with a
  /// remove button
  final ValueNotifier<WooCoupon> selectedCoupon =
      ValueNotifier(const WooCoupon(id: 0));

  set couponCode(String value) {
    if (isBlank(value)) {
      couponTextController.text = '';
      return;
    }
    couponTextController.text = value;
  }

  /// Clear the coupon code applied
  void clearCoupon() {
    couponTextController.text = '';
    couponTextController.text = '';
    selectedCoupon.value = const WooCoupon(id: 0);
  }

  /// Use this function to apply a coupon using the text of the controller.
  Future<bool> applyCoupon([BuildContext? context]) async {
    return await verifyCoupon(couponTextController.text, context);
  }

  /// Verify the coupon
  Future<bool> verifyCoupon(String value, [BuildContext? context]) async {
    try {
      if (isBlank(value)) {
        couponLoadingNotifier.value = false;
        _showFailureVerificationNotification(context);
        return false;
      }

      // Add the code to the controller
      couponTextController.text = value;
      // Un-focus the text field
      if (couponFocusNode.hasFocus) {
        couponFocusNode.unfocus();
      }

      couponLoadingNotifier.value = true;

      final WooCoupon? result = await LocatorService.wooService()
          .wc
          .verifyCouponWithApi(
            couponCode: couponTextController.text,
            lineItems: LocatorService.cartViewModel().createOrderWPILineItems(),
            customerId: LocatorService.userProvider().user.wooCustomer?.id ?? 0,
          );

      if (result is WooCoupon) {
        selectedCoupon.value = result;
        couponLoadingNotifier.value = false;
        if (couponFocusNode.hasFocus) {
          couponFocusNode.unfocus();
        }
        return true;
      }

      couponLoadingNotifier.value = false;
      couponTextController.text = '';
      if (couponFocusNode.canRequestFocus) {
        couponFocusNode.requestFocus();
      }
      _showFailureVerificationNotification(context);
      return false;
    } on WooCommerceError catch (e, s) {
      Dev.error('Verify Coupon WooCommerce Error', error: e, stackTrace: s);
      couponLoadingNotifier.value = false;
      couponTextController.text = '';
      _showFailureVerificationNotification(
        context,
        e.message,
      );
      return false;
    } catch (e, s) {
      Dev.error('Verify Coupon', error: e, stackTrace: s);
      couponLoadingNotifier.value = false;
      couponTextController.text = '';
      _showFailureVerificationNotification(context, Utils.renderException(e));
      return false;
    }
  }

  /// Verify the coupon
  Future<bool> verifyCouponFromCouponCard(WooCoupon value,
      [BuildContext? context]) async {
    try {
      if (isBlank(value.code)) {
        couponLoadingNotifier.value = false;
        _showFailureVerificationNotification(context);
        return false;
      }

      // Add the code to the controller
      couponTextController.text = value.code!;
      // Un-focus the text field
      if (couponFocusNode.hasFocus) {
        couponFocusNode.unfocus();
      }

      couponLoadingNotifier.value = true;

      final WooCoupon? result = await LocatorService.wooService()
          .wc
          .verifyCouponWithApi(
            couponCode: couponTextController.text,
            lineItems: LocatorService.cartViewModel().createOrderWPILineItems(),
            customerId: LocatorService.userProvider().user.wooCustomer?.id ?? 0,
          );

      if (result is WooCoupon) {
        selectedCoupon.value = result;
        couponLoadingNotifier.value = false;
        if (couponFocusNode.hasFocus) {
          couponFocusNode.unfocus();
        }
        return true;
      }

      couponLoadingNotifier.value = false;
      if (couponFocusNode.canRequestFocus) {
        couponFocusNode.requestFocus();
      }
      _showFailureVerificationNotification(context);
      return false;
    } on WooCommerceError catch (e, s) {
      Dev.error(
        'Verify Coupon From Coupon Card WooCommerce Error',
        error: e,
        stackTrace: s,
      );
      couponLoadingNotifier.value = false;
      _showFailureVerificationNotification(
        context,
        e.message,
      );
      return false;
    } catch (e, s) {
      Dev.error('Verify Coupon From Coupon Card', error: e, stackTrace: s);
      couponLoadingNotifier.value = false;
      _showFailureVerificationNotification(context, Utils.renderException(e));
      return false;
    }
  }

  /// Verify the coupon
  Future<bool> verifyCouponBeforeCheckout(BuildContext context) async {
    if (isBlank(couponTextController.text)) {
      return Future.value(true);
    }
    try {
      final WooCoupon? result = await LocatorService.wooService()
          .wc
          .verifyCouponWithApi(
            couponCode: couponTextController.text,
            lineItems: LocatorService.cartViewModel().createOrderWPILineItems(),
            customerId: LocatorService.userProvider().user.wooCustomer?.id ?? 0,
          );

      if (result is WooCoupon) {
        return true;
      }

      _showFailureVerificationNotification(context);
      return false;
    } on WooCommerceError catch (e, s) {
      Dev.error('Verify Coupon before checkout WooCommerce Error',
          error: e, stackTrace: s);
      _showFailureVerificationNotification(
        context,
        e.message,
      );
      return false;
    } catch (e, s) {
      Dev.error('Verify Coupon before checkout ', error: e, stackTrace: s);
      _showFailureVerificationNotification(context, Utils.renderException(e));
      return false;
    }
  }

  void _showFailureVerificationNotification(BuildContext? context,
      [String? message]) {
    if (context == null) {
      return;
    }
    final lang = S.of(context);
    UiController.showErrorNotification(
      context: context,
      title: '${lang.invalid} ${lang.coupon}',
      message: isNotBlank(message)
          ? HtmlUnescape().convert(message!)
          : lang.invalidCouponMessage,
    );
  }
}
