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

import '../../../../actions/actions.dart';
import '../../../app_bars/app_bars.dart';
import '../app_screen_data.dart';

@immutable
class AppSettingScreenData extends AppScreenData {
  const AppSettingScreenData({
    this.appBarData = const AppBarData(),
    int id = AppPrebuiltScreensId.setting,
    String name = AppPrebuiltScreensNames.setting,
    this.sections = defaultSectionsSetting,
    AppScreenType screenType = AppScreenType.custom,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.setting,
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

  factory AppSettingScreenData.fromMap(Map<String, dynamic> map) {
    return AppSettingScreenData(
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
  AppSettingScreenData copyWith({
    String? name,
    List<ScreenTileSectionData>? sections,
    AppBarData? appBarData,
  }) {
    return AppSettingScreenData(
      id: id,
      name: name ?? this.name,
      sections: sections ?? this.sections,
      appBarData: appBarData ?? this.appBarData,
      screenType: screenType,
    );
  }
}

const List<ScreenTileSectionData> defaultSectionsSetting = [
  ScreenTileSectionData(
    id: 13,
    show: true,
    type: ScreenTileSectionType.languages,
    name: 'Languages',
    iconData: Icons.language_rounded,
    action: AppAction(type: AppActionType.chooseLanguageBottomSheet),
  ),
  ScreenTileSectionData(
    id: 14,
    show: true,
    type: ScreenTileSectionType.contactUs,
    name: 'Contact Us',
    iconData: Icons.call,
    action: NavigationAction(
      navigationData: NavigationData(
        screenId: AppPrebuiltScreensId.contactUs,
      ),
    ),
  ),
  ScreenTileSectionData(
    id: 15,
    show: true,
    type: ScreenTileSectionType.termsOfService,
    name: 'Terms of service',
    iconData: Icons.miscellaneous_services_rounded,
    action: AppAction(type: AppActionType.launchTermsOfService),
  ),
  ScreenTileSectionData(
    id: 16,
    show: true,
    type: ScreenTileSectionType.privacyPolicy,
    name: 'Privacy Policy',
    iconData: Icons.lock,
    action: AppAction(type: AppActionType.launchPrivacyPolicy),
  ),
  ScreenTileSectionData(
    id: 17,
    show: true,
    type: ScreenTileSectionType.shareApp,
    name: 'Share App',
    iconData: Icons.share,
    action: AppAction(type: AppActionType.shareApp),
    editIcon: false,
  ),
  ScreenTileSectionData(
    id: 18,
    show: true,
    type: ScreenTileSectionType.aboutUs,
    name: 'About Us',
    iconData: Icons.info_outline_rounded,
    action: AppAction(type: AppActionType.aboutUsDialog),
  ),
];
