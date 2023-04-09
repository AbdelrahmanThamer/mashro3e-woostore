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
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../actions/actions.dart';
import '../../../app_bars/app_bars.dart';
import '../app_screen_data.dart';
import 'customSectionData.dart';

@immutable
class AppDynamicScreenData extends AppScreenData {
  final AppBarData appBarData;
  final List<CustomSectionData> sections;

  const AppDynamicScreenData({
    required int id,
    String name = 'Dynamic',
    this.appBarData = const _DefaultScreenAppBar(),
    this.sections = const [],
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.dynamic,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'appBarData': appBarData.toMap(),
      'sections': sections.map((e) => e.toMap()).toList(),
    };
  }

  factory AppDynamicScreenData.fromMap(Map<String, dynamic> map) {
    return AppDynamicScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      appBarData: AppBarData.fromMap(map['appBarData']),
      sections: ModelUtils.createListOfType<CustomSectionData>(
          map['sections'], (elem) => CustomSectionData.fromMap(elem)),
    );
  }

  @override
  AppDynamicScreenData copyWith({
    AppBarData? appBarData,
    List<CustomSectionData>? sections,
    String? name,
  }) {
    return AppDynamicScreenData(
      appBarData: appBarData ?? this.appBarData,
      sections: sections ?? this.sections,
      name: name ?? this.name,
      id: id,
    );
  }
}

class _DefaultScreenAppBar extends AppBarData {
  const _DefaultScreenAppBar()
      : super(
          title: 'WooStore Pro',
          logo: null,
          floating: true,
          actionButtons: const [
            AppBarActionButtonData(
              id: 1,
              tooltip: 'Notification',
              iconData: Icons.notifications_active_rounded,
              action: NavigationAction(
                navigationData: NavigationData(
                  screenId: AppPrebuiltScreensId.notification,
                  screenName: 'Notification',
                ),
              ),
            ),
            AppBarActionButtonData(
              id: 2,
              tooltip: 'Cart',
              iconData: EvaIcons.shoppingCartOutline,
              action: NavigationAction(
                navigationData: NavigationData(
                  screenId: AppPrebuiltScreensId.cart,
                  screenName: 'Cart',
                ),
              ),
            ),
          ],
        );
}
