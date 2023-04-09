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

import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import '../app_bars/app_bars.dart';
import 'app_template.dart';

const appTemplateWooStorePro = AppTemplate(
  id: 1,
  name: 'WooStore Pro - Ecommerce app',
  appTabs: defaultAppTabs,
  appScreens: defaultAppScreens,
);

const appTemplate2 = AppTemplate(
  id: 2,
  name: 'Default Template 2',
  appTabs: defaultAppTabs,
  appScreens: defaultAppScreens,
);
const appTemplate3 = AppTemplate(
  id: 3,
  name: 'Default Template 3',
  appTabs: defaultAppTabs,
  appScreens: defaultAppScreens,
);
//**********************************************************
// Default Data
//**********************************************************

const defaultAppTabs = [
  AppTabData(
    id: 1,
    name: 'Home',
    appScreenData: AppDynamicScreenData(id: 1),
    iconData: EvaIcons.homeOutline,
    activeIconData: EvaIcons.home,
  ),
  AppTabData(
    id: 2,
    name: 'Category',
    appScreenData: AppCategoryScreenData(
      name: 'Category',
      appBarData: AppBarData(),
      id: 2,
    ),
    iconData: EvaIcons.gridOutline,
    activeIconData: EvaIcons.grid,
  ),
  AppTabData(
    id: 3,
    name: 'Search',
    appScreenData: AppSearchScreenData(id: 3, name: 'Search'),
    iconData: EvaIcons.searchOutline,
    activeIconData: EvaIcons.search,
  ),
  AppTabData(
    id: 4,
    name: 'Cart',
    appScreenData: AppCartScreenData(id: 4),
    iconData: EvaIcons.shoppingCartOutline,
    activeIconData: EvaIcons.shoppingCart,
  ),
  AppTabData(
    id: 5,
    name: 'Profile',
    appScreenData: AppProfileScreenData(id: 5, name: 'Profile'),
    iconData: EvaIcons.personOutline,
    activeIconData: EvaIcons.person,
  ),
];

const List<AppScreenData> defaultAppScreens = [
  AppProductScreenData(),
  AppAllProductsScreenData(),
  AppOnBoardingScreenData(),
  AppCartScreenData(screenType: AppScreenType.preBuilt),
  AppCategoryScreenData(screenType: AppScreenType.preBuilt),
  AppMyAccountScreenData(screenType: AppScreenType.preBuilt),
  AppMyOrdersScreenData(screenType: AppScreenType.preBuilt),
  AppSettingScreenData(screenType: AppScreenType.preBuilt),
  AppProfileScreenData(
    screenType: AppScreenType.preBuilt,
    appBarData: AppBarData(show: true),
  ),
  AppTagsScreenData(screenType: AppScreenType.preBuilt),
  AppVendorScreenData(),
  AppAllVendorsScreenData(),
];
