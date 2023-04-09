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

import '../../../../../actions/actions.dart';

enum ScreenTileSectionType {
  // Profile screen tile information
  myOrders,
  wishlist,
  profileInformation,
  notifications,
  account,
  settings,
  darkMode,

  // Account screen tile information
  myPoints,
  downloads,
  shippingAddress,
  billingAddress,
  changePassword,
  deleteAccount,
  logout,

  // Setting screen tile information
  languages,
  contactUs,
  termsOfService,
  privacyPolicy,
  shareApp,
  aboutUs,

  /// Create new tile type
  custom,

  //
  undefined,
}

@immutable
class ScreenTileSectionData {
  final int id;
  final bool show;
  final ScreenTileSectionType type;
  final String name;
  final IconData iconData;
  final bool editIcon;
  final AppAction action;

  const ScreenTileSectionData({
    required this.id,
    required this.show,
    required this.type,
    required this.name,
    required this.iconData,
    this.editIcon = true,
    this.action = const NoAction(),
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'show': show,
      'type': type.name,
      'name': name,
      'iconData': serializeIcon(iconData),
      'editIcon': editIcon,
      'action': action.toMap(),
    };
  }

  factory ScreenTileSectionData.fromMap(Map<String, dynamic> map) {
    return ScreenTileSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      show: ModelUtils.createBoolProperty(map['show']),
      editIcon: ModelUtils.createBoolProperty(map['editIcon']),
      type: _getType(map['type']),
      name: ModelUtils.createStringProperty(map['name']),
      iconData: deserializeIcon(map['iconData']) ?? Icons.add,
      action: AppAction.createActionFromMap(map['action']),
    );
  }

  ScreenTileSectionData copyWith({
    bool? show,
    String? name,
    IconData? iconData,
    AppAction? action,
    ScreenTileSectionType? type,
  }) {
    return ScreenTileSectionData(
      id: id,
      type: type ?? this.type,
      editIcon: editIcon,
      name: name ?? this.name,
      show: show ?? this.show,
      iconData: iconData ?? this.iconData,
      action: action ?? this.action,
    );
  }

  static ScreenTileSectionType _getType(String? name) {
    switch (name) {
      case 'myOrders':
        return ScreenTileSectionType.myOrders;

      case 'wishlist':
        return ScreenTileSectionType.wishlist;

      case 'profileInformation':
        return ScreenTileSectionType.profileInformation;

      case 'notifications':
        return ScreenTileSectionType.notifications;

      case 'account':
        return ScreenTileSectionType.account;

      case 'settings':
        return ScreenTileSectionType.settings;

      case 'darkMode':
        return ScreenTileSectionType.darkMode;
      case 'myPoints':
        return ScreenTileSectionType.myPoints;

      case 'downloads':
        return ScreenTileSectionType.downloads;

      case 'shippingAddress':
        return ScreenTileSectionType.shippingAddress;

      case 'billingAddress':
        return ScreenTileSectionType.billingAddress;

      case 'changePassword':
        return ScreenTileSectionType.changePassword;

      case 'deleteAccount':
        return ScreenTileSectionType.deleteAccount;
      case 'logout':
        return ScreenTileSectionType.logout;

      case 'languages':
        return ScreenTileSectionType.languages;

      case 'contactUs':
        return ScreenTileSectionType.contactUs;

      case 'termsOfService':
        return ScreenTileSectionType.termsOfService;

      case 'privacyPolicy':
        return ScreenTileSectionType.privacyPolicy;

      case 'shareApp':
        return ScreenTileSectionType.shareApp;

      case 'aboutUs':
        return ScreenTileSectionType.aboutUs;

      case 'custom':
        return ScreenTileSectionType.custom;

      default:
        return ScreenTileSectionType.undefined;
    }
  }
}
