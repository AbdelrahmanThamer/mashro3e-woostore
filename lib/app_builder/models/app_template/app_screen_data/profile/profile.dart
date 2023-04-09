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
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../actions/actions.dart';
import '../../../app_bars/app_bars.dart';
import '../app_screen_data.dart';

export '../shared/tile_section_data/tile_section_data.dart';

@immutable
class AppProfileScreenData extends AppScreenData {
  const AppProfileScreenData({
    this.appBarData = const AppBarData(show: false),
    int id = AppPrebuiltScreensId.profile,
    String name = AppPrebuiltScreensNames.profile,
    this.sections = defaultSections,
    AppScreenType screenType = AppScreenType.custom,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.profile,
          screenType: screenType,
        );

  final AppBarData appBarData;
  final List<ScreenTileSectionData> sections;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'sections': sections.map((e) => e.toMap()).toList(),
      'appBarData': appBarData.toMap(),
    };
  }

  factory AppProfileScreenData.fromMap(Map<String, dynamic> map) {
    return AppProfileScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      sections: ModelUtils.createListOfType(
        map['sections'],
        (elem) => ScreenTileSectionData.fromMap(elem),
      ),
      screenType: AppScreenData.getScreenType(map['screenType']),
      appBarData: AppBarData.fromMap(map['appBarData']),
    );
  }

  @override
  AppProfileScreenData copyWith({
    String? name,
    List<ScreenTileSectionData>? sections,
    AppBarData? appBarData,
  }) {
    return AppProfileScreenData(
      id: id,
      name: name ?? this.name,
      sections: sections ?? this.sections,
      appBarData: appBarData ?? this.appBarData,
      screenType: screenType,
    );
  }
}

const List<ScreenTileSectionData> defaultSections = [
  ScreenTileSectionData(
    id: 1,
    show: true,
    type: ScreenTileSectionType.myOrders,
    name: 'My Orders',
    iconData: EvaIcons.inbox,
    action: NavigationAction(
      navigationData: NavigationData(
        screenId: AppPrebuiltScreensId.myOrders,
      ),
    ),
  ),
  ScreenTileSectionData(
    id: 2,
    show: true,
    type: ScreenTileSectionType.wishlist,
    name: 'Wishlist',
    iconData: EvaIcons.heart,
    action: NavigationAction(
      navigationData: NavigationData(
        screenId: AppPrebuiltScreensId.wishlist,
      ),
    ),
  ),
  ScreenTileSectionData(
    id: 3,
    show: true,
    type: ScreenTileSectionType.profileInformation,
    name: 'Profile Information',
    iconData: Icons.verified_user,
    action: NavigationAction(
      navigationData: NavigationData(
        screenId: AppPrebuiltScreensId.editProfile,
      ),
    ),
  ),
  ScreenTileSectionData(
    id: 4,
    show: true,
    type: ScreenTileSectionType.notifications,
    name: 'Notifications',
    iconData: Icons.notifications_active_rounded,
    action: NavigationAction(
      navigationData: NavigationData(
        screenId: AppPrebuiltScreensId.notification,
      ),
    ),
  ),
  ScreenTileSectionData(
    id: 5,
    show: true,
    type: ScreenTileSectionType.account,
    name: 'Account',
    iconData: Icons.account_box,
    action: NavigationAction(
      navigationData: NavigationData(
        screenId: AppPrebuiltScreensId.myAccount,
      ),
    ),
  ),
  ScreenTileSectionData(
    id: 6,
    show: true,
    type: ScreenTileSectionType.settings,
    name: 'Settings',
    iconData: EvaIcons.settings,
    action: NavigationAction(
      navigationData: NavigationData(
        screenId: AppPrebuiltScreensId.setting,
      ),
    ),
  ),
  ScreenTileSectionData(
    id: 7,
    show: true,
    type: ScreenTileSectionType.darkMode,
    name: 'Dark Mode',
    iconData: Icons.color_lens,
    action: AppAction(type: AppActionType.toggleThemeMode),
  ),
];
