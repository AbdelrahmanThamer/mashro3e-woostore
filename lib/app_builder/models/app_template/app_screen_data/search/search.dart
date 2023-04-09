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

import '../app_screen_data.dart';

@immutable
class AppSearchScreenData extends AppScreenData {
  const AppSearchScreenData({
    int id = AppPrebuiltScreensId.search,
    String name = AppPrebuiltScreensNames.search,
    AppScreenType screenType = AppScreenType.custom,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.search,
          screenType: screenType,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
    };
  }

  factory AppSearchScreenData.fromMap(Map<String, dynamic> map) {
    return AppSearchScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      screenType: AppScreenData.getScreenType(map['screenType']),
    );
  }

  @override
  AppSearchScreenData copyWith({String? name}) {
    return AppSearchScreenData(
      id: id,
      name: name ?? this.name,
      screenType: screenType,
    );
  }
}
