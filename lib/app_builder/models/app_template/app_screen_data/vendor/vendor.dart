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
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../actions/actions.dart';
import '../../../app_bars/app_bars.dart';
import '../app_screen_data.dart';

@immutable
class AppVendorScreenData extends AppScreenData {
  const AppVendorScreenData({
    this.appBarData = const _DefaultVendorAppBarData(),
    this.productListConfig = const ProductListConfig(),
    int id = AppPrebuiltScreensId.vendor,
    String name = AppPrebuiltScreensNames.vendor,
    AppScreenType screenType = AppScreenType.preBuilt,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.vendor,
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

  factory AppVendorScreenData.fromMap(Map<String, dynamic> map) {
    return AppVendorScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      screenType: AppScreenData.getScreenType(map['screenType']),
      appBarData: AppBarData.fromMap(map['appBarData']),
      productListConfig: ProductListConfig.fromMap(map['productListConfig']),
    );
  }

  @override
  AppVendorScreenData copyWith({
    String? name,
    AppBarData? appBarData,
    ProductListConfig? productListConfig,
  }) {
    return AppVendorScreenData(
      id: id,
      name: name ?? this.name,
      appBarData: appBarData ?? this.appBarData,
      productListConfig: productListConfig ?? this.productListConfig,
      screenType: screenType,
    );
  }
}

class _DefaultVendorAppBarData extends AppBarData {
  const _DefaultVendorAppBarData()
      : super(
          actionButtons: const [
            AppBarActionButtonData(
              id: 1,
              tooltip: 'Filters',
              iconData: EvaIcons.optionsOutline,
              action: AppAction(type: AppActionType.filterModal),
              allowDelete: false,
              allowChangeAction: false,
            ),
            AppBarActionButtonData(
              id: 2,
              tooltip: 'Sort',
              iconData: Icons.filter_list,
              action: AppAction(type: AppActionType.sortBottomSheet),
              allowDelete: false,
              allowChangeAction: false,
            ),
            AppBarActionButtonData(
              id: 3,
              tooltip: 'Info',
              iconData: Icons.info_outline_rounded,
              action: AppAction(type: AppActionType.vendorInfo),
              allowDelete: false,
              allowChangeAction: false,
            ),
          ],
        );
}
