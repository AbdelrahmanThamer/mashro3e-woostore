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
import '../../../models.dart';

@immutable
class AppAllProductsScreenData extends AppScreenData {
  final AppBarData appBarData;
  final ProductListConfig productListConfig;

  const AppAllProductsScreenData({
    this.appBarData = const _DefaultAppbarData(),
    this.productListConfig = const ProductListConfig(
      useGlobalProductCardLayout: false,
      layoutData: ProductCardLayoutData(height: 340),
    ),
    int id = AppPrebuiltScreensId.allProducts,
    String name = AppPrebuiltScreensNames.allProducts,
    AppScreenType screenType = AppScreenType.preBuilt,
  }) : super(
          id: id,
          name: name,
          screenType: screenType,
          appScreenLayoutType: AppScreenLayoutType.allProducts,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'appBarData': appBarData.toMap(),
      'productListConfig': productListConfig.toMap(),
    };
  }

  factory AppAllProductsScreenData.fromMap(Map<String, dynamic> map) {
    return AppAllProductsScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      screenType: AppScreenData.getScreenType(map['screenType']),
      appBarData: AppBarData.fromMap(map['appBarData']),
      productListConfig: ProductListConfig.fromMap(map['productListConfig']),
    );
  }

  @override
  AppAllProductsScreenData copyWith({
    String? name,
    AppBarData? appBarData,
    ProductListConfig? productListConfig,
  }) {
    return AppAllProductsScreenData(
      appBarData: appBarData ?? this.appBarData,
      productListConfig: productListConfig ?? this.productListConfig,
    );
  }
}

class _DefaultAppbarData extends AppBarData {
  const _DefaultAppbarData()
      : super(
          actionButtons: const [
            AppBarActionButtonData(
              id: 1,
              tooltip: 'Sort',
              iconData: Icons.filter_list,
              action: AppAction(type: AppActionType.sortBottomSheet),
              allowDelete: false,
              allowChangeAction: false,
            ),
            AppBarActionButtonData(
              id: 2,
              tooltip: 'Filters',
              iconData: EvaIcons.optionsOutline,
              action: AppAction(type: AppActionType.filterModal),
              allowDelete: false,
              allowChangeAction: false,
            ),
          ],
        );
}
