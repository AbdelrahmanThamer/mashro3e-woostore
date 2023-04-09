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

import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/models/cart_details_payload.dart';
import 'package:woocommerce/models/checkout.dart';
import 'package:woocommerce/models/order.dart';

import '../../../../developer/dev.log.dart';
import '../../../../locator.dart';
import '../../../../models/models.dart';
import '../../viewModel/mixins/public_cart_mixin.dart';
import 'mixins/payment_mixin.dart';
import 'mixins/review_details_mixin.dart';
import 'mixins/shipping_mixin.dart';

class CheckoutNativeViewModel
    with
        ChangeNotifier,
        ReviewDetailsMixin,
        ShippingMethodsMixin,
        PaymentGatewaysMixin,
        PublicCartMixin {
  /// The page controller for the checkout screen
  final PageController _pageController = PageController(initialPage: 0);

  PageController get pageController => _pageController;

  String get checkoutTotalCost {
    try {
      final tempCost = double.tryParse(totalCost);
      final shippingCost = double.tryParse(shippingMethod.cost);
      return (tempCost + shippingCost).toStringAsFixed(2);
    } catch (e, s) {
      Dev.error('Checkout Total Cost error', error: e, stackTrace: s);
      return totalCost;
    }
  }

  //**********************************************************
  // Page Controller Functions
  //**********************************************************

  void next() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  void back() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  String _firstName =
      LocatorService.userProvider().user?.wooCustomer?.firstName ?? '';

  String get firstName => _firstName;
  String _lastName =
      LocatorService.userProvider().user?.wooCustomer?.lastName ?? '';

  String get lastName => _lastName;

  set setFirstName(String value) {
    _firstName = value;
  }

  set setLastName(String value) {
    _lastName = value;
  }

  /// The address for shipping in order
  Address _shippingAddress = const Address.empty();

  Address get shippingAddress => _shippingAddress;

  /// The address for billing in order
  BillingAddress _billingAddress = const BillingAddress.empty();

  BillingAddress get billingAddress => _billingAddress;

  /// Flag to see if the shipping and billing address are same
  bool _sameShippingAndBillingAddress =
      isBlank(LocatorService.userProvider().user.id);

  bool get sameShippingAndBillingAddress => _sameShippingAndBillingAddress;

  void setSameShippingAndBillingAddress(bool value) {
    if (value) {
      _shippingAddress = Address(
        state: _billingAddress.state,
        city: _billingAddress.city,
        country: _billingAddress.country,
        postCode: _billingAddress.postCode,
        company: _billingAddress.company,
        address1: _billingAddress.address1,
        address2: _billingAddress.address2,
      );
    } else {
      _shippingAddress = const Address.empty();
    }
    _sameShippingAndBillingAddress = value;
    notifyListeners();
  }

  /// Create the shipping request method from the shipping method
  WPIShippingMethodRequestPackage createShippingMethodRequestPackage() {
    // Add Billing address
    final Billing billing = Billing.fromJson(billingAddress.toMap());
    billing.firstName = firstName;
    billing.lastName = lastName;

    // Add shipping address
    final Shipping shipping = Shipping.fromJson(shippingAddress.toMap());
    shipping.firstName = firstName;
    shipping.lastName = lastName;

    return WPIShippingMethodRequestPackage(
      lineItems: cartLineItems,
      shipping: shipping,
      billing: billing,
    );
  }

  /// The list of line items for the order
  List<LineItems> orderLineItems = const [];

  /// Add shipping address
  set setShippingAddress(Address address) {
    // Add some address validation
    _shippingAddress = address;
  }

  /// Add billing address
  set setBillingAddress(BillingAddress address) {
    // Add some address validation
    _billingAddress = address;
  }

  /// Returns an updated woocommerce order from the cart items
  Future<bool> deleteOrder(int orderId) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'deleteOrder',
      className: 'CheckoutNativeViewModel',
      fileName: 'checkout_native_view_model.dart',
      start: true,
    );
    try {
      final result =
          await LocatorService.wooService().wc.deleteOrderWithApi(orderId);
      // Function Log
      Dev.debugFunction(
        functionName: 'deleteOrder',
        className: 'CheckoutNativeViewModel',
        fileName: 'checkout_native_view_model.dart',
        start: false,
      );
      return result;
    } catch (e, s) {
      Dev.error('Delete WooOrder error', error: e, stackTrace: s);
      return false;
    }
  }

  /// Place the order on backend and returns the payment URl
  /// to pay for the order.
  Future<WooOrder> placeOrder() async {
    try {
      final result = await LocatorService.wooService()
          .wc
          .createOrderWithApi(createCartDetailsPayload());

      if (result is WooOrder) {
        Dev.info(result.toJson());
        return result;
      }

      return null;
    } catch (_) {
      rethrow;
    }
  }

  //**********************************************************
  // Helper Functions
  //**********************************************************

  WPICartDetailsPayload createCartDetailsPayload() {
    WPICartDetailsPayload cartDetailsPayload = const WPICartDetailsPayload();

    // Create the line items
    cartDetailsPayload = cartDetailsPayload.copyWith(lineItems: cartLineItems);

    // Add the coupon
    if (isNotBlank(selectedCoupon.code)) {
      cartDetailsPayload = cartDetailsPayload.copyWith(
        couponCode: selectedCoupon.code,
      );
    }

    // Add Billing address
    final Billing billing = Billing.fromJson(billingAddress.toMap());
    billing.firstName = firstName;
    billing.lastName = lastName;

    // Add shipping address
    final Shipping shipping = Shipping.fromJson(shippingAddress.toMap());
    shipping.firstName = firstName;
    shipping.lastName = lastName;

    final WPIShippingLine shippingLine = WPIShippingLine(
      instanceId: shippingMethod.instanceId,
      methodId: shippingMethod.methodId,
      methodTitle: shippingMethod.methodTitle,
    );

    cartDetailsPayload = cartDetailsPayload.copyWith(
      customerNote: customerNote,
      customerId: LocatorService.userProvider().user?.id ?? '0',
      shipping: shipping,
      billing: billing,
      lineItems: cartLineItems,
      shippingLine: shippingLine,
    );

    Dev.info(cartDetailsPayload.toJson());

    return cartDetailsPayload;
  }
}
