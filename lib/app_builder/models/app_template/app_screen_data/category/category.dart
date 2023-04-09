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

enum CategoriesScreenLayoutType {
  grid,
  list,
  listChildCategoriesVisible,
}

@immutable
class AppCategoryScreenData extends AppScreenData {
  final AppBarData appBarData;
  final CategoriesScreenLayoutType layout;
  final int columns;
  final StyledData itemStyledData;
  final bool hideItemImage;

  const AppCategoryScreenData({
    int id = AppPrebuiltScreensId.category,
    String name = AppPrebuiltScreensNames.category,
    this.appBarData = const AppBarData(),
    this.layout = CategoriesScreenLayoutType.grid,
    this.columns = 3,
    this.itemStyledData = const StyledData(
      dimensionsData: DimensionsData(aspectRatio: 0.8),
      paddingData: PaddingData.all(5),
      marginData: MarginData.all(5),
      borderRadius: 10,
    ),
    this.hideItemImage = false,
    AppScreenType screenType = AppScreenType.custom,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.category,
          screenType: screenType,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'appBarData': appBarData.toMap(),
      'layout': layout.name,
      'columns': columns,
      'hideItemImage': hideItemImage,
      'itemStyledData': itemStyledData.toMap(),
    };
  }

  factory AppCategoryScreenData.fromMap(Map<String, dynamic> map) {
    return AppCategoryScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      columns: ModelUtils.createIntProperty(map['columns']),
      appBarData: AppBarData.fromMap(map['appBarData']),
      layout: _getLayout(map['layout']),
      screenType: AppScreenData.getScreenType(map['screenType']),
      itemStyledData: StyledData.fromMap(map['itemStyledData']),
      hideItemImage: ModelUtils.createBoolProperty(map['hideItemImage']),
    );
  }

  static CategoriesScreenLayoutType _getLayout(String? val) {
    switch (val) {
      case 'grid':
        return CategoriesScreenLayoutType.grid;
      case 'list':
        return CategoriesScreenLayoutType.list;
      case 'listChildCategoriesVisible':
        return CategoriesScreenLayoutType.listChildCategoriesVisible;
      default:
        return CategoriesScreenLayoutType.grid;
    }
  }

  @override
  AppCategoryScreenData copyWith({
    AppBarData? appBarData,
    String? name,
    CategoriesScreenLayoutType? layout,
    int? columns,
    StyledData? itemStyledData,
    bool? hideItemImage,
  }) {
    return AppCategoryScreenData(
      id: id,
      appBarData: appBarData ?? this.appBarData,
      name: name ?? this.name,
      columns: columns ?? this.columns,
      layout: layout ?? this.layout,
      itemStyledData: itemStyledData ?? this.itemStyledData,
      hideItemImage: hideItemImage ?? this.hideItemImage,
      screenType: screenType,
    );
  }
}
