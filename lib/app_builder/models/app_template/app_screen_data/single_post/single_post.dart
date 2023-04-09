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
class AppSinglePostScreenData extends AppScreenData {
  const AppSinglePostScreenData({
    required int id,
    String name = 'Single Post',
    this.appBarData = const AppBarData(title: 'Single Post'),
    this.postId = 0,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.singlePost,
        );

  final AppBarData appBarData;
  final int postId;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'appBarData': appBarData.toMap(),
      'postId': postId,
    };
  }

  factory AppSinglePostScreenData.fromMap(Map<String, dynamic> map) {
    return AppSinglePostScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      postId: ModelUtils.createIntProperty(map['postId']),
      appBarData: AppBarData.fromMap(map['appBarData']),
    );
  }

  @override
  AppSinglePostScreenData copyWith({
    String? name,
    AppBarData? appBarData,
    int? postId,
  }) {
    return AppSinglePostScreenData(
      id: id,
      name: name ?? this.name,
      postId: postId ?? this.postId,
      appBarData: appBarData ?? this.appBarData,
    );
  }
}
