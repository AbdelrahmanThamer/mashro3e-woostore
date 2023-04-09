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
class AppHtmlScreenData extends AppScreenData {
  const AppHtmlScreenData({
    required int id,
    String name = 'Html',
    this.appBarData = const AppBarData(title: 'Html'),
    this.html = _defaultHtml,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.html,
        );

  final AppBarData appBarData;
  final String html;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'html': html,
    };
  }

  factory AppHtmlScreenData.fromMap(Map<String, dynamic> map) {
    return AppHtmlScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      html: ModelUtils.createStringProperty(map['html']),
      appBarData: AppBarData.fromMap(map['appBarData']),
    );
  }

  @override
  AppHtmlScreenData copyWith({
    String? name,
    String? html,
    AppBarData? appBarData,
  }) {
    return AppHtmlScreenData(
      id: id,
      name: name ?? this.name,
      html: html ?? this.html,
      appBarData: appBarData ?? this.appBarData,
    );
  }
}

const String _defaultHtml = '''
<h1>Heading</h1>
<h2>Sub Heading</h2>
<p>Description for the post</p>
<img src="https://dummyimage.com/600" />
    ''';
