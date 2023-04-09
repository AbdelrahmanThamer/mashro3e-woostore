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

import 'package:flutter/foundation.dart';

import 'launch/main.dart';
import 'navigation/main.dart';
import 'share/main.dart';
import 'tab_navigation/main.dart';

export 'launch/main.dart';
export 'navigation/main.dart';
export 'share/main.dart';
export 'tab_navigation/main.dart';

@immutable
class AppAction {
  const AppAction({required this.type});

  final AppActionType type;

  Map<String, dynamic> toMap() => {'type': type.name};

  static AppAction createActionFromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const NoAction();
    }

    final actionType = getActionType(map['type']);

    if (actionType == AppActionType.navigation) {
      return NavigationAction.fromMap(map);
    }

    if (actionType == AppActionType.navigateToAllProductsScreen) {
      return NavigateToAllProductsScreenAction.fromMap(map);
    }

    if (actionType == AppActionType.navigateToSingleProductScreen) {
      return NavigateToSingleProductScreenAction.fromMap(map);
    }

    if (actionType == AppActionType.navigateToSingleVendorScreen) {
      return NavigateToSingleVendorScreenAction.fromMap(map);
    }

    if (actionType == AppActionType.tabNavigation) {
      return TabNavigationAction.fromMap(map);
    }

    if (actionType == AppActionType.share) {
      return ShareAction.fromMap(map);
    }

    if (actionType == AppActionType.launch) {
      return LaunchAction.fromMap(map);
    }

    return AppAction(type: actionType);
  }

  static AppActionType getActionType(String? value) {
    switch (value) {
      case 'navigation':
        return AppActionType.navigation;
      case 'navigateToAllProductsScreen':
        return AppActionType.navigateToAllProductsScreen;
      case 'navigateToSingleProductScreen':
        return AppActionType.navigateToSingleProductScreen;
      case 'navigateToSingleVendorScreen':
        return AppActionType.navigateToSingleVendorScreen;
      case 'navigateToReviewScreen':
        return AppActionType.navigateToReviewScreen;
      case 'tabNavigation':
        return AppActionType.tabNavigation;
      case 'productLike':
        return AppActionType.productLike;
      case 'productShare':
        return AppActionType.productShare;
      case 'cartReload':
        return AppActionType.cartReload;
      case 'toggleThemeMode':
        return AppActionType.toggleThemeMode;
      case 'chooseLanguageBottomSheet':
        return AppActionType.chooseLanguageBottomSheet;
      case 'launchTermsOfService':
        return AppActionType.launchTermsOfService;
      case 'launchPrivacyPolicy':
        return AppActionType.launchPrivacyPolicy;
      case 'shareApp':
        return AppActionType.shareApp;
      case 'aboutUsDialog':
        return AppActionType.aboutUsDialog;
      case 'launch':
        return AppActionType.launch;
      case 'share':
        return AppActionType.share;
      case 'logout':
        return AppActionType.logout;
      case 'noAction':
        return AppActionType.noAction;
      case 'filterModal':
        return AppActionType.filterModal;
      case 'sortBottomSheet':
        return AppActionType.sortBottomSheet;
      case 'vendorInfo':
        return AppActionType.vendorInfo;

      default:
        return AppActionType.noAction;
    }
  }

  AppAction copyWith() {
    return AppAction(type: type);
  }

  static List<AppActionType> filterActions({
    List<AppActionType> exclude = const [],
  }) {
    if (exclude.isEmpty) {
      return AppActionType.values;
    }

    const List<AppActionType> temp = AppActionType.values;
    for (int i = 0; i < exclude.length; i++) {
      final o = exclude[i];
      temp.remove(o);
    }
    return temp;
  }
}

class NoAction extends AppAction {
  const NoAction() : super(type: AppActionType.noAction);
}

enum AppActionType {
  /// Navigate to a different screen
  navigation,
  navigateToAllProductsScreen,
  navigateToSingleProductScreen,
  navigateToSingleVendorScreen,
  navigateToReviewScreen,

  /// Change to a different tab
  tabNavigation,

  /// Like and share a product
  productLike,
  productShare,

  // Reload the cart
  cartReload,
  toggleThemeMode,
  chooseLanguageBottomSheet,
  launchTermsOfService,
  launchPrivacyPolicy,
  shareApp,
  aboutUsDialog,

  /// Launch any app based on the url input
  launch,

  /// Share anything
  share,

  /// Logs the user out of the application
  logout,

  /// Perform absolutely nothing
  noAction,

  /// Filters and sorting options
  filterModal,
  sortBottomSheet,

  /// Vendor info
  vendorInfo
}
