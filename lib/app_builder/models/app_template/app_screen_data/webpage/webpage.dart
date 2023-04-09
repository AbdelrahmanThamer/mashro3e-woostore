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
class AppWebpageScreenData extends AppScreenData {
  const AppWebpageScreenData({
    required int id,
    String name = 'Webpage',
    this.appBarData = const AppBarData(title: 'Webpage'),
    this.url = '',
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.webpage,
        );

  final AppBarData appBarData;
  final String url;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'appBarData': appBarData.toMap(),
      'url': url,
    };
  }

  factory AppWebpageScreenData.fromMap(Map<String, dynamic> map) {
    return AppWebpageScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      url: ModelUtils.createStringProperty(map['url']),
      appBarData: AppBarData.fromMap(map['appBarData']),
    );
  }

  @override
  AppWebpageScreenData copyWith({
    String? name,
    String? url,
    AppBarData? appBarData,
  }) {
    return AppWebpageScreenData(
      id: id,
      name: name ?? this.name,
      url: url ?? this.url,
      appBarData: appBarData ?? this.appBarData,
    );
  }
}
