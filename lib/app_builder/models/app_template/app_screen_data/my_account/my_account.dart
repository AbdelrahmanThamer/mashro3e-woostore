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

@immutable
class AppMyAccountScreenData extends AppScreenData {
  const AppMyAccountScreenData({
    this.appBarData = const AppBarData(),
    int id = AppPrebuiltScreensId.myAccount,
    String name = AppPrebuiltScreensNames.myAccount,
    this.sections = defaultSectionsMyAccount,
    AppScreenType screenType = AppScreenType.custom,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.myAccount,
          screenType: screenType,
        );

  final List<ScreenTileSectionData> sections;
  final AppBarData appBarData;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'sections': sections.map((e) => e.toMap()).toList(),
      'appBarData': appBarData.toMap(),
    };
  }

  factory AppMyAccountScreenData.fromMap(Map<String, dynamic> map) {
    return AppMyAccountScreenData(
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
  AppMyAccountScreenData copyWith({
    String? name,
    List<ScreenTileSectionData>? sections,
    AppBarData? appBarData,
  }) {
    return AppMyAccountScreenData(
      id: id,
      name: name ?? this.name,
      sections: sections ?? this.sections,
      appBarData: appBarData ?? this.appBarData,
      screenType: screenType,
    );
  }
}

const List<ScreenTileSectionData> defaultSectionsMyAccount = [
  ScreenTileSectionData(
    id: 8,
    show: true,
    type: ScreenTileSectionType.myPoints,
    name: 'My Points',
    iconData: Icons.post_add_rounded,
    action: NavigationAction(
      navigationData: NavigationData(
        screenId: AppPrebuiltScreensId.points,
      ),
    ),
  ),
  ScreenTileSectionData(
    id: 9,
    show: true,
    type: ScreenTileSectionType.downloads,
    name: 'Downloads',
    iconData: EvaIcons.downloadOutline,
    action: NavigationAction(
      navigationData: NavigationData(
        screenId: AppPrebuiltScreensId.downloads,
      ),
    ),
  ),
  ScreenTileSectionData(
    id: 10,
    show: true,
    type: ScreenTileSectionType.shippingAddress,
    name: 'Shipping Address',
    iconData: Icons.local_shipping,
    action: NavigationAction(
      arguments: {'isShipping': true},
      navigationData: NavigationData(
        screenId: AppPrebuiltScreensId.address,
      ),
    ),
  ),
  ScreenTileSectionData(
    id: 11,
    show: true,
    type: ScreenTileSectionType.billingAddress,
    name: 'Billing Address',
    iconData: Icons.credit_card_rounded,
    action: NavigationAction(
      arguments: {'isShipping': false},
      navigationData: NavigationData(
        screenId: AppPrebuiltScreensId.address,
      ),
    ),
  ),
  ScreenTileSectionData(
    id: 12,
    show: true,
    type: ScreenTileSectionType.changePassword,
    name: 'Change Password',
    iconData: Icons.security,
    action: NavigationAction(
      navigationData: NavigationData(
        screenId: AppPrebuiltScreensId.changePassword,
      ),
    ),
  ),
  ScreenTileSectionData(
    id: 19,
    show: true,
    type: ScreenTileSectionType.logout,
    name: 'Login/Logout',
    iconData: Icons.login,
    action: AppAction(type: AppActionType.logout),
    editIcon: false,
  ),
];
