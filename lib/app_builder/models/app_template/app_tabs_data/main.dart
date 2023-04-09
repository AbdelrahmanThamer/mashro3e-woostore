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
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import '../app_template.dart';

@immutable
class AppTabData {
  final int id;
  final String name;
  final AppScreenData appScreenData;
  final IconData iconData;
  final IconData activeIconData;

  const AppTabData({
    required this.id,
    required this.name,
    required this.appScreenData,
    required this.iconData,
    required this.activeIconData,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'appScreenData': appScreenData.toMap(),
      'iconData': serializeIcon(iconData),
      'activeIconData': serializeIcon(activeIconData)
    };
  }

  factory AppTabData.fromMap(Map<String, dynamic> map) {
    return AppTabData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      appScreenData: AppScreenData.fromMap(map['appScreenData']),
      iconData: deserializeIcon(map['iconData']) ?? Icons.add,
      activeIconData: deserializeIcon(map['activeIconData']) ?? Icons.add,
    );
  }

  AppTabData copyWith({
    int? id,
    String? name,
    AppScreenData? appScreenData,
    IconData? iconData,
    IconData? activeIconData,
  }) {
    return AppTabData(
      id: id ?? this.id,
      name: name ?? this.name,
      iconData: iconData ?? this.iconData,
      activeIconData: activeIconData ?? this.activeIconData,
      appScreenData: appScreenData ?? this.appScreenData,
    );
  }
}
