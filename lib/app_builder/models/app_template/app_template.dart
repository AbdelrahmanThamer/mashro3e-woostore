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

import '../models.dart';

export './app_screen_data/app_screen_data.dart';
export 'app_tabs_data/main.dart';
export 'default_app_templates.dart';

@immutable
class AppTemplate {
  final int id;
  final String name;
  final AppTemplateMetaData metaData;
  final AppConfigurationData appConfigurationData;
  final AppThemesData appThemes;
  final List<AppScreenData> appScreens;
  final List<AppTabData> appTabs;
  final ProductCardLayoutData globalProductCardLayout;
  final LoadingIconData globalLoadingIconData;
  final SocialLoginData socialLoginData;

  const AppTemplate({
    this.id = 0,
    this.metaData = const AppTemplateMetaData(),
    this.name = 'Default Template',
    this.appConfigurationData = const AppConfigurationData(),
    this.appThemes = const AppThemesData(),
    this.appScreens = defaultAppScreens,
    this.appTabs = defaultAppTabs,
    this.globalProductCardLayout = const ProductCardLayoutData(),
    this.globalLoadingIconData = const DefaultLoadingIconData(),
    this.socialLoginData = const SocialLoginData(),
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'appConfigurationData': appConfigurationData.toMap(),
      'appThemes': appThemes.toMap(),
      'appScreens': appScreens.map((e) => e.toMap()).toList(),
      'appTabs': appTabs.map((e) => e.toMap()).toList(),
      'globalProductCardLayout': globalProductCardLayout.toMap(),
      'globalLoadingIconData': globalLoadingIconData.toMap(),
      'socialLoginData': socialLoginData.toMap(),
      'metaData': metaData.toMap(),
    };
  }

  factory AppTemplate.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const AppTemplate();
    }

    return AppTemplate(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      metaData: AppTemplateMetaData.fromMap(map['metaData']),
      appConfigurationData:
          AppConfigurationData.fromMap(map['appConfigurationData']),
      appThemes: AppThemesData.fromMap(map['appThemes']),
      appScreens: ModelUtils.createListOfType<AppScreenData>(
        map['appScreens'],
        (e) => AppScreenData.fromMap(e),
      ),
      appTabs: ModelUtils.createListOfType(
        map['appTabs'],
        (e) => AppTabData.fromMap(e),
      ),
      globalProductCardLayout:
          ProductCardLayoutData.fromMap(map['globalProductCardLayout']),
      globalLoadingIconData:
          LoadingIconData.fromMap(map['globalLoadingIconData']),
      socialLoginData: SocialLoginData.fromMap(map['socialLoginData']),
    );
  }

  AppTemplate copyWith({
    int? id,
    String? name,
    AppConfigurationData? appConfigurationData,
    AppThemesData? appThemes,
    List<AppScreenData>? appScreens,
    List<AppTabData>? appTabs,
    ProductCardLayoutData? globalProductCardLayout,
    LoadingIconData? globalLoadingIconData,
    SocialLoginData? socialLoginData,
    AppTemplateMetaData? metaData,
  }) {
    return AppTemplate(
      id: id ?? this.id,
      name: name ?? this.name,
      metaData: metaData ?? this.metaData.update(),
      appConfigurationData: appConfigurationData ?? this.appConfigurationData,
      appThemes: appThemes ?? this.appThemes,
      appScreens: appScreens ?? this.appScreens,
      appTabs: appTabs ?? this.appTabs,
      globalProductCardLayout:
          globalProductCardLayout ?? this.globalProductCardLayout,
      globalLoadingIconData:
          globalLoadingIconData ?? this.globalLoadingIconData,
      socialLoginData: socialLoginData ?? this.socialLoginData,
    );
  }
}

@immutable
class AppTemplateMetaData {
  final int createdTimeStamp;

  final int lastModified;
  final String displayImage;

  const AppTemplateMetaData({
    this.createdTimeStamp = 0,
    this.lastModified = 0,
    this.displayImage = '',
  });

  AppTemplateMetaData copyWith({
    String? displayImage,
  }) {
    return AppTemplateMetaData(
      createdTimeStamp: createdTimeStamp,
      lastModified: DateTime.now().millisecondsSinceEpoch,
      displayImage: displayImage ?? this.displayImage,
    );
  }

  AppTemplateMetaData update() {
    return AppTemplateMetaData(
      createdTimeStamp: createdTimeStamp,
      lastModified: DateTime.now().millisecondsSinceEpoch,
      displayImage: displayImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdTimeStamp': createdTimeStamp,
      'lastModified': lastModified,
      'displayImage': displayImage,
    };
  }

  factory AppTemplateMetaData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const AppTemplateMetaData();
    }
    return AppTemplateMetaData(
      createdTimeStamp: ModelUtils.createIntProperty(map['createdTimeStamp']),
      lastModified: ModelUtils.createIntProperty(map['lastModified']),
      displayImage: ModelUtils.createStringProperty(map['displayImage']),
    );
  }

  factory AppTemplateMetaData.createNew({String displayImage = ''}) {
    return AppTemplateMetaData(
      createdTimeStamp: DateTime.now().millisecondsSinceEpoch,
      lastModified: DateTime.now().millisecondsSinceEpoch,
      displayImage: displayImage,
    );
  }
}
