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
import 'package:flutter/foundation.dart';

import '../../../models.dart';

@immutable
class AppWishlistScreenData extends AppScreenData {
  const AppWishlistScreenData({
    this.appBarData = const AppBarData(),
    this.productListConfig = const ProductListConfig(),
    int id = AppPrebuiltScreensId.wishlist,
    String name = AppPrebuiltScreensNames.wishlist,
    AppScreenType screenType = AppScreenType.custom,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.wishlist,
          screenType: screenType,
        );

  final AppBarData appBarData;
  final ProductListConfig productListConfig;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'appBarData': appBarData.toMap(),
      'productListConfig': productListConfig.toMap(),
    };
  }

  factory AppWishlistScreenData.fromMap(Map<String, dynamic> map) {
    return AppWishlistScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      screenType: AppScreenData.getScreenType(map['screenType']),
      appBarData: AppBarData.fromMap(map['appBarData']),
      productListConfig: ProductListConfig.fromMap(map['productListConfig']),
    );
  }

  @override
  AppWishlistScreenData copyWith({
    String? name,
    AppBarData? appBarData,
    ProductListConfig? productListConfig,
  }) {
    return AppWishlistScreenData(
      id: id,
      name: name ?? this.name,
      appBarData: appBarData ?? this.appBarData,
      productListConfig: productListConfig ?? this.productListConfig,
      screenType: screenType,
    );
  }
}
