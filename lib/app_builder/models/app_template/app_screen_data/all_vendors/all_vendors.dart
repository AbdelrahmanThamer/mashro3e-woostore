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

import '../../../models.dart';

@immutable
class AppAllVendorsScreenData extends AppScreenData {
  final AppBarData appBarData;
  final ItemListConfig itemListConfig;
  final VendorCardLayoutData vendorCardLayoutData;

  const AppAllVendorsScreenData({
    this.appBarData = const AppBarData(),
    this.itemListConfig = const ItemListConfig(
      aspectRatio: 0.7,
      gridColumns: 2,
      listType: ItemListType.grid,
      itemPadding: 10,
    ),
    this.vendorCardLayoutData = const VendorCardLayoutData(),
    int id = AppPrebuiltScreensId.allVendors,
    String name = AppPrebuiltScreensNames.allVendors,
    AppScreenType screenType = AppScreenType.preBuilt,
  }) : super(
          id: id,
          name: name,
          screenType: screenType,
          appScreenLayoutType: AppScreenLayoutType.allVendors,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'appBarData': appBarData.toMap(),
      'itemListConfig': itemListConfig.toMap(),
      'vendorCardLayoutData': vendorCardLayoutData.toMap(),
    };
  }

  factory AppAllVendorsScreenData.fromMap(Map<String, dynamic> map) {
    return AppAllVendorsScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      screenType: AppScreenData.getScreenType(map['screenType']),
      appBarData: AppBarData.fromMap(map['appBarData']),
      itemListConfig: ItemListConfig.fromMap(map['itemListConfig']),
      vendorCardLayoutData:
          VendorCardLayoutData.fromMap(map['vendorCardLayoutData']),
    );
  }

  @override
  AppAllVendorsScreenData copyWith({
    String? name,
    AppBarData? appBarData,
    ItemListConfig? itemListConfig,
    VendorCardLayoutData? vendorCardLayoutData,
  }) {
    return AppAllVendorsScreenData(
      appBarData: appBarData ?? this.appBarData,
      itemListConfig: itemListConfig ?? this.itemListConfig,
      vendorCardLayoutData: vendorCardLayoutData ?? this.vendorCardLayoutData,
    );
  }
}
