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
import 'package:flutter/material.dart';

import '../../../../actions/actions.dart';
import '../../../app_bars/app_bars.dart';
import '../app_screen_data.dart';

enum CartCouponLayout {
  original,
  textField,
}

@immutable
class AppCartScreenData extends AppScreenData {
  const AppCartScreenData({
    int id = AppPrebuiltScreensId.cart,
    String name = AppPrebuiltScreensNames.cart,
    this.appBarData = const AppBarData(
      actionButtons: [
        AppBarActionButtonData(
          id: 1,
          iconData: Icons.refresh_rounded,
          tooltip: 'Reload',
          action: AppAction(type: AppActionType.cartReload),
          allowDelete: false,
          allowChangeAction: false,
        ),
      ],
    ),
    this.enableNativeCheckout = true,
    this.enableCoupon = true,
    this.enableCustomerNote = true,
    this.couponData = const CartCouponData(),
    AppScreenType screenType = AppScreenType.custom,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.cart,
          screenType: screenType,
        );

  final AppBarData appBarData;
  final bool enableNativeCheckout;
  final bool enableCoupon;
  final CartCouponData couponData;
  final bool enableCustomerNote;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'appBarData': appBarData.toMap(),
      'enableNativeCheckout': enableNativeCheckout,
      'enableCoupon': enableCoupon,
      'enableCustomerNote': enableCustomerNote,
      'couponData': couponData.toMap(),
    };
  }

  factory AppCartScreenData.fromMap(Map<String, dynamic> map) {
    return AppCartScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      enableNativeCheckout:
          ModelUtils.createBoolProperty(map['enableNativeCheckout']),
      enableCoupon: ModelUtils.createBoolProperty(map['enableCoupon']),
      enableCustomerNote:
          ModelUtils.createBoolProperty(map['enableCustomerNote']),
      couponData: CartCouponData.fromMap(map['couponData']),
      appBarData: AppBarData.fromMap(map['appBarData']),
      screenType: AppScreenData.getScreenType(map['screenType']),
    );
  }

  @override
  AppCartScreenData copyWith({
    AppBarData? appBarData,
    String? name,
    bool? enableNativeCheckout,
    bool? enableCoupon,
    CartCouponData? couponData,
    bool? enableCustomerNote,
  }) {
    return AppCartScreenData(
      id: id,
      name: name ?? this.name,
      appBarData: appBarData ?? this.appBarData,
      enableNativeCheckout: enableNativeCheckout ?? this.enableNativeCheckout,
      enableCoupon: enableCoupon ?? this.enableCoupon,
      enableCustomerNote: enableCustomerNote ?? this.enableCustomerNote,
      couponData: couponData ?? this.couponData,
      screenType: screenType,
    );
  }
}

@immutable
class CartCouponData {
  final CartCouponLayout layout;
  final bool showUsageLimit;
  final bool showUsageCount;
  final bool showCouponType;
  final bool showMinimumSpend;
  final bool showMaximumSpend;

  const CartCouponData({
    this.layout = CartCouponLayout.original,
    this.showUsageLimit = true,
    this.showUsageCount = true,
    this.showCouponType = true,
    this.showMinimumSpend = true,
    this.showMaximumSpend = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'layout': layout.name,
      'showUsageLimit': showUsageLimit,
      'showUsageCount': showUsageCount,
      'showCouponType': showCouponType,
      'showMinimumSpend': showMinimumSpend,
      'showMaximumSpend': showMaximumSpend,
    };
  }

  factory CartCouponData.fromMap(Map<String, dynamic> map) {
    return CartCouponData(
      layout: _getLayout(map['layout']),
      showUsageLimit: ModelUtils.createBoolProperty(map['showUsageLimit']),
      showUsageCount: ModelUtils.createBoolProperty(map['showUsageCount']),
      showCouponType: ModelUtils.createBoolProperty(map['showCouponType']),
      showMinimumSpend: ModelUtils.createBoolProperty(map['showMinimumSpend']),
      showMaximumSpend: ModelUtils.createBoolProperty(map['showMaximumSpend']),
    );
  }

  static CartCouponLayout _getLayout(String? val) {
    switch (val) {
      case 'original':
        return CartCouponLayout.original;

      case 'textField':
        return CartCouponLayout.textField;

      default:
        return CartCouponLayout.original;
    }
  }

  CartCouponData copyWith({
    CartCouponLayout? layout,
    bool? showUsageLimit,
    bool? showUsageCount,
    bool? showCouponType,
    bool? showMinimumSpend,
    bool? showMaximumSpend,
  }) {
    return CartCouponData(
      layout: layout ?? this.layout,
      showUsageLimit: showUsageLimit ?? this.showUsageLimit,
      showUsageCount: showUsageCount ?? this.showUsageCount,
      showCouponType: showCouponType ?? this.showCouponType,
      showMinimumSpend: showMinimumSpend ?? this.showMinimumSpend,
      showMaximumSpend: showMaximumSpend ?? this.showMaximumSpend,
    );
  }
}
