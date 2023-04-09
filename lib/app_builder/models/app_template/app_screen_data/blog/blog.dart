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
import 'package:flutter/material.dart';

import '../../../../app_builder.dart';

enum BlogScreenLayoutType {
  grid,
  list,
}

@immutable
class AppBlogScreenData extends AppScreenData {
  final AppBarData appBarData;
  final BlogScreenLayoutType layout;
  final int columns;
  final StyledData itemStyledData;
  final bool hideItemImage;

  const AppBlogScreenData({
    required int id,
    String name = 'Blog',
    this.appBarData = const AppBarData(),
    this.layout = BlogScreenLayoutType.list,
    this.columns = 2,
    this.itemStyledData = const StyledData(
      dimensionsData: DimensionsData(aspectRatio: 0.6),
      paddingData: PaddingData.all(5),
      marginData: MarginData.all(5),
      borderRadius: 10,
      textStyleData: TextStyleData(fontSize: 16),
    ),
    this.hideItemImage = false,
    AppScreenType screenType = AppScreenType.custom,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.blog,
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

  factory AppBlogScreenData.fromMap(Map<String, dynamic> map) {
    return AppBlogScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      columns: ModelUtils.createIntProperty(map['columns']),
      appBarData: AppBarData.fromMap(map['appBarData']),
      layout: _getLayout(map['layout']),
      itemStyledData: StyledData.fromMap(map['itemStyledData']),
      hideItemImage: ModelUtils.createBoolProperty(map['hideItemImage']),
    );
  }

  static BlogScreenLayoutType _getLayout(String? val) {
    switch (val) {
      case 'grid':
        return BlogScreenLayoutType.grid;
      case 'list':
        return BlogScreenLayoutType.list;
      default:
        return BlogScreenLayoutType.grid;
    }
  }

  @override
  AppBlogScreenData copyWith({
    AppBarData? appBarData,
    String? name,
    BlogScreenLayoutType? layout,
    int? columns,
    StyledData? itemStyledData,
    bool? hideItemImage,
  }) {
    return AppBlogScreenData(
      id: id,
      appBarData: appBarData ?? this.appBarData,
      name: name ?? this.name,
      columns: columns ?? this.columns,
      layout: layout ?? this.layout,
      itemStyledData: itemStyledData ?? this.itemStyledData,
      hideItemImage: hideItemImage ?? this.hideItemImage,
    );
  }
}
