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

import '../app_template.dart';

export '../app_template.dart';
export 'add_address/add_address.dart';
export 'address/address.dart';
export 'all_products/all_products.dart';
export 'all_vendors/all_vendors.dart';
export 'blog/blog.dart';
export 'cart/cart.dart';
export 'category/category.dart';
export 'change_password/change_password.dart';
export 'contact_us/contact_us.dart';
export 'downloads/downloads.dart';
export 'dynamic/dynamic.dart';
export 'edit_profile/edit_profile.dart';
export 'html/html.dart';
export 'login/login.dart';
export 'my_account/my_account.dart';
export 'my_orders/my_orders.dart';
export 'notification/notification.dart';
export 'on_boarding/on_boarding.dart';
export 'points/points.dart';
export 'product/product.dart';
export 'profile/profile.dart';
export 'review/review.dart';
export 'screens_pre_built_screen_config.dart';
export 'search/search.dart';
export 'setting/setting.dart';
export 'shared/dimensions_data/dimensions_data.dart';
export 'shared/item_list_config.dart';
export 'shared/product_list_config.dart';
export 'shared/vendor_card_layout_data/vendor_card_layout_data.dart';
export 'signup/signup.dart';
export 'single_post/single_post.dart';
export 'tags/tags.dart';
export 'vendor/vendor.dart';
export 'webpage/webpage.dart';
export 'wishlist/wishlist.dart';

enum AppScreenLayoutType {
  dynamic,
  category,
  cart,
  profile,
  search,
  html,
  blog,
  webpage,
  wishlist,
  singlePost,
  notification,
  myOrders,
  myAccount,
  setting,
  onBoarding,
  product,
  allProducts,
  addAddress,
  address,
  changePassword,
  contactUs,
  downloads,
  editProfile,
  login,
  points,
  review,
  signup,
  tags,
  vendor,
  allVendors,
  undefined,
}

enum AppScreenType {
  custom,
  preBuilt,
}

@immutable
abstract class AppScreenData {
  const AppScreenData({
    required this.id,
    required this.name,
    required this.appScreenLayoutType,
    this.screenType = AppScreenType.custom,
  });

  const AppScreenData.defaultEmpty()
      : id = -1,
        name = 'undefined',
        screenType = AppScreenType.custom,
        appScreenLayoutType = AppScreenLayoutType.undefined;

  final int id;
  final String name;
  final AppScreenLayoutType appScreenLayoutType;
  final AppScreenType screenType;

  factory AppScreenData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const EmptyScreenData();
    }
    try {
      final AppScreenLayoutType type =
          getScreenLayoutType(map['appScreenLayoutType']);

      if (type == AppScreenLayoutType.dynamic) {
        return AppDynamicScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.category) {
        return AppCategoryScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.cart) {
        return AppCartScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.profile) {
        return AppProfileScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.search) {
        return AppSearchScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.html) {
        return AppHtmlScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.blog) {
        return AppBlogScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.webpage) {
        return AppWebpageScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.wishlist) {
        return AppWishlistScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.singlePost) {
        return AppSinglePostScreenData.fromMap(map);
      }

      if (type == AppScreenLayoutType.notification) {
        return AppNotificationScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.myOrders) {
        return AppMyOrdersScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.myAccount) {
        return AppMyAccountScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.setting) {
        return AppSettingScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.onBoarding) {
        return AppOnBoardingScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.product) {
        return AppProductScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.allProducts) {
        return AppAllProductsScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.addAddress) {
        return AppAddAddressScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.address) {
        return AppAddressScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.changePassword) {
        return AppChangePasswordScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.contactUs) {
        return AppContactUsScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.downloads) {
        return AppDownloadsScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.editProfile) {
        return AppEditProfileScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.login) {
        return AppLoginScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.points) {
        return AppPointsScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.review) {
        return AppReviewScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.signup) {
        return AppSignupScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.tags) {
        return AppTagsScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.vendor) {
        return AppVendorScreenData.fromMap(map);
      }
      if (type == AppScreenLayoutType.allVendors) {
        return AppAllVendorsScreenData.fromMap(map);
      }

      return const EmptyScreenData();
    } catch (e, s) {
      Dev.error('AppScreenData.fromMap', error: e, stackTrace: s);
      return const EmptyScreenData();
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'appScreenLayoutType': appScreenLayoutType.name,
      'screenType': screenType.name,
    };
  }

  static AppScreenType getScreenType(String? value) {
    switch (value) {
      case 'custom':
        return AppScreenType.custom;
      case 'preBuilt':
        return AppScreenType.preBuilt;
      default:
        return AppScreenType.preBuilt;
    }
  }

  static AppScreenLayoutType getScreenLayoutType(String? value) {
    switch (value) {
      case 'dynamic':
        return AppScreenLayoutType.dynamic;
      case 'category':
        return AppScreenLayoutType.category;
      case 'cart':
        return AppScreenLayoutType.cart;
      case 'profile':
        return AppScreenLayoutType.profile;
      case 'search':
        return AppScreenLayoutType.search;
      case 'html':
        return AppScreenLayoutType.html;
      case 'blog':
        return AppScreenLayoutType.blog;
      case 'webpage':
        return AppScreenLayoutType.webpage;
      case 'wishlist':
        return AppScreenLayoutType.wishlist;
      case 'singlePost':
        return AppScreenLayoutType.singlePost;
      case 'notification':
        return AppScreenLayoutType.notification;
      case 'myOrders':
        return AppScreenLayoutType.myOrders;
      case 'myAccount':
        return AppScreenLayoutType.myAccount;
      case 'setting':
        return AppScreenLayoutType.setting;
      case 'onBoarding':
        return AppScreenLayoutType.onBoarding;
      case 'product':
        return AppScreenLayoutType.product;
      case 'allProducts':
        return AppScreenLayoutType.allProducts;
      case 'addAddress':
        return AppScreenLayoutType.addAddress;
      case 'address':
        return AppScreenLayoutType.address;
      case 'changePassword':
        return AppScreenLayoutType.changePassword;
      case 'contactUs':
        return AppScreenLayoutType.contactUs;
      case 'downloads':
        return AppScreenLayoutType.downloads;
      case 'editProfile':
        return AppScreenLayoutType.editProfile;
      case 'login':
        return AppScreenLayoutType.login;
      case 'points':
        return AppScreenLayoutType.points;
      case 'review':
        return AppScreenLayoutType.review;
      case 'signup':
        return AppScreenLayoutType.signup;
      case 'tags':
        return AppScreenLayoutType.tags;
      case 'vendor':
        return AppScreenLayoutType.vendor;
      case 'allVendors':
        return AppScreenLayoutType.allVendors;

      default:
        return AppScreenLayoutType.undefined;
    }
  }

  AppScreenData copyWith({
    String? name,
  });
}

@immutable
class EmptyScreenData extends AppScreenData {
  const EmptyScreenData() : super.defaultEmpty();

  @override
  AppScreenData copyWith({String? name}) {
    return const EmptyScreenData();
  }
}

@immutable
class NewAppScreenData extends AppScreenData {
  const NewAppScreenData({
    required int id,
    required String name,
    required AppScreenLayoutType appScreenLayoutType,
    AppScreenType type = AppScreenType.custom,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: appScreenLayoutType,
          screenType: type,
        );

  @override
  AppScreenData copyWith({
    String? name,
    AppScreenLayoutType? appScreenLayoutType,
  }) {
    return NewAppScreenData(
      id: id,
      name: name ?? this.name,
      appScreenLayoutType: appScreenLayoutType ?? this.appScreenLayoutType,
      type: screenType,
    );
  }
}
