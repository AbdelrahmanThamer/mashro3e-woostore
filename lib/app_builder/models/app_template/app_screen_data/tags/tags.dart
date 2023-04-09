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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/material.dart';

import '../../../app_bars/app_bars.dart';
import '../app_screen_data.dart';
import '../shared/styled_data.dart';

enum TagsScreenLayoutType {
  grid,
  list,
  wrap,
}

@immutable
class AppTagsScreenData extends AppScreenData {
  final AppBarData appBarData;
  final TagsScreenLayoutType layout;
  final int columns;
  final StyledData itemStyledData;

  const AppTagsScreenData({
    int id = AppPrebuiltScreensId.tags,
    String name = AppPrebuiltScreensNames.tags,
    this.appBarData = const AppBarData(),
    this.layout = TagsScreenLayoutType.grid,
    this.columns = 2,
    this.itemStyledData = const StyledData(
      dimensionsData: DimensionsData(aspectRatio: 2, height: 50),
      paddingData: PaddingData.all(15),
      marginData: MarginData.all(5),
      borderRadius: 10,
    ),
    AppScreenType screenType = AppScreenType.custom,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.tags,
          screenType: screenType,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'appBarData': appBarData.toMap(),
      'layout': layout.name,
      'columns': columns,
      'itemStyledData': itemStyledData.toMap(),
    };
  }

  factory AppTagsScreenData.fromMap(Map<String, dynamic> map) {
    return AppTagsScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      columns: ModelUtils.createIntProperty(map['columns']),
      appBarData: AppBarData.fromMap(map['appBarData']),
      layout: _getLayout(map['layout']),
      screenType: AppScreenData.getScreenType(map['screenType']),
      itemStyledData: StyledData.fromMap(map['itemStyledData']),
    );
  }

  static TagsScreenLayoutType _getLayout(String? val) {
    switch (val) {
      case 'grid':
        return TagsScreenLayoutType.grid;
      case 'list':
        return TagsScreenLayoutType.list;
      case 'wrap':
        return TagsScreenLayoutType.wrap;
      default:
        return TagsScreenLayoutType.wrap;
    }
  }

  @override
  AppTagsScreenData copyWith({
    AppBarData? appBarData,
    String? name,
    TagsScreenLayoutType? layout,
    int? columns,
    StyledData? itemStyledData,
  }) {
    return AppTagsScreenData(
      id: id,
      appBarData: appBarData ?? this.appBarData,
      name: name ?? this.name,
      columns: columns ?? this.columns,
      layout: layout ?? this.layout,
      itemStyledData: itemStyledData ?? this.itemStyledData,
      screenType: screenType,
    );
  }
}
