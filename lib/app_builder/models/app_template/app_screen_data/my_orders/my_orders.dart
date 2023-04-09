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
class AppMyOrdersScreenData extends AppScreenData {
  const AppMyOrdersScreenData({
    int id = AppPrebuiltScreensId.myOrders,
    String name = AppPrebuiltScreensNames.myOrders,
    this.appBarData = const AppBarData(),
    AppScreenType screenType = AppScreenType.custom,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.myOrders,
          screenType: screenType,
        );

  final AppBarData appBarData;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'appBarData': appBarData.toMap(),
    };
  }

  factory AppMyOrdersScreenData.fromMap(Map<String, dynamic> map) {
    return AppMyOrdersScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      appBarData: AppBarData.fromMap(map['appBarData']),
      screenType: AppScreenData.getScreenType(map['screenType']),
    );
  }

  @override
  AppMyOrdersScreenData copyWith({
    String? name,
    AppBarData? appBarData,
  }) {
    return AppMyOrdersScreenData(
      id: id,
      name: name ?? this.name,
      appBarData: appBarData ?? this.appBarData,
      screenType: screenType,
    );
  }
}
