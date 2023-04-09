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
import 'package:flutter/foundation.dart';

import '../actions.dart';

@immutable
class TabNavigationAction extends AppAction {
  final TabNavigationData tabNavigationData;

  const TabNavigationAction({
    this.tabNavigationData = const TabNavigationData(),
  }) : super(type: AppActionType.tabNavigation);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'tabNavigationData': tabNavigationData.toMap(),
    };
  }

  factory TabNavigationAction.fromMap(Map<String, dynamic>? map) {
    try {
      if (map == null) {
        return const TabNavigationAction();
      }

      return TabNavigationAction(
        tabNavigationData: TabNavigationData.fromMap(map['tabNavigationData']),
      );
    } catch (_) {
      return const TabNavigationAction();
    }
  }

  @override
  TabNavigationAction copyWith({
    TabNavigationData? tabNavigationData,
    Map? arguments,
  }) {
    return TabNavigationAction(
      tabNavigationData: tabNavigationData ?? this.tabNavigationData,
    );
  }
}

class TabNavigationData {
  final int tabId;
  final String tabName;

  const TabNavigationData({
    this.tabId = -1,
    this.tabName = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'tabId': tabId,
      'tabName': tabName,
    };
  }

  factory TabNavigationData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const TabNavigationData();
    }

    return TabNavigationData(
      tabId: ModelUtils.createIntProperty(map['tabId']),
      tabName: ModelUtils.createStringProperty(map['tabName']),
    );
  }

  TabNavigationData copyWith({
    int? tabId,
    String? tabName,
  }) {
    return TabNavigationData(
      tabId: tabId ?? this.tabId,
      tabName: tabName ?? this.tabName,
    );
  }
}
